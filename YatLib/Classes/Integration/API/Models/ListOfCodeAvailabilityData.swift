//  ListOfCodeAvailabilityData.swift
	
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

public struct ListOfCodeAvailabilityData: Codable {
    public let activator: String?
    public let available: Int64?
    public let codeType: String?
    public let createdAt: Date?
    public let deletedAt: Date?
    public let discountAsPercentage: Int?
    public let discountInCents: Int?
    public let endDate: Date?
    public let id: UUID?
    public let maxEmojisPerUser: Int?
    public let maxUses: Int?
    public let name: String?
    public let organizationId: UUID?
    public let pattern: [String: CodableValue]?
    public let redemptionCode: String?
    public let startDate: Date?
    public let totalUses: Int64
    public let updatedAt: Date?

    public init(activator: String?, available: Int64?, codeType: String?, createdAt: Date?, deletedAt: Date?, discountAsPercentage: Int?, discountInCents: Int?, endDate: Date?, id: UUID?, maxEmojisPerUser: Int?, maxUses: Int?, name: String?, organizationId: UUID?, pattern: [String: CodableValue]?, redemptionCode: String?, startDate: Date?, totalUses: Int64, updatedAt: Date?) {
        self.activator = activator
        self.available = available
        self.codeType = codeType
        self.createdAt = createdAt
        self.deletedAt = deletedAt
        self.discountAsPercentage = discountAsPercentage
        self.discountInCents = discountInCents
        self.endDate = endDate
        self.id = id
        self.maxEmojisPerUser = maxEmojisPerUser
        self.maxUses = maxUses
        self.name = name
        self.organizationId = organizationId
        self.pattern = pattern
        self.redemptionCode = redemptionCode
        self.startDate = startDate
        self.totalUses = totalUses
        self.updatedAt = updatedAt
    }
}
