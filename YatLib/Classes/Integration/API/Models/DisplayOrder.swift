//  DisplayOrder.swift
	
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

public struct DisplayOrder: Codable {
    /// Amount overpaid in cents
    public let amountOverpaidInCents: Int64
    /// A UTC timestamp for when this order was initially created.
    public let createdAt: Date
    /// Whether an order is eligible for a refund via an admin.
    public let eligibleForRefund: Bool
    /// Checkout carts have a limited time before they expire. This prevents users from blocking inventory from being  sold to other customers. The expiry time is configurable on the server and is typically 5 minutes.
    public let expiresAt: Date?
    /// The unique identifier for this order
    public let id: UUID
    /// The total of miscellaneous refund amounts retirned to the order.
    public let miscRefundedTotalInCents: Int64
    /// The list of individual line items making up this order.
    public let orderItems: [DisplayOrderOrderItems]
    /// The order number is the last 8 characters of the order&#39;s ID for user display purposes.
    public let orderNumber: String
    /// The organization id of the user, if applicable. This will generally be null, unless the purchase is coming via  a referral programme.
    public let organizationId: UUID?
    /// A UTC timestamp for when payment for this order was received. Will be null if no payment has been made yet.
    public let paidAt: Date?
    public let paymentMethodData: DisplayOrderPaymentMethodData?
    /// The total of refund amounts for the order.
    public let refundedTotalInCents: Int64
    /// Remaining due in cents to mark the cart as Paid
    public let remainingDueInCents: Int64
    /// A convenience field indicating how long before &#x60;expires_at&#x60; is reached.
    public let secondsUntilExpiry: Int?
    /// The order of the status. Orders start in &#39;Draft&#39; status, then move to &#39;PendingPayment&#39; and finally, &#39;Paid&#39;,  unless they are &#39;Cancelled&#39;.
    public let status: String
    /// The sum of all the items in this order, plus fees, in USD cents.
    public let totalInCents: Int64
    /// A UTC timestamp for the last time any field in this order was modified.
    public let updatedAt: Date
    public let user: DisplayOrderUser
    /// The identifier of the user placing this order
    public let userId: UUID

    public init(amountOverpaidInCents: Int64, createdAt: Date, eligibleForRefund: Bool, expiresAt: Date?, id: UUID, miscRefundedTotalInCents: Int64, orderItems: [DisplayOrderOrderItems], orderNumber: String, organizationId: UUID?, paidAt: Date?, paymentMethodData: DisplayOrderPaymentMethodData?, refundedTotalInCents: Int64, remainingDueInCents: Int64, secondsUntilExpiry: Int?, status: String, totalInCents: Int64, updatedAt: Date, user: DisplayOrderUser, userId: UUID) {
        self.amountOverpaidInCents = amountOverpaidInCents
        self.createdAt = createdAt
        self.eligibleForRefund = eligibleForRefund
        self.expiresAt = expiresAt
        self.id = id
        self.miscRefundedTotalInCents = miscRefundedTotalInCents
        self.orderItems = orderItems
        self.orderNumber = orderNumber
        self.organizationId = organizationId
        self.paidAt = paidAt
        self.paymentMethodData = paymentMethodData
        self.refundedTotalInCents = refundedTotalInCents
        self.remainingDueInCents = remainingDueInCents
        self.secondsUntilExpiry = secondsUntilExpiry
        self.status = status
        self.totalInCents = totalInCents
        self.updatedAt = updatedAt
        self.user = user
        self.userId = userId
    }
}
