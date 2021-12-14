//  ListOfDisplayTransferRequestData.swift
	
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

/** Emoji transfer request details json payload */
public struct ListOfDisplayTransferRequestData: Codable {
    public let acceptedAt: Date?
    public let clearOnTransfer: Bool
    public let createdAt: Date
    public let deletedAt: Date?
    public let eid: String
    public let email: String
    public let id: UUID
    public let message: String?
    public let recipientId: UUID
    public let senderCodeAcceptedAt: Date?

    public init(acceptedAt: Date?, clearOnTransfer: Bool, createdAt: Date, deletedAt: Date?, eid: String, email: String, id: UUID, message: String?, recipientId: UUID, senderCodeAcceptedAt: Date?) {
        self.acceptedAt = acceptedAt
        self.clearOnTransfer = clearOnTransfer
        self.createdAt = createdAt
        self.deletedAt = deletedAt
        self.eid = eid
        self.email = email
        self.id = id
        self.message = message
        self.recipientId = recipientId
        self.senderCodeAcceptedAt = senderCodeAcceptedAt
    }
}
