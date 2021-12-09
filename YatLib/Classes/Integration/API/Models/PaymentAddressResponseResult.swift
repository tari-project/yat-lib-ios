//  PaymentAddressResponseResult.swift
	
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

/** Payment address response for crypto and token payment data */
public struct PaymentAddressResponseResult: Codable {
    /// The payment address
    public let address: String
    /// The category of this address
    public let category: String
    /// Optional: Is this address the default address for the category
    public let `default`: Bool
    /// Optional: Description of the address
    public let description: String?
    /// Optional: CryptoToken long name is a defined name for the ERC20 token
    public let longName: String?
    /// Optional: CryptoToken settlement network for the ERC20 token
    public let settlementNetwork: String?
    /// Optional: CryptoToken short name to identify an ERC20 token
    public let shortName: String?
    /// Optional: Proof of ownership signature for the address
    public let signature: String?

    public init(address: String, category: String, `default`: Bool, description: String?, longName: String?, settlementNetwork: String?, shortName: String?, signature: String?) {
        self.address = address
        self.category = category
        self.`default` = `default`
        self.description = description
        self.longName = longName
        self.settlementNetwork = settlementNetwork
        self.shortName = shortName
        self.signature = signature
    }
}
