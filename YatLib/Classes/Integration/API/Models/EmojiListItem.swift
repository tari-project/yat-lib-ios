//  EmojiListItem.swift
	
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

/** EmojiId in canonical and display representations */
public struct EmojiListItem: Codable {
    public let blockedUntil: Date?
    public let canonicalFormat: String
    public let chainFormat: String
    public let displayFormat: String
    public let flippableEmoji: [Bool]
    public let generation: Int
    public let minted: Bool
    public let rhythmScore: Int
    public let shape: EmojiListItemShape
    public let shortname: String
    public let tokenId: Int64?

    public init(blockedUntil: Date?, canonicalFormat: String, chainFormat: String, displayFormat: String, flippableEmoji: [Bool], generation: Int, minted: Bool, rhythmScore: Int, shape: EmojiListItemShape, shortname: String, tokenId: Int64?) {
        self.blockedUntil = blockedUntil
        self.canonicalFormat = canonicalFormat
        self.chainFormat = chainFormat
        self.displayFormat = displayFormat
        self.flippableEmoji = flippableEmoji
        self.generation = generation
        self.minted = minted
        self.rhythmScore = rhythmScore
        self.shape = shape
        self.shortname = shortname
        self.tokenId = tokenId
    }
}
