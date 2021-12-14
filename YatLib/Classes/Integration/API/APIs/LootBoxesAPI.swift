// LootBoxesAPI.swift

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

public final class LootBoxesAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Create a new lootbox
    public func createLootboxPublisher(body: AdminNewLootBoxBody) -> AnyPublisher<PublicLootBox, APIError> {

        let path = "/lootboxes"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Create a new lootbox
    public func createLootbox(body: AdminNewLootBoxBody, result: @escaping (Result<PublicLootBox, APIError>) -> Void) {
        createLootboxPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Delete a lootbox
    public func deleteLootboxPublisher(id: UUID) -> AnyPublisher<PublicLootBox, APIError> {

        let pathTemplate = "/lootboxes/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Delete a lootbox
    public func deleteLootbox(id: UUID, result: @escaping (Result<PublicLootBox, APIError>) -> Void) {
        deleteLootboxPublisher(id: id)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Fetch lootboxes
    public func listLootboxesPublisher(dir: String?, limit: Int?, ownerId: UUID?, page: Int?, sort: String?, status: String?) -> AnyPublisher<ListOfPublicLootBox, APIError> {

        let path = "/lootboxes"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Fetch lootboxes
    public func listLootboxes(dir: String?, limit: Int?, ownerId: UUID?, page: Int?, sort: String?, status: String?, result: @escaping (Result<ListOfPublicLootBox, APIError>) -> Void) {
        listLootboxesPublisher(dir: dir, limit: limit, ownerId: ownerId, page: page, sort: sort, status: status)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Open lootbox
    public func openLootboxPublisher(id: UUID) -> AnyPublisher<PublicLootBox, APIError> {

        let pathTemplate = "/lootboxes/{id}/open"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Open lootbox
    public func openLootbox(id: UUID, result: @escaping (Result<PublicLootBox, APIError>) -> Void) {
        openLootboxPublisher(id: id)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Show information about lootbox
    public func showLootboxPublisher(id: UUID) -> AnyPublisher<PublicLootBox, APIError> {

        let pathTemplate = "/lootboxes/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Show information about lootbox
    public func showLootbox(id: UUID, result: @escaping (Result<PublicLootBox, APIError>) -> Void) {
        showLootboxPublisher(id: id)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Update a lootbox
    public func updateLootboxPublisher(id: UUID, body: AdminUpdateLootBoxBody) -> AnyPublisher<PublicLootBox, APIError> {

        let pathTemplate = "/lootboxes/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .patch, body: body)
    }
    
    /// Update a lootbox
    public func updateLootbox(id: UUID, body: AdminUpdateLootBoxBody, result: @escaping (Result<PublicLootBox, APIError>) -> Void) {
        updateLootboxPublisher(id: id, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
