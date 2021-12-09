// UserAuthenticationAPI.swift

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

import Combine

public final class UserAuthenticationAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Login via password
    public func loginPublisher(body: LoginRequest) -> AnyPublisher<TokenResponse, APIError> {

        let path = "/auth/token"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Login via password
    public func login(body: LoginRequest, result: @escaping (Result<TokenResponse, APIError>) -> Void) {
        loginPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Invalidates all user's access tokens
    public func logoutPublisher() -> AnyPublisher<EmptyAPIModel, APIError> {

        let path = "/logout"
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Invalidates all user's access tokens
    public func logout(result: @escaping (Result<EmptyAPIModel, APIError>) -> Void) {
        logoutPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Generate magic link for login
    public func magicLinkLoginPublisher(body: MagicLinkLoginRequest) -> AnyPublisher<MagicLinkLoginResponse, APIError> {

        let path = "/auth/magic_link"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Generate magic link for login
    public func magicLinkLogin(body: MagicLinkLoginRequest, result: @escaping (Result<MagicLinkLoginResponse, APIError>) -> Void) {
        magicLinkLoginPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Refresh access token
    public func refreshTokenPublisher(body: RefreshRequest) -> AnyPublisher<TokenResponse, APIError> {

        let path = "/auth/token/refresh"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Refresh access token
    public func refreshToken(body: RefreshRequest, result: @escaping (Result<TokenResponse, APIError>) -> Void) {
        refreshTokenPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Two factor authentication
    public func twoFactorAuthenticationPublisher(body: Confirm2Fa) -> AnyPublisher<TokenResponse, APIError> {

        let path = "/auth/2fa"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Two factor authentication
    public func twoFactorAuthentication(body: Confirm2Fa, result: @escaping (Result<TokenResponse, APIError>) -> Void) {
        twoFactorAuthenticationPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
