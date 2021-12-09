// UserInterestAPI.swift

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

public final class UserInterestAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Destroys the user interest preventing this Emoji ID's notification emails from being sent for this user
    public func deleteUserInterestPublisher(emojiId: String) -> AnyPublisher<UserInterest, APIError> {

        let pathTemplate = "/user_interests/{emoji_id}"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Destroys the user interest preventing this Emoji ID's notification emails from being sent for this user
    public func deleteUserInterest(emojiId: String, result: @escaping (Result<UserInterest, APIError>) -> Void) {
        deleteUserInterestPublisher(emojiId: emojiId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Returns a paginated list of user interest records associated with the user
    public func getInterestedUsersPublisher(dir: String?, limit: Int?, page: Int?, sort: String?) -> AnyPublisher<ListOfUserInterest, APIError> {

        let path = "/user_interests"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Returns a paginated list of user interest records associated with the user
    public func getInterestedUsers(dir: String?, limit: Int?, page: Int?, sort: String?, result: @escaping (Result<ListOfUserInterest, APIError>) -> Void) {
        getInterestedUsersPublisher(dir: dir, limit: limit, page: page, sort: sort)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Given an EmojiId returns information about the user interest if a record exists for this user
    public func getUserInterestForYatPublisher(emojiId: String) -> AnyPublisher<UserInterest, APIError> {

        let pathTemplate = "/user_interests/{emoji_id}"
        let pathComponents: [String: Any] = [
            "{emoji_id}": emojiId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Given an EmojiId returns information about the user interest if a record exists for this user
    public func getUserInterestForYat(emojiId: String, result: @escaping (Result<UserInterest, APIError>) -> Void) {
        getUserInterestForYatPublisher(emojiId: emojiId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Create new interest in emoji to be notified when available
    public func registerInterestPublisher(body: NewUserInterestParameters) -> AnyPublisher<UserInterest, APIError> {

        let path = "/user_interests"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Create new interest in emoji to be notified when available
    public func registerInterest(body: NewUserInterestParameters, result: @escaping (Result<UserInterest, APIError>) -> Void) {
        registerInterestPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
