// UsersAPI.swift

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

public final class UsersAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Disable choosen 2FA provider or disable completely using backup code and user primary ID
    public func backupDisable2FAPublisher(body: BackupDisableBody) -> AnyPublisher<SuccessResponse, APIError> {

        let path = "/account/2fa/backup_disable"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Disable choosen 2FA provider or disable completely using backup code and user primary ID
    public func backupDisable2FA(body: BackupDisableBody, result: @escaping (Result<SuccessResponse, APIError>) -> Void) {
        backupDisable2FAPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Confirm two factor authentication update
    public func confirm2FAPublisher(body: Confirm2FaUpdate) -> AnyPublisher<SuccessResponse, APIError> {

        let path = "/account/2fa/confirm"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Confirm two factor authentication update
    public func confirm2FA(body: Confirm2FaUpdate, result: @escaping (Result<SuccessResponse, APIError>) -> Void) {
        confirm2FAPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Register a User
    public func createUserPublisher(body: RegisterUserParameters) -> AnyPublisher<TokenResponse, APIError> {

        let path = "/users"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Register a User
    public func createUser(body: RegisterUserParameters, result: @escaping (Result<TokenResponse, APIError>) -> Void) {
        createUserPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Delete a user
    public func deleteUserPublisher(id: UUID) -> AnyPublisher<DisplayUser, APIError> {

        let pathTemplate = "/users/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Delete a user
    public func deleteUser(id: UUID, result: @escaping (Result<DisplayUser, APIError>) -> Void) {
        deleteUserPublisher(id: id)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Disable choosen 2FA provider or disable completely
    public func disable2FAPublisher(body: Disable2FABody) -> AnyPublisher<SuccessResponse, APIError> {

        let path = "/account/2fa/disable"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Disable choosen 2FA provider or disable completely
    public func disable2FA(body: Disable2FABody, result: @escaping (Result<SuccessResponse, APIError>) -> Void) {
        disable2FAPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Enables two factor authentication method
    public func enable2FAPublisher(body: Enable2FABody) -> AnyPublisher<Enable2FAResponse, APIError> {

        let path = "/account/2fa/enable"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Enables two factor authentication method
    public func enable2FA(body: Enable2FABody, result: @escaping (Result<Enable2FAResponse, APIError>) -> Void) {
        enable2FAPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Current user account
    public func getAccountPublisher() -> AnyPublisher<CurrentUser, APIError> {

        let path = "/account"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Current user account
    public func getAccount(result: @escaping (Result<CurrentUser, APIError>) -> Void) {
        getAccountPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// List users
    public func getAllUsersPublisher(dir: String?, limit: Int?, page: Int?, sort: String?) -> AnyPublisher<ListOfDisplayUserExtended, APIError> {

        let path = "/users"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// List users
    public func getAllUsers(dir: String?, limit: Int?, page: Int?, sort: String?, result: @escaping (Result<ListOfDisplayUserExtended, APIError>) -> Void) {
        getAllUsersPublisher(dir: dir, limit: limit, page: page, sort: sort)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Load user data for a session
    public func loadPublisher(organizationId: UUID?, userId: UUID?) -> AnyPublisher<LoadUser, APIError> {

        let path = "/account/load"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Load user data for a session
    public func load(organizationId: UUID?, userId: UUID?, result: @escaping (Result<LoadUser, APIError>) -> Void) {
        loadPublisher(organizationId: organizationId, userId: userId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Send SMS 2FA code
    public func send2FASmsPublisher() -> AnyPublisher<SuccessResponse2FA, APIError> {

        let path = "/account/2fa/sms_code"
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Send SMS 2FA code
    public func send2FASms(result: @escaping (Result<SuccessResponse2FA, APIError>) -> Void) {
        send2FASmsPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Show users
    public func showUserPublisher(id: UUID) -> AnyPublisher<DisplayUserExtended, APIError> {

        let pathTemplate = "/users/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Show users
    public func showUser(id: UUID, result: @escaping (Result<DisplayUserExtended, APIError>) -> Void) {
        showUserPublisher(id: id)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Update the currently logged in user
    public func updateAccountPublisher(body: UpdateUserParameters) -> AnyPublisher<UpdateAccountResponse, APIError> {

        let path = "/account"
        
        return manager.perform(path: path, method: .patch, body: body)
    }
    
    /// Update the currently logged in user
    public func updateAccount(body: UpdateUserParameters, result: @escaping (Result<UpdateAccountResponse, APIError>) -> Void) {
        updateAccountPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Update a user as an admin
    public func updateUserByAdminPublisher(id: UUID, body: AdminUpdateUserParameters) -> AnyPublisher<DisplayUser, APIError> {

        let pathTemplate = "/users/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .patch, body: body)
    }
    
    /// Update a user as an admin
    public func updateUserByAdmin(id: UUID, body: AdminUpdateUserParameters, result: @escaping (Result<DisplayUser, APIError>) -> Void) {
        updateUserByAdminPublisher(id: id, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
