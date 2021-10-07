//  YatIntegration.swift
	
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

import UIKit

public final class YatIntegration {
    
    // MARK: - Properties
    
    private weak var hostController: UIViewController?
    
    // MARK: - Public Actions
    
    public func showOnboarding(onViewController hostController: UIViewController, records: [YatRecordInput]) {
        
        let onboardingController = OnboardingViewController(records: records)
        onboardingController.isModalInPresentation = true
        self.hostController = hostController
        
        hostController.present(onboardingController, animated: true)
    }
    
    public func handle(deeplink: URL) {
        guard isDeeplinkValid(url: deeplink), let parameters = deeplink.queryParameters, let emojiID = parameters["eid"] else { return }
        showSuccessDialog(emojiID: emojiID)
    }
    
    // MARK: - Internal Actions
    
    func openCreateYatFlow(records: [YatRecordInput]) throws {
        try openOnboardingWebpage(path: "/partner/\(Yat.configuration.organizationKey)", records: records)
    }
    
    func connectExistingYat(records: [YatRecordInput]) throws {
        try openOnboardingWebpage(path: "/partner/\(Yat.configuration.organizationKey)/link-email", records: records)
    }
    
    // MARK: - Private Actions
    
    private func showSuccessDialog(emojiID: String) {
        hostController?.dismiss(animated: true, completion: {})
        let successController = ConnectionSuccessViewController()
        successController.yatID = emojiID
        
        hostController?.present(successController, animated: true)
    }
    
    private func openOnboardingWebpage(path: String, records: [YatRecordInput]) throws {
        
        guard var components = URLComponents(url: YatConstants.webServiceURL, resolvingAgainstBaseURL: true) else { throw OnboardingError.internalError }
        
        let recordsValue = records
            .map { "\($0.tag.rawValue)=\($0.value)"}
            .joined(separator: "|")
        
        components.path = path
        components.queryItems = [URLQueryItem(name: "addresses", value: recordsValue)]
        
        guard let url = components.url else { throw OnboardingError.invalidQuery }
        
        guard UIApplication.shared.canOpenURL(url) else { throw OnboardingError.unableToOpenURL }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // MARK: - Helpers
    
    private func isDeeplinkValid(url: URL) -> Bool {
        guard let validationURL = URL(string: Yat.configuration.appReturnLink) else { return false }
        return validationURL.scheme == url.scheme && validationURL.host == url.host
    }
}
