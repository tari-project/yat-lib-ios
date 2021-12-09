//  RegisterUserParameters.swift
	
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

public struct RegisterUserParameters: Codable {
    /// Optional: Whether to force activation during creation (requires UserActivate scope)
    public let activate: Bool?
    /// Optional: Source of activation (requires UserActivate scope)
    public let activationSource: String?
    /// Alternate identifier
    public let alternateId: String?
    /// Email address
    public let email: String?
    /// Optional: first name
    public let firstName: String?
    /// Response from google Recaptcha
    public let gRecaptchaResponse: String?
    /// Optional: last name
    public let lastName: String?
    /// Parameter to pass everflow click id
    public let partnerConversionId: String?
    /// Optional: password
    public let password: String?
    /// Required when registering with &#x60;alternate_id&#x60;, source for non custodial user
    public let source: String?

    public init(activate: Bool?, activationSource: String?, alternateId: String?, email: String?, firstName: String?, gRecaptchaResponse: String?, lastName: String?, partnerConversionId: String?, password: String?, source: String?) {
        self.activate = activate
        self.activationSource = activationSource
        self.alternateId = alternateId
        self.email = email
        self.firstName = firstName
        self.gRecaptchaResponse = gRecaptchaResponse
        self.lastName = lastName
        self.partnerConversionId = partnerConversionId
        self.password = password
        self.source = source
    }
}
