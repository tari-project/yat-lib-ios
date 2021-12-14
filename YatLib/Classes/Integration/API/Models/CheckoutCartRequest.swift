//  CheckoutCartRequest.swift
	
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

public struct CheckoutCartRequest: Codable {
    /// Amount paid in cash. Applicable and required only for &#x60;Cash&#x60; payment option for Admin.
    public let amount: Int64?
    /// URL user will be redirected if payment cancelled  Required for Stripe Checkout
    public let cancelUrl: String?
    /// External reference for cash payment. Applicable and required only for &#x60;Cash&#x60; payment option for Admin.
    public let externalReference: String?
    /// Payment method type
    public let method: String
    /// Optional: The user&#39;s public key to associate with this emoji id. If provided will use this pubkey otherwise  will default to the first pubkey returned for the user.
    public let pubkey: String?
    /// URL user will be redirected after successful payment  Required for Stripe Checkout
    public let successUrl: String?
    /// Optional: tracking data
    public let trackingData: [String: CodableValue]?

    public init(amount: Int64?, cancelUrl: String?, externalReference: String?, method: String, pubkey: String?, successUrl: String?, trackingData: [String: CodableValue]?) {
        self.amount = amount
        self.cancelUrl = cancelUrl
        self.externalReference = externalReference
        self.method = method
        self.pubkey = pubkey
        self.successUrl = successUrl
        self.trackingData = trackingData
    }
}
