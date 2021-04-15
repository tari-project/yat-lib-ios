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

import Foundation

public class YatOrder: Mappable {

    public var id = ""
    public var userId = ""
    public var status = ""
    public var orderNumber = ""
    public var user = YatUser()
    public var totalInCents = 0
    public var secondsUntilExpiry = 0
    public var eligibleForRefund = false
    public var items = [YatOrderItem]()

    required public init?(map: Map) {

    }

    public func mapping(map: Map) {
        id                  <- map["id"]
        userId              <- map["user_id"]
        status              <- map["status"]
        orderNumber         <- map["order_number"]
        user                <- map["user"]
        totalInCents        <- map["total_in_cents"]
        secondsUntilExpiry  <- map["seconds_until_expiry"]
        eligibleForRefund   <- map["eligible_for_refund"]
        items               <- map["order_items"]
    }
    
    public var emojiId: String? {
        for item in items {
            if item.itemType == "EmojiId" {
                return item.emojiId
            }
        }
        return nil
    }

}

public class YatOrderItem: Mappable {

    public var id = ""
    public var orderId = ""
    public var parentId = ""
    public var emojiId = ""
    public var itemType = ""
    public var quantity = 0

    required public init?(map: Map) {

    }

    public func mapping(map: Map) {
        id          <- map["id"]
        orderId     <- map["order_id"]
        parentId    <- map["parent_id"]
        emojiId     <- map["emoji_id"]
        itemType    <- map["item_type"]
        quantity    <- map["quantity"]
    }

}
