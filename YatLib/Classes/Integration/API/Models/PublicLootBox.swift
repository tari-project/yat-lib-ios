//  PublicLootBox.swift
	
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

public struct PublicLootBox: Codable {
    /// Average score of emoji IDs in loot box
    public let averageRhythmScore: Double
    public let createdAt: Date
    public let id: UUID
    public let lootboxType: ListOfPublicLootBoxLootboxType?
    /// For Admin: The type of loot box, if applicable
    public let lootboxTypeId: UUID?
    public let owner: ListOfPublicLootBoxOwner?
    /// Loot box owner_id, required for Owned and Used loot boxes
    public let ownerId: UUID?
    /// The prices of the yats in the box, in cents
    public let prices: [Int]
    /// The rhythm scores of the yats in the box
    public let scores: [Int64]
    /// Status loot box will be created in
    public let status: String
    /// Total value of EmojiIDs in the Loot Box
    public let totalValue: Double
    /// Loot box yats
    public let yats: [String]

    public init(averageRhythmScore: Double, createdAt: Date, id: UUID, lootboxType: ListOfPublicLootBoxLootboxType?, lootboxTypeId: UUID?, owner: ListOfPublicLootBoxOwner?, ownerId: UUID?, prices: [Int], scores: [Int64], status: String, totalValue: Double, yats: [String]) {
        self.averageRhythmScore = averageRhythmScore
        self.createdAt = createdAt
        self.id = id
        self.lootboxType = lootboxType
        self.lootboxTypeId = lootboxTypeId
        self.owner = owner
        self.ownerId = ownerId
        self.prices = prices
        self.scores = scores
        self.status = status
        self.totalValue = totalValue
        self.yats = yats
    }
}
