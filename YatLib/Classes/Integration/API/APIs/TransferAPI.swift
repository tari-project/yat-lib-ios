// TransferAPI.swift

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

public final class TransferAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Mark transfer request as deleted
    public func deleteTransferPublisher(transferId: UUID) -> AnyPublisher<DisplayTransferRequest, APIError> {

        let pathTemplate = "/transfers/{transfer_id}"
        let pathComponents: [String: Any] = [
            "{transfer_id}": transferId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Mark transfer request as deleted
    public func deleteTransfer(transferId: UUID, result: @escaping (Result<DisplayTransferRequest, APIError>) -> Void) {
        deleteTransferPublisher(transferId: transferId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// List outgoing transfer requests for current or specified user If limit is omitted will display top 50 transfer requests
    public func listFilteredPublisher(acceptedAfter: Date?, dir: String?, limit: Int?, page: Int?, senderId: UUID?, sort: String?) -> AnyPublisher<ListOfDisplayTransferRequest, APIError> {

        let path = "/transfers"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// List outgoing transfer requests for current or specified user If limit is omitted will display top 50 transfer requests
    public func listFiltered(acceptedAfter: Date?, dir: String?, limit: Int?, page: Int?, senderId: UUID?, sort: String?, result: @escaping (Result<ListOfDisplayTransferRequest, APIError>) -> Void) {
        listFilteredPublisher(acceptedAfter: acceptedAfter, dir: dir, limit: limit, page: page, senderId: senderId, sort: sort)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// List transfer requests assigned to user
    public func listIncomingPublisher(accepted: Bool) -> AnyPublisher<[DisplayTransferRequest], APIError> {

        let path = "/transfers/incoming"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// List transfer requests assigned to user
    public func listIncoming(accepted: Bool, result: @escaping (Result<[DisplayTransferRequest], APIError>) -> Void) {
        listIncomingPublisher(accepted: accepted)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// As a receiver, accept transfer request by id.
    public func receiverAcceptTransferPublisher(transferId: UUID, body: AcceptTransfer) -> AnyPublisher<[String], APIError> {

        let pathTemplate = "/transfers/{transfer_id}/receiver_accept"
        let pathComponents: [String: Any] = [
            "{transfer_id}": transferId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// As a receiver, accept transfer request by id.
    public func receiverAcceptTransfer(transferId: UUID, body: AcceptTransfer, result: @escaping (Result<[String], APIError>) -> Void) {
        receiverAcceptTransferPublisher(transferId: transferId, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Transfer eid to either the pubkey or email address supplied in the PUT data
    public func requestTransferPublisher(body: TransferRequest) -> AnyPublisher<DisplayTransferRequest, APIError> {

        let path = "/transfers"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Transfer eid to either the pubkey or email address supplied in the PUT data
    public func requestTransfer(body: TransferRequest, result: @escaping (Result<DisplayTransferRequest, APIError>) -> Void) {
        requestTransferPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Resend a new transfer OTP code for the current user, if the transfer allows it.
    public func resendCodePublisher(transferId: UUID) -> AnyPublisher<Data, APIError> {

        let pathTemplate = "/transfers/{transfer_id}/resend_code"
        let pathComponents: [String: Any] = [
            "{transfer_id}": transferId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Resend a new transfer OTP code for the current user, if the transfer allows it.
    public func resendCode(transferId: UUID, result: @escaping (Result<Data, APIError>) -> Void) {
        resendCodePublisher(transferId: transferId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// As a sender, confirm the transfer request by transfer id.
    public func senderAcceptTransferPublisher(transferId: UUID, body: AcceptTransfer) -> AnyPublisher<DisplayTransferRequest, APIError> {

        let pathTemplate = "/transfers/{transfer_id}/sender_accept"
        let pathComponents: [String: Any] = [
            "{transfer_id}": transferId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// As a sender, confirm the transfer request by transfer id.
    public func senderAcceptTransfer(transferId: UUID, body: AcceptTransfer, result: @escaping (Result<DisplayTransferRequest, APIError>) -> Void) {
        senderAcceptTransferPublisher(transferId: transferId, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
