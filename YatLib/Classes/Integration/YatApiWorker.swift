//  YatApiWorker.swift
	
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

public final class YatApiWorker {
    
    // MARK: - Properties
    
    private let apiManager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()
    
    // MARK: - GET /emoji_id/{eid}/{symbol}
    
    public func fetchRecords(forEmojiID emojiID: String, symbol: String, result: @escaping (Result<LookupEmojiIDWithSymbolResponse, APIError>) -> Void) {
        fetchRecordsPublisher(forEmojiID: emojiID, symbol: symbol)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }
    
    public func fetchRecordsPublisher(forEmojiID emojiID: String, symbol: String) -> AnyPublisher<LookupEmojiIDWithSymbolResponse, APIError> {
        apiManager.perform(request: LookupEmojiIDWithSymbolRequest(emojiID: emojiID, symbol: symbol))
    }
    
    // MARK: - GET /emoji_id/{eid}/json/{key}
    
    public func fetchFromKeyValueStore<T: LoadJsonDataContainer>(forEmojiID emojiID: String, dataType: T.Type, result: @escaping (Result<LoadJsonResponse<T>, APIError>) -> Void) {
        fetchFromKeyValueStorePublisher(forEmojiID: emojiID, dataType: dataType)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }
    
    public func fetchFromKeyValueStorePublisher<T: LoadJsonDataContainer>(forEmojiID emojiID: String, dataType: T.Type) -> AnyPublisher<LoadJsonResponse<T>, APIError> {
        apiManager.perform(request: LoadValueFromKeyValueStoreRequest(emojiID: emojiID, key: T.key))
    }
    
    // MARK: - Helpers
    
    private func handle<T: Decodable>(completion: Subscribers.Completion<APIError>, result: (Result<T, APIError>) -> Void) {
        guard case let .failure(error) = completion else { return }
        result(.failure(error))
    }
}
