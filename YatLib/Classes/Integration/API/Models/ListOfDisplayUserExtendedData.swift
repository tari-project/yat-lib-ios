//  ListOfDisplayUserExtendedData.swift
	
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

/** User data with emoji list */
public struct ListOfDisplayUserExtendedData: Codable {
    public let alternateId: String?
    public let createdAt: Date?
    public let deactivatedAt: Date?
    public let email: String?
    public let emailVerifiedAt: Date?
    public let emojiIds: [String]
    public let firstName: String?
    public let freeLimit: Int?
    public let id: UUID?
    public let lastName: String?
    public let pubkeys: [String]?
    public let remainingFreeEmoji: Int?
    public let role: String?
    public let source: String?
    public let twoFactorAuth: [String]?
    public let twoFactorLastPromptedAt: Date?
    public let twoFactorShouldPrompt: Bool?
    public let updatedAt: Date?

    public init(alternateId: String?, createdAt: Date?, deactivatedAt: Date?, email: String?, emailVerifiedAt: Date?, emojiIds: [String], firstName: String?, freeLimit: Int?, id: UUID?, lastName: String?, pubkeys: [String]?, remainingFreeEmoji: Int?, role: String?, source: String?, twoFactorAuth: [String]?, twoFactorLastPromptedAt: Date?, twoFactorShouldPrompt: Bool?, updatedAt: Date?) {
        self.alternateId = alternateId
        self.createdAt = createdAt
        self.deactivatedAt = deactivatedAt
        self.email = email
        self.emailVerifiedAt = emailVerifiedAt
        self.emojiIds = emojiIds
        self.firstName = firstName
        self.freeLimit = freeLimit
        self.id = id
        self.lastName = lastName
        self.pubkeys = pubkeys
        self.remainingFreeEmoji = remainingFreeEmoji
        self.role = role
        self.source = source
        self.twoFactorAuth = twoFactorAuth
        self.twoFactorLastPromptedAt = twoFactorLastPromptedAt
        self.twoFactorShouldPrompt = twoFactorShouldPrompt
        self.updatedAt = updatedAt
    }
}
