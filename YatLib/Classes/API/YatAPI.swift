/*
    Copyright 2021 The Tari Project

    Redistribution and use in source and binary forms, with or
    without modification, are permitted provided that the
    following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above
    copyright notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of
    its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
    OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation

struct YatAPIError: LocalizedError {
    
    let errorDescription: String
    
}

class YatAPI {
    
    static let yatWebAppBaseURL = "https://dev.yat.rocks"
    static let yatAPIBaseURL = "https://api-dev.yat.rocks"
    static let activationAPIBaseURL = "https://partner.scratch.emojid.me"
    static let signingAPIBaseURL = "https://partner-aurora.emojid.me"
    static let termsURL = "https://pre-waitlist.y.at/terms"
    
    private(set) static var credentials: YatCredentials!
    
    static let shared = YatAPI()
    
    private init() {
        
    }
    
    private enum RequestMethod: String {
        case post = "POST"
        case get = "GET"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    private func request(url: String,
                         method: RequestMethod,
                         parameters: [String: Any]? = nil,
                         accessToken: String? = nil,
                         onSuccess: @escaping (_: [String: Any]?) -> Void,
                         onError: @escaping (_: Error?) -> Void) {
        // create post request
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.setValue(YatLib.appConfig.authToken, forHTTPHeaderField: "X-Bypass-Token")
        if let accessToken = accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            guard let data = data, error == nil else {
                onError(nil)
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(
                with: data,
                options: []
            )
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
                onError(nil)
                return
            }
            onSuccess(responseJSON as? [String: Any])
        }
        task.resume()
    }
    
    func getRandomYatAndAddToCart(
        onSuccess: @escaping (_: YatOrder) -> Void,
        onError: @escaping (_: Error) -> Void
    ) {
        authenticateUser(
            onSuccess: {
                [weak self]
                (credentials) in
                print("Authentication ok.")
                YatAPI.credentials = credentials
                // check cart
                self?.clearCart(
                    onSuccess: {
                        print("Clear cart ok.")
                        self?.signMessage(
                            onSuccess: {
                                [weak self]
                                (signature) in
                                print("Message signing ok.")
                                self?.addRandomCartToYat(
                                    nonce: signature.nonce,
                                    signature: signature.signature,
                                    onSuccess: {
                                        (order) in
                                        print("Random Yat added to cart.")
                                        onSuccess(order)
                                    },
                                    onError: {
                                        (error) in onError(error)
                                    }
                                )
                            },
                            onError: {
                                (error) in
                                onError(error)
                            })
                    }, onError: {
                        (error) in
                        onError(error)
                    }
                )
            },
            onError: {
                [weak self]
                (error) in
                self?.registerUser() {
                    [weak self]
                    (user) in
                    print("Registration ok.")
                    self?.activateUser(
                        user: user,
                        onSuccess: {
                            [weak self] in
                            print("Activation ok.")
                            self?.getRandomYatAndAddToCart(
                                onSuccess: onSuccess,
                                onError: onError
                            )
                        },
                        onError: {
                            (error) in
                            onError(error)
                        }
                    )
                } onError: {
                    (error) in
                    onError(error)
                }
            }
        )
    }
    
    private func registerUser(
        onSuccess: @escaping (_: YatUser) -> Void,
        onError: @escaping (_: Error) -> Void
    ) {
        guard let source = YatLib.appConfig?.sourceName else {
            fatalError("Application source name not set.")
        }
        guard let alternateId = YatLib.userAlternateId else {
            fatalError("User alternate id not set.")
        }
        guard let password = YatLib.userPassword else {
            fatalError("User password not set.")
        }
        
        let parameters: [String: Any] = [
            "alternate_id": alternateId,
            "password": password,
            "source": source
        ]
        request(
            url: YatAPI.yatAPIBaseURL + "/users",
            method: .post,
            parameters: parameters
        ) {
            (responseJSON) in
            guard let responseJSON = responseJSON,
                  let registrationResponse = YatRegistrationResponse(JSON: responseJSON) else {
                onError(
                    YatAPIError(
                        errorDescription: "Invalid data returned from the user registration endpoint."
                    )
                )
                return
            }
            onSuccess(registrationResponse.user)
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "User registration error."
                )
            )
        }
    }
    
    private func activateUser(user: YatUser,
                              onSuccess: @escaping () -> Void,
                              onError: @escaping (_: Error) -> Void) {
        guard !user.isActive else {
            onSuccess()
            return
        }
        request(
            url: YatAPI.activationAPIBaseURL + "/activate/\(user.id)",
            method: .post
        ) {
            (_) in
            onSuccess()
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "User activation error."
                )
            )
        }
    }
    
    private func authenticateUser(onSuccess: @escaping (_: YatCredentials) -> Void,
                          onError: @escaping (_: Error) -> Void) {
        guard let alternateId = YatLib.userAlternateId else {
            fatalError("User alternate id not set.")
        }
        guard let password = YatLib.userPassword else {
            fatalError("User password set.")
        }
        let parameters: [String: Any] = [
            "alternate_id": alternateId,
            "password": password
        ]
        request(
            url: YatAPI.yatAPIBaseURL + "/auth/token",
            method: .post,
            parameters: parameters
        ) {
            (credentialsJSON) in
            guard let credentialsJSON = credentialsJSON,
                  let credentials = YatCredentials(JSON: credentialsJSON) else {
                onError(
                    YatAPIError(
                        errorDescription: "Invalid data returned from the authentication endpoint."
                    )
                )
                return
            }
            onSuccess(credentials)
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "User authentication error."
                )
            )
        }

    }
    
    private func signMessage(onSuccess: @escaping (_: YatSignMessageResponse) -> Void,
                     onError: @escaping (_: Error) -> Void) {
        guard let alternateId = YatLib.userAlternateId else {
            fatalError("User alternate id not set.")
        }
        let parameters: [String: Any] = [
            "alternate_id": alternateId
        ]
        request(
            url: YatAPI.signingAPIBaseURL + "/sign",
            method: .post,
            parameters: parameters
        ) {
            (signatureJSON) in
            guard let signatureJSON = signatureJSON,
                  let signature = YatSignMessageResponse(JSON: signatureJSON) else {
                onError(
                    YatAPIError(
                        errorDescription: "Invalid data returned from the signing endpoint."
                    )
                )
                return
            }
            onSuccess(signature)
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "User authentication error."
                )
            )
        }
    }
    
    func clearCart(
        onSuccess: @escaping () -> Void,
        onError: @escaping (_: Error) -> Void
    ) {
        guard let credentials = YatAPI.credentials else {
            onError(YatAPIError(errorDescription: "Credentials not set."))
            return
        }
        request(
            url: YatAPI.yatAPIBaseURL + "/cart",
            method: .delete,
            accessToken: credentials.accessToken) {
            (_) in
            onSuccess()
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "Clear cart error."
                )
            )
        }
    }
    
    private func addRandomCartToYat(
        nonce: String,
        signature: String,
        onSuccess: @escaping (_: YatOrder) -> Void,
        onError: @escaping (_: Error) -> Void
    ) {
        guard let accessToken = YatAPI.credentials?.accessToken else {
            onError(YatAPIError(errorDescription: "Credentials not set."))
            return
        }
        guard let appPubKey = YatLib.appConfig?.pubKey else {
            fatalError("Application public key not set.")
        }
        guard let appCode = YatLib.appConfig?.code else {
            fatalError("Application code not set.")
        }
        let parameters: [String: Any] = [
            "nonce": nonce,
            "signature": signature,
            "pubkey": appPubKey
        ]
        request(
            url: YatAPI.yatAPIBaseURL + "/codes/\(appCode)/random_yat",
            method: .post,
            parameters: parameters,
            accessToken: accessToken
        ) {
            (orderJSON) in
            guard let orderJSON = orderJSON,
                  let order = YatOrder(JSON: orderJSON) else {
                onError(
                    YatAPIError(
                        errorDescription: "Invalid data returned from the random Yat endpoint."
                    )
                )
                return
            }
            onSuccess(order)
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "User authentication error."
                )
            )
        }
    }
    
    func checkout(
        onSuccess: @escaping (_: YatOrder) -> Void,
        onError: @escaping (_: Error) -> Void
    ) {
        guard let accessToken = YatAPI.credentials?.accessToken else {
            onError(YatAPIError(errorDescription: "Credentials not set."))
            return
        }
        request(
            url: YatAPI.yatAPIBaseURL + "/cart/checkout",
            method: .post,
            parameters: ["method": "Free"],
            accessToken: accessToken
        ) {
            (orderJSON) in
            guard let orderJSON = orderJSON,
                  let order = YatOrder(JSON: orderJSON) else {
                onError(
                    YatAPIError(
                        errorDescription: "Invalid data returned from the random Yat endpoint."
                    )
                )
                return
            }
            onSuccess(order)
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "Checkout error."
                )
            )
        }
    }
    
    func updateYat(
        yat: String,
        updateRequest: YatUpdateRequest,
        onSuccess: @escaping () -> Void,
        onError: @escaping (_: Error) -> Void
    ) {
        guard let accessToken = YatAPI.credentials?.accessToken else {
            onError(YatAPIError(errorDescription: "Credentials not set."))
            return
        }
        let yatPercentEncoded = yat.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        request(
            url: (YatAPI.yatAPIBaseURL + "/emoji_id/\(yatPercentEncoded)"),
            method: .patch,
            parameters: updateRequest.toJSON(),
            accessToken: accessToken
        ) {
            (_) in
            onSuccess()
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "Checkout error."
                )
            )
        }
    }
    
    func lookupYat(
        yat: String,
        onSuccess: @escaping (_: YatLookupResponse) -> Void,
        onError: @escaping (_: Error) -> Void
    ) {
        let yatPercentEncoded = yat.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        request(
            url: YatAPI.yatAPIBaseURL + "/emoji_id/\(yatPercentEncoded)",
            method: .get
        ) {
            (lookupResponseJSON) in
            guard let lookupResponseJSON = lookupResponseJSON,
                  let lookupResponse = YatLookupResponse(JSON: lookupResponseJSON) else {
                onError(
                    YatAPIError(
                        errorDescription: "Invalid data returned from the Yat lookup endpoint."
                    )
                )
                return
            }
            onSuccess(lookupResponse)
        } onError: {
            (error) in
            onError(
                error ?? YatAPIError(
                    errorDescription: "Lookup error."
                )
            )
        }
    }
    
}
