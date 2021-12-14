//  CodableValue.swift
	
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

public struct CodableValue: Codable {

    public var value: Any
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            self.init(string)
        } else if let int = try? container.decode(Int.self) {
            self.init(int)
        } else if let double = try? container.decode(Double.self) {
            self.init(double)
        } else if let bool = try? container.decode(Bool.self) {
            self.init(bool)
        } else if let dictionary = try? container.decode([String: CodableValue].self) {
            self.init(dictionary)
        } else if let array = try? container.decode([CodableValue].self) {
            self.init(array)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unable to decode data.")
        }
    }
    
    init<T>(_ value: T?) {
        self.value = value ?? ()
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()

        switch value {
        case let string as String:
            try container.encode(string)
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let bool as Bool:
            try container.encode(bool)
        case let dictionary as [String: Any]:
            try container.encode(dictionary.mapValues { CodableValue($0) })
        case let array as [Any]:
            try container.encode(array.map { CodableValue($0)})
        case let encodable as Encodable:
            let keyValues = encodable.convert().mapValues { CodableValue($0) }
            try container.encode(keyValues)
        default:
            try container.encodeNil()
        }
    }
}
