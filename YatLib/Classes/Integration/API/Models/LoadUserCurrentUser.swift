//  LoadUserCurrentUser.swift
	
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

public struct LoadUserCurrentUser: Codable {
    /// transaction id indicating if the user signed up from a partner via everflow redirect
    public let everflowTransactionId: String?
    /// Enabled features for the user
    public let features: [CurrentUserFeatures]
    /// A list of fine-grained permissions the user may perform.
    public let globalScopes: [String]
    /// The role this user has in each organisation. Organisations are currently not used, but are reserved for  future operations.
    public let organizationRoles: [String:String]
    /// The scopes that are granted to this user for each organisation. Organisations are currently not used, but are  reserved for future operations.
    public let organizationScopes: [String:[String]]
    /// List of transfers pending acceptance on current user side
    public let pendingTransfers: [String]
    /// A list of this user&#39;s public keys. When yats are deployed to the blockchain, users prove ownership of their  Yats with digital signatures, proving knowledge of the private keys that \&quot;own\&quot; the yat. In the centralised  implementation of Yat, the server will custody the users&#39; wallets and private keys, but in other respects the  ownership model is the same.
    public let pubkeys: [String]
    /// The role assigned to this user. Roles grant authority to user accounts to perform certain actions.
    public let role: String
    public let user: CurrentUserUser

    public init(everflowTransactionId: String?, features: [CurrentUserFeatures], globalScopes: [String], organizationRoles: [String:String], organizationScopes: [String:[String]], pendingTransfers: [String], pubkeys: [String], role: String, user: CurrentUserUser) {
        self.everflowTransactionId = everflowTransactionId
        self.features = features
        self.globalScopes = globalScopes
        self.organizationRoles = organizationRoles
        self.organizationScopes = organizationScopes
        self.pendingTransfers = pendingTransfers
        self.pubkeys = pubkeys
        self.role = role
        self.user = user
    }
}
