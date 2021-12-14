//  DisplayOrderPaymentMethodData.swift
	
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

/** Payment method data for payment methods that provide QR code checkout options set via checkout. */
public struct DisplayOrderPaymentMethodData: Codable {
    /// Cancel url for &#x60;Stripe&#x60; method when using Checkout
    public let cancelUrl: String?
    /// Client Secret for the &#x60;Stripe&#x60; method for Elements and Checkout
    public let clientSecret: String
    /// Invoice ID for the &#x60;Stripe&#x60; method for Elements
    public let invoiceId: String?
    /// Payment method
    public let method: String
    /// Metadata for &#x60;CoinbaseCommerce&#x60; payment method
    public let methods: [DisplayOrderPaymentMethodDataMethods]
    /// Payment method ID for &#x60;Stripe&#x60; method
    public let paymentIntentId: String
    /// Invoice ID for the &#x60;Stripe&#x60; method for Checkout
    public let sessionId: String?
    /// Success url for &#x60;Stripe&#x60; method when using Checkout
    public let successUrl: String?

    public init(cancelUrl: String?, clientSecret: String, invoiceId: String?, method: String, methods: [DisplayOrderPaymentMethodDataMethods], paymentIntentId: String, sessionId: String?, successUrl: String?) {
        self.cancelUrl = cancelUrl
        self.clientSecret = clientSecret
        self.invoiceId = invoiceId
        self.method = method
        self.methods = methods
        self.paymentIntentId = paymentIntentId
        self.sessionId = sessionId
        self.successUrl = successUrl
    }
}
