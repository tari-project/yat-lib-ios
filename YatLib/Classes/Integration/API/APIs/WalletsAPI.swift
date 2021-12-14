// WalletsAPI.swift

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

public final class WalletsAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Fetch associated wallet addresses for the user
    public func listWalletsPublisher() -> AnyPublisher<[Wallet], APIError> {

        let path = "/wallets"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Fetch associated wallet addresses for the user
    public func listWallets(result: @escaping (Result<[Wallet], APIError>) -> Void) {
        listWalletsPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Associate new wallet address with user
    public func syncWalletPublisher(body: WalletSyncRequest) -> AnyPublisher<EmptyAPIModel, APIError> {

        let path = "/wallets"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Associate new wallet address with user
    public func syncWallet(body: WalletSyncRequest, result: @escaping (Result<EmptyAPIModel, APIError>) -> Void) {
        syncWalletPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
