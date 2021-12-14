// DiscountsAPI.swift

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

public final class DiscountsAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Use random yat code
    public func activateRandomYatCodePublisher(codeId: UUID, body: RandomYatActivateBody) -> AnyPublisher<DisplayOrder, APIError> {

        let pathTemplate = "/codes/{code_id}/random_yat"
        let pathComponents: [String: Any] = [
            "{code_id}": codeId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Use random yat code
    public func activateRandomYatCode(codeId: UUID, body: RandomYatActivateBody, result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        activateRandomYatCodePublisher(codeId: codeId, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Add pubkey for code
    public func addPubkeyForCodePublisher(codeId: UUID, pubkey: String) -> AnyPublisher<String, APIError> {

        let pathTemplate = "/codes/{code_id}/pubkeys/{pubkey}"
        let pathComponents: [String: Any] = [
            "{code_id}": codeId, 
            "{pubkey}": pubkey
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Add pubkey for code
    public func addPubkeyForCode(codeId: UUID, pubkey: String, result: @escaping (Result<String, APIError>) -> Void) {
        addPubkeyForCodePublisher(codeId: codeId, pubkey: pubkey)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Fetch codes
    public func listCodesPublisher(codeType: String?, dir: String?, limit: Int?, organizationId: UUID?, page: Int?, sort: String?) -> AnyPublisher<ListOfCodeAvailability, APIError> {

        let path = "/codes"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Fetch codes
    public func listCodes(codeType: String?, dir: String?, limit: Int?, organizationId: UUID?, page: Int?, sort: String?, result: @escaping (Result<ListOfCodeAvailability, APIError>) -> Void) {
        listCodesPublisher(codeType: codeType, dir: dir, limit: limit, organizationId: organizationId, page: page, sort: sort)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Revoke pubkey for code
    public func revokePubkeyForCodePublisher(codeId: UUID, pubkey: String) -> AnyPublisher<String, APIError> {

        let pathTemplate = "/codes/{code_id}/pubkeys/{pubkey}"
        let pathComponents: [String: Any] = [
            "{code_id}": codeId, 
            "{pubkey}": pubkey
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Revoke pubkey for code
    public func revokePubkeyForCode(codeId: UUID, pubkey: String, result: @escaping (Result<String, APIError>) -> Void) {
        revokePubkeyForCodePublisher(codeId: codeId, pubkey: pubkey)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
