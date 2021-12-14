//  DisplayOrderOrderItems.swift
	
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

public struct DisplayOrderOrderItems: Codable {
    /// The fee attributable to the referral partner, in addition to the nominal unit price, in USD cents.
    public let clientFeeInCents: Int
    /// The code associated with this order item for providing a discount.
    public let codeId: UUID?
    /// The fee attributable to the service host or company, in addition to the nominal unit price, in USD cents.
    public let companyFeeInCents: Int
    /// A UTC timestamp for when this order item was created.
    public let createdAt: Date
    /// The emoji id that is being purchased
    public let emojiId: [String: CodableValue]?
    /// A unique identifier for this order item
    public let id: UUID
    /// The type of order. Current enumerations are EmojiId and Discount
    public let itemType: String
    /// Main item ID
    public let mainId: UUID?
    /// Main item table
    public let mainTable: [String: CodableValue]?
    /// A UTC timestamp for when this order item was marked as invalid.
    public let markedInvalidAt: Date?
    /// Marked invalid at reason Taken / PendingPurchase
    public let markedInvalidAtReason: String?
    /// The id of the order this order item
    public let orderId: UUID
    /// Parent order item&#39;s ID, set for discounts and fees
    public let parentId: UUID?
    /// The number of items in the line order. For emoji id sales, this should always be one.
    public let quantity: Int
    /// The number of items refunded. For emoji id sales, this should always at most be one.
    public let refundedQuantity: Int
    /// The rhythm score belonging to this order item, only set for order items containing EmojiIds.
    public let rhythmScore: Int?
    /// The nominal, non-discounted price of the item, in USD cents.
    public let unitPriceInCents: Int
    /// A UTC timestamp for when any field in the order item was modified.
    public let updatedAt: Date

    public init(clientFeeInCents: Int, codeId: UUID?, companyFeeInCents: Int, createdAt: Date, emojiId: [String: CodableValue]?, id: UUID, itemType: String, mainId: UUID?, mainTable: [String: CodableValue]?, markedInvalidAt: Date?, markedInvalidAtReason: String?, orderId: UUID, parentId: UUID?, quantity: Int, refundedQuantity: Int, rhythmScore: Int?, unitPriceInCents: Int, updatedAt: Date) {
        self.clientFeeInCents = clientFeeInCents
        self.codeId = codeId
        self.companyFeeInCents = companyFeeInCents
        self.createdAt = createdAt
        self.emojiId = emojiId
        self.id = id
        self.itemType = itemType
        self.mainId = mainId
        self.mainTable = mainTable
        self.markedInvalidAt = markedInvalidAt
        self.markedInvalidAtReason = markedInvalidAtReason
        self.orderId = orderId
        self.parentId = parentId
        self.quantity = quantity
        self.refundedQuantity = refundedQuantity
        self.rhythmScore = rhythmScore
        self.unitPriceInCents = unitPriceInCents
        self.updatedAt = updatedAt
    }
}
