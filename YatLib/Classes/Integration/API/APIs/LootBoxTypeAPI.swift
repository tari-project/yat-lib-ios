// LootBoxTypeAPI.swift

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

public final class LootBoxTypeAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Create a new lootbox category
    public func createTypePublisher(body: AdminNewLootBoxType) -> AnyPublisher<PublicLootBoxType, APIError> {

        let path = "/lootbox_type"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Create a new lootbox category
    public func createType(body: AdminNewLootBoxType, result: @escaping (Result<PublicLootBoxType, APIError>) -> Void) {
        createTypePublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Generates a set of loot boxes
    public func generateLootBoxesPublisher(body: LootBoxGenerationRequest) -> AnyPublisher<LootBoxSet, APIError> {

        let path = "/lootbox_type/generate"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Generates a set of loot boxes
    public func generateLootBoxes(body: LootBoxGenerationRequest, result: @escaping (Result<LootBoxSet, APIError>) -> Void) {
        generateLootBoxesPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// List all loot box categories
    public func getTypesPublisher() -> AnyPublisher<[PublicLootBoxType], APIError> {

        let path = "/lootbox_type"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// List all loot box categories
    public func getTypes(result: @escaping (Result<[PublicLootBoxType], APIError>) -> Void) {
        getTypesPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
