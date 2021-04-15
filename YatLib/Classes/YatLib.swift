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
import UIKit

public protocol YatLibDelegate: class {
    func onYatIntegrationComplete(yat: String)
}

public class YatLib {
    
    public enum ColorMode {
        case light
        case dark
    }
    
    private static weak var hostViewController: UIViewController? = nil
    private static var introViewController: YatIntroPageViewController!
    
    static var appConfig: YatAppConfig!
    
    static var records: [YatRecord]!
    
    static var userAlternateId: String!
    static var userPassword: String!
    static var colorMode = ColorMode.dark
    
    internal static weak var delegate: YatLibDelegate!
    
    public static func initialize(
        appConfig: YatAppConfig,
        userId: String,
        userPassword: String,
        colorMode: ColorMode = .light,
        delegate: YatLibDelegate,
        records: [YatRecord]
    ) {
        UIFont.registerFonts()
        YatLib.appConfig = appConfig
        YatLib.userAlternateId = userId
        YatLib.userPassword = userPassword
        YatLib.colorMode = colorMode
        YatLib.delegate = delegate
        YatLib.records = records
    }
    
    public static func start(
        hostViewController: UIViewController
    ) {
        YatLib.hostViewController = hostViewController
        YatLib.introViewController = YatIntroPageViewController()
        YatLib.introViewController.modalPresentationStyle = .fullScreen
        YatLib.introViewController.modalTransitionStyle = .coverVertical
        hostViewController.present(
            YatLib.introViewController,
            animated: true,
            completion: nil
        )
    }
    
    internal static func stop() {
        hostViewController?.dismiss(animated: true)
    }
    
    internal static func complete(order: YatOrder) {
        hostViewController?.dismiss(animated: true)
        delegate.onYatIntegrationComplete(yat: order.emojiId!)
    }
    
    public static func processDeepLink(_ url: URL) {
        guard let host = url.host,
              let queryParameters = url.queryParameters,
              let action = queryParameters["action"],
              let emojiId = queryParameters["eid"],
              action == "manage",
              host == "y.at" else {
            return
        }
        
        let updateRequest = YatUpdateRequest()
        updateRequest.insertRecords = YatLib.records
        YatAPI.shared.updateYat(
            yat: emojiId,
            updateRequest: updateRequest
        ) {
            DispatchQueue.main.async {
                hostViewController?.dismiss(animated: true)
                delegate.onYatIntegrationComplete(yat: emojiId)
            }
        } onError: {
            (error) in
            DispatchQueue.main.async {
                displayUpdateYatError()
            }
        }
    }
    
    private static func displayUpdateYatError() {
        let alert = UIAlertController(
            title: localized("common.error.title"),
            message: localized("common.error.message.update_yat"),
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: localized("common.close"),
                style: .default,
                handler: nil
            )
        )
        hostViewController?.present(alert, animated: true)
    }
    
}
