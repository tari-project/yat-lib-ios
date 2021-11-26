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

import UIKit
import Combine

final class YatAPIManager {
    
    // MARK: - Properties
    
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Actions
    
    func perform<T: Requestable, U: Decodable>(request: T) -> AnyPublisher<U, APIError> {
        Just(request)
            .tryMap { [unowned self] in try self.makeURLRequest(request: $0) }
            .flatMap { [unowned self] in self.perform(reuqest: $0) }
            .mapError { [unowned self] in self.map(error: $0) }
            .eraseToAnyPublisher()
    }
    
    private func makeURLRequest<T: Requestable>(request: T) throws -> URLRequest {
        
        var urlComponents = URLComponents(url: Yat.urls.apiURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = request.path
        
        if request.method == .get || request.method == .delete {
            urlComponents?.queryItems = try request.query(encoder: jsonEncoder)?.map { URLQueryItem(name: $0, value: String(describing: $1)) }
        }
        
        guard let url = urlComponents?.url else { throw APIError.invalidRequest }
        var urlRequest = URLRequest(url: url)
        
        if request.method == .post || request.method == .patch {
            do {
                urlRequest.httpBody = try jsonEncoder.encode(request)
            } catch {
                throw APIError.unableToEncodeRequest(reason: error.localizedDescription)
            }
        }
        
        return urlRequest
    }
    
    private func perform<T: Decodable>(reuqest: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: reuqest)
            .tryMap { [unowned self] in try self.handleResponse(data: $0, response: $1) }
            .eraseToAnyPublisher()
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.internalError }
        guard (200...299).contains(httpResponse.statusCode) else { throw APIError.invalidStatusCode(code: httpResponse.statusCode) }
        
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw APIError.invalidResponse(reason: error.localizedDescription)
        }
    }
    
    private func map(error: Error) -> APIError {
        guard let error = error as? APIError else { return .unhandledError }
        return error
    }
}
