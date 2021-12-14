// CartAPI.swift

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

public final class CartAPI: APIWorker {

    private let manager = YatAPIManager()
    private var cancelables = Set<AnyCancellable>()

    /// Update cart items by adding new items to the cart
    public func addItemsPublisher(body: AddItemsCartRequest) -> AnyPublisher<DisplayOrder, APIError> {

        let path = "/cart"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Update cart items by adding new items to the cart
    public func addItems(body: AddItemsCartRequest, result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        addItemsPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Apply promo code
    public func applyPromoCodePublisher(body: ApplyPromoCodeRequest) -> AnyPublisher<DisplayOrder, APIError> {

        let path = "/cart/promo_code"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Apply promo code
    public func applyPromoCode(body: ApplyPromoCodeRequest, result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        applyPromoCodePublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Checkout last payment cart
    public func checkoutPublisher(body: CheckoutCartRequest) -> AnyPublisher<DisplayOrder, APIError> {

        let path = "/cart/checkout"
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Checkout last payment cart
    public func checkout(body: CheckoutCartRequest, result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        checkoutPublisher(body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Checkout saved cart by id
    public func checkoutOrderPublisher(id: UUID, body: CheckoutCartRequest) -> AnyPublisher<DisplayOrder, APIError> {

        let pathTemplate = "/cart/checkout/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .post, body: body)
    }
    
    /// Checkout saved cart by id
    public func checkoutOrder(id: UUID, body: CheckoutCartRequest, result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        checkoutOrderPublisher(id: id, body: body)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Remove all items from cart
    public func clearCartPublisher() -> AnyPublisher<DisplayOrder, APIError> {

        let path = "/cart"
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Remove all items from cart
    public func clearCart(result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        clearCartPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Convert pending payment cart back into Draft status
    public func convertOrderToDraftPublisher() -> AnyPublisher<DisplayOrder, APIError> {

        let path = "/cart/convert_to_draft"
        
        return manager.perform(path: path, method: .post)
    }
    
    /// Convert pending payment cart back into Draft status
    public func convertOrderToDraft(result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        convertOrderToDraftPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Delete payment method
    public func deletePaymentMethodsPublisher(id: String) -> AnyPublisher<PaymentMethod, APIError> {

        let pathTemplate = "/payment_methods/{id}"
        let pathComponents: [String: Any] = [
            "{id}": id
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Delete payment method
    public func deletePaymentMethods(id: String, result: @escaping (Result<PaymentMethod, APIError>) -> Void) {
        deletePaymentMethodsPublisher(id: id)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Return cart content
    public func getItemsPublisher() -> AnyPublisher<DisplayOrder, APIError> {

        let path = "/cart"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Return cart content
    public func getItems(result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        getItemsPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Fetch payment methods for the user
    public func listPaymentMethodsPublisher() -> AnyPublisher<[PaymentMethod], APIError> {

        let path = "/payment_methods"
        
        return manager.perform(path: path, method: .get)
    }
    
    /// Fetch payment methods for the user
    public func listPaymentMethods(result: @escaping (Result<[PaymentMethod], APIError>) -> Void) {
        listPaymentMethodsPublisher()
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

    /// Removes an order item from the cart
    public func removeItemPublisher(cartItemId: UUID) -> AnyPublisher<DisplayOrder, APIError> {

        let pathTemplate = "/cart/cart_items/{cart_item_id}"
        let pathComponents: [String: Any] = [
            "{cart_item_id}": cartItemId
        ]
        let path = PathTemplateManager.path(template: pathTemplate, dictionary: pathComponents)
        
        return manager.perform(path: path, method: .delete)
    }
    
    /// Removes an order item from the cart
    public func removeItem(cartItemId: UUID, result: @escaping (Result<DisplayOrder, APIError>) -> Void) {
        removeItemPublisher(cartItemId: cartItemId)
            .sink(
                receiveCompletion: { [weak self] in self?.handle(completion: $0, result: result) },
                receiveValue: { result(.success($0)) }
            )
            .store(in: &cancelables)
    }

} 
