// KeyManagementAPI.swift

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

public final class KeyManagementAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Add pubkey for current user
    public func addPubkeyPublisher(pubkey: String) -> AnyPublisher<String, APIError> {

        let pathTemplate = "/pubkeys/{pubkey}"
        let pathComponents: [String: Any] = [
            "{pubkey}": pubkey
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Add pubkey for current user
    public func addPubkey(pubkey: String, result: @escaping (Result<String, APIError>) -> Void) {
        addPubkeyPublisher(pubkey: pubkey)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Add pubkey for user by user_id
    public func addPubkeyForUserPublisher(userId: String, pubkey: UUID) -> AnyPublisher<String, APIError> {

        let pathTemplate = "/users/{user_id}/pubkeys/{pubkey}"
        let pathComponents: [String: Any] = [
            "{user_id}": userId, 
            "{pubkey}": pubkey
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Add pubkey for user by user_id
    public func addPubkeyForUser(userId: String, pubkey: UUID, result: @escaping (Result<String, APIError>) -> Void) {
        addPubkeyForUserPublisher(userId: userId, pubkey: pubkey)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Generate custodial wallet
    public func createWalletPublisher() -> AnyPublisher<String, APIError> {

        let path = "/pubkeys"
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Generate custodial wallet
    public func createWallet(result: @escaping (Result<String, APIError>) -> Void) {
        createWalletPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Retrieve pubkeys
    public func getPubkeysPublisher() -> AnyPublisher<[String], APIError> {

        let path = "/pubkeys"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Retrieve pubkeys
    public func getPubkeys(result: @escaping (Result<[String], APIError>) -> Void) {
        getPubkeysPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Retrieve pubkeys by user_id
    public func getPubkeysForUserPublisher(userId: UUID) -> AnyPublisher<[String], APIError> {

        let pathTemplate = "/users/{user_id}/pubkeys"
        let pathComponents: [String: Any] = [
            "{user_id}": userId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Retrieve pubkeys by user_id
    public func getPubkeysForUser(userId: UUID, result: @escaping (Result<[String], APIError>) -> Void) {
        getPubkeysForUserPublisher(userId: userId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
