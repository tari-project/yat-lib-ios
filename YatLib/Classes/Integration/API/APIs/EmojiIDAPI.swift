// EmojiIDAPI.swift

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

public final class EmojiIDAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Edit EmojiId
    public func editEmojiIDPublisher(emojiId: String, body: EditRequest) -> AnyPublisher<Data, APIError> {

        let pathTemplate = "/emoji_id/{emoji_id}"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .patch, body: body)
    }
    
    /// Edit EmojiId
    public func editEmojiID(emojiId: String, body: EditRequest, result: @escaping (Result<Data, APIError>) -> Void) {
        editEmojiIDPublisher(emojiId: emojiId, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// 
    public func emojiIDMetadataPublisher(emojiId: String) -> AnyPublisher<ShapeMatch, APIError> {

        let pathTemplate = "/emoji_id/{emoji_id}/metadata"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// 
    public func emojiIDMetadata(emojiId: String, result: @escaping (Result<ShapeMatch, APIError>) -> Void) {
        emojiIDMetadataPublisher(emojiId: emojiId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Generates a signature for the Yat allowing it to be minted
    public func generateSignaturePublisher(emojiId: String, body: SignatureRequest) -> AnyPublisher<SignatureResponse, APIError> {

        let pathTemplate = "/emoji_id/{emoji_id}/generate_signature"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Generates a signature for the Yat allowing it to be minted
    public func generateSignature(emojiId: String, body: SignatureRequest, result: @escaping (Result<SignatureResponse, APIError>) -> Void) {
        generateSignaturePublisher(emojiId: emojiId, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Get statistics for EmojiId
    public func getStatsPublisher(eid: String) -> AnyPublisher<EmojiStatsResponse, APIError> {

        let pathTemplate = "/emoji_id/{eid}/stats"
        let pathComponents: [String: Any] = [
            "{eid}": eid
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Get statistics for EmojiId
    public func getStats(eid: String, result: @escaping (Result<EmojiStatsResponse, APIError>) -> Void) {
        getStatsPublisher(eid: eid)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Redirect by EmojiId link
    public func linkRedirectPublisher(emojiId: String, link: String) -> AnyPublisher<EmptyAPIModel, APIError> {

        let path = "/redirect"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Redirect by EmojiId link
    public func linkRedirect(emojiId: String, link: String, result: @escaping (Result<EmptyAPIModel, APIError>) -> Void) {
        linkRedirectPublisher(emojiId: emojiId, link: link)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// List user's Emoji Ids
    public func listEmojiIDsPublisher(organizationId: UUID?, userId: UUID?) -> AnyPublisher<[String], APIError> {

        let path = "/emoji_id"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// List user's Emoji Ids
    public func listEmojiIDs(organizationId: UUID?, userId: UUID?, result: @escaping (Result<[String], APIError>) -> Void) {
        listEmojiIDsPublisher(organizationId: organizationId, userId: userId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// List extended view user's Emoji Ids
    public func listExtendedPublisher(organizationId: UUID?, userId: UUID?) -> AnyPublisher<[EmojiListItem], APIError> {

        let path = "/emoji_id/extended"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// List extended view user's Emoji Ids
    public func listExtended(organizationId: UUID?, userId: UUID?, result: @escaping (Result<[EmojiListItem], APIError>) -> Void) {
        listExtendedPublisher(organizationId: organizationId, userId: userId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Load value from EmojiId key value store
    public func loadJsonPublisher(eid: String, key: String) -> AnyPublisher<LoadJsonResponse, APIError> {

        let pathTemplate = "/emoji_id/{eid}/json/{key}"
        let pathComponents: [String: Any] = [
            "{eid}": eid, 
            "{key}": key
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Load value from EmojiId key value store
    public func loadJson(eid: String, key: String, result: @escaping (Result<LoadJsonResponse, APIError>) -> Void) {
        loadJsonPublisher(eid: eid, key: key)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Load value from EmojiId key value store with data keyed by YatJsonStoreKeys
    public func loadJsonIndexPublisher(eid: String, keys: [String]) -> AnyPublisher<[String:LoadJsonResponse], APIError> {

        let pathTemplate = "/emoji_id/{eid}/json"
        let pathComponents: [String: Any] = [
            "{eid}": eid
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Load value from EmojiId key value store with data keyed by YatJsonStoreKeys
    public func loadJsonIndex(eid: String, keys: [String], result: @escaping (Result<[String:LoadJsonResponse], APIError>) -> Void) {
        loadJsonIndexPublisher(eid: eid, keys: keys)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Lookup EmojiId
    public func lookupEmojiIDPublisher(emojiId: String, tags: String?) -> AnyPublisher<LookupResponse, APIError> {

        let pathTemplate = "/emoji_id/{emoji_id}"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Lookup EmojiId
    public func lookupEmojiID(emojiId: String, tags: String?, result: @escaping (Result<LookupResponse, APIError>) -> Void) {
        lookupEmojiIDPublisher(emojiId: emojiId, tags: tags)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Lookup EmojiId Payment addresses
    public func lookupEmojiIDPaymentPublisher(emojiId: String, tags: String?) -> AnyPublisher<PaymentAddressResponse, APIError> {

        let pathTemplate = "/emoji_id/{emoji_id}/payment"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Lookup EmojiId Payment addresses
    public func lookupEmojiIDPayment(emojiId: String, tags: String?, result: @escaping (Result<PaymentAddressResponse, APIError>) -> Void) {
        lookupEmojiIDPaymentPublisher(emojiId: emojiId, tags: tags)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Lookup EmojiId data based on a symbol or ticker
    public func lookupEmojiIdTickerPublisher(emojiId: String, tag: String) -> AnyPublisher<EidResponse, APIError> {

        let pathTemplate = "/emoji_id/{emoji_id}/{tag}"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId, 
            "{tag}": tag
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Lookup EmojiId data based on a symbol or ticker
    public func lookupEmojiIdTicker(emojiId: String, tag: String, result: @escaping (Result<EidResponse, APIError>) -> Void) {
        lookupEmojiIdTickerPublisher(emojiId: emojiId, tag: tag)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// 
    public func metadataPublisher(tokenId: Int64) -> AnyPublisher<Metadata, APIError> {

        let pathTemplate = "/nft_transfers/metadata/{token_id}"
        let pathComponents: [String: Any] = [
            "{token_id}": tokenId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// 
    public func metadata(tokenId: Int64, result: @escaping (Result<Metadata, APIError>) -> Void) {
        metadataPublisher(tokenId: tokenId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Return random Emoji
    public func randomPublisher() -> AnyPublisher<RandomResult, APIError> {

        let path = "/emoji_id/random"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Return random Emoji
    public func random(result: @escaping (Result<RandomResult, APIError>) -> Void) {
        randomPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Return list of recently purchased emoji
    public func recentPublisher() -> AnyPublisher<RecentlyPurchasedResult, APIError> {

        let path = "/emoji_id/recent"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Return list of recently purchased emoji
    public func recent(result: @escaping (Result<RecentlyPurchasedResult, APIError>) -> Void) {
        recentPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Calculate EmojiId rhythm score
    public func rhythmPublisher(emojiId: String) -> AnyPublisher<RhythmResponse, APIError> {

        let pathTemplate = "/emoji_id/{emoji_id}/rhythm"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Calculate EmojiId rhythm score
    public func rhythm(emojiId: String, result: @escaping (Result<RhythmResponse, APIError>) -> Void) {
        rhythmPublisher(emojiId: emojiId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Search for EmojiID
    public func searchEmojiIDPublisher(emojiId: String) -> AnyPublisher<SearchResult, APIError> {

        let path = "/emoji_id/search"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Search for EmojiID
    public func searchEmojiID(emojiId: String, result: @escaping (Result<SearchResult, APIError>) -> Void) {
        searchEmojiIDPublisher(emojiId: emojiId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Store value under EmojiId key
    public func storeJsonPublisher(eid: String, key: String, body: StoreJsonBody) -> AnyPublisher<EmptyAPIModel, APIError> {

        let pathTemplate = "/emoji_id/{eid}/json/{key}"
        let pathComponents: [String: Any] = [
            "{eid}": eid, 
            "{key}": key
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Store value under EmojiId key
    public func storeJson(eid: String, key: String, body: StoreJsonBody, result: @escaping (Result<EmptyAPIModel, APIError>) -> Void) {
        storeJsonPublisher(eid: eid, key: key, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
