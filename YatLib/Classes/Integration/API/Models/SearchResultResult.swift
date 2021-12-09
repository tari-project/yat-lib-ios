//  SearchResultResult.swift
	
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

/** The specific Emoji ID that the user requests */
public struct SearchResultResult: Codable {
    /// The availability state of this emoji
    public let availability: String
    /// Whether the Emoji ID is available for purchase
    public let available: Bool
    /// EmojiID copy text
    public let copy: [String: CodableValue]?
    /// Emoji ID in canonical form
    public let emojiId: String
    /// Which emoji are flippable
    public let flippableEmoji: [Bool]
    /// The generation of the Yat, if it has been purchased.
    public let generation: Int?
    /// Canonical EmojiID length in emojis
    public let length: Int64
    /// If this Emoji is minted
    public let minted: Bool
    /// The origin of the Yat if it was from a Prism Case
    public let origin: String?
    /// Pricing in US cents, e.g. 1024 is 10.24 USD.  Price is 0 if the emoji is not available
    public let price: Int?
    /// EmojiID rhythm score
    public let rhythmScore: Int64
    public let shape: EmojiListItemShape
    /// Emoji key words
    public let shortNames: [String]
    /// Total lookups using this API, if someone is viewing this Emoji ID  using their own self hosted node, it will not be counted here
    public let stats: [EmojiStatsResponseMetrics]

    public init(availability: String, available: Bool, copy: [String: CodableValue]?, emojiId: String, flippableEmoji: [Bool], generation: Int?, length: Int64, minted: Bool, origin: String?, price: Int?, rhythmScore: Int64, shape: EmojiListItemShape, shortNames: [String], stats: [EmojiStatsResponseMetrics]) {
        self.availability = availability
        self.available = available
        self.copy = copy
        self.emojiId = emojiId
        self.flippableEmoji = flippableEmoji
        self.generation = generation
        self.length = length
        self.minted = minted
        self.origin = origin
        self.price = price
        self.rhythmScore = rhythmScore
        self.shape = shape
        self.shortNames = shortNames
        self.stats = stats
    }
}
