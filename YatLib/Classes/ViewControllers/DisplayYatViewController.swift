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

class DisplayYatViewController: UIViewController {
    
    private let containerView = UIView()
    private let yatLogoImageView = UIImageView()
    private let backButton = UIButton()
    private let closeButton = UIButton()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emojiIdLabelContainerView = UIView()
    private let emojiIdLabel = UILabel()
    private let termsTextView = UITextView()
    private let checkoutButton = UIButton()
    private let upgradeToCustomYatButton = UIButton()
    private let upgradeToCustomYatButtonGradientView = HorizontalGradientView(
        startColor: Color.orangeGradientStart,
        endColor: Color.orangeGradientEnd,
        startPoint: CGPoint(x: 0, y: 0),
        endPoint: CGPoint(x: 1, y: 1)
    )
    private let upgradeToCustomYatActivityIndicator = UIActivityIndicatorView()
    private let webLinkIconImageView = UIImageView()
    private let checkoutActivityIndicator = UIActivityIndicatorView()
    
    var order: YatOrder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return Theme.statusBarStyle
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.backgroundColor
        let margins = view.layoutMarginsGuide
        // container
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = Theme.containerBackgroundColor
        containerView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 1
        ).isActive = true
        containerView.topAnchor.constraint(
            equalTo: margins.topAnchor,
            constant: 0
        ).isActive = true
        containerView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 0
        ).isActive = true
        containerView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        // yat logo
        containerView.addSubview(yatLogoImageView)
        yatLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        yatLogoImageView.image = Theme.yatLogoImage
        yatLogoImageView.widthAnchor.constraint(equalToConstant: 81).isActive = true
        yatLogoImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        yatLogoImageView.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: Theme.yatLogoTopMargin
        ).isActive = true
        yatLogoImageView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        // back button
        containerView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(Theme.backButtonImage, for: .normal)
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.centerYAnchor.constraint(
            equalTo: yatLogoImageView.centerYAnchor
        ).isActive = true
        backButton.leadingAnchor.constraint(
            equalTo: containerView.leadingAnchor,
            constant: 20
        ).isActive = true
        backButton.addTarget(
            self,
            action: #selector(onBackButtonTouchUpInside),
            for: .touchUpInside
        )
        // close button
        containerView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(Theme.closeButtonImage, for: .normal)
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.centerYAnchor.constraint(
            equalTo: yatLogoImageView.centerYAnchor
        ).isActive = true
        closeButton.trailingAnchor.constraint(
            equalTo: containerView.trailingAnchor,
            constant: -20
        ).isActive = true
        closeButton.addTarget(
            self,
            action: #selector(onCloseButtonTouchUpInside),
            for: .touchUpInside
        )
        // title
        titleLabel.textColor = Theme.infoTitleColor
        titleLabel.font = Theme.infoTitleFont
        titleLabel.text = localized("step4.title")
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        titleLabel.topAnchor.constraint(
            equalTo: yatLogoImageView.bottomAnchor,
            constant: Theme.displayYatTitleTopMargin
        ).isActive = true
        titleLabel.sizeToFit()
        // description
        descriptionLabel.textColor = Color.xLightGray
        descriptionLabel.font = Theme.infoDescriptionFont
        descriptionLabel.text = String(
            format: localized("step4.description"),
            YatLib.appConfig.name
        )
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        descriptionLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: Theme.displayYatDescriptionTopMargin
        ).isActive = true
        // yat label & container
        emojiIdLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        emojiIdLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(emojiIdLabelContainerView)
        emojiIdLabelContainerView.backgroundColor = Color.white
        emojiIdLabelContainerView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        emojiIdLabelContainerView.topAnchor.constraint(
            equalTo: descriptionLabel.bottomAnchor,
            constant: Theme.displayYatEmojiIdLabelTopMargin
        ).isActive = true
        emojiIdLabelContainerView.addSubview(emojiIdLabel)
        emojiIdLabel.text = order.emojiId
        emojiIdLabel.font = UIFont.systemFont(ofSize: 40)
        emojiIdLabelContainerView.widthAnchor.constraint(
            equalTo: emojiIdLabel.widthAnchor,
            constant: 40
        ).isActive = true
        emojiIdLabelContainerView.heightAnchor.constraint(
            equalTo: emojiIdLabel.heightAnchor,
            constant: 30
        ).isActive = true
        emojiIdLabel.centerXAnchor.constraint(
            equalTo: emojiIdLabelContainerView.centerXAnchor
        ).isActive = true
        emojiIdLabel.centerYAnchor.constraint(
            equalTo: emojiIdLabelContainerView.centerYAnchor
        ).isActive = true
        emojiIdLabel.sizeToFit()
        emojiIdLabelContainerView.layer.cornerRadius = 38
        emojiIdLabelContainerView.layer.masksToBounds = true
        // emoji id container shadow
        emojiIdLabelContainerView.layer.shadowColor = Theme.viewElevationShadowColor.cgColor
        emojiIdLabelContainerView.layer.shadowOpacity = 0.2
        emojiIdLabelContainerView.layer.shadowOffset = CGSize(width: 6, height: 6)
        emojiIdLabelContainerView.layer.shadowRadius = 20
        emojiIdLabelContainerView.layer.masksToBounds = false
        // terms
        containerView.addSubview(termsTextView)
        termsTextView.isEditable = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.backgroundColor = .clear
        termsTextView.isScrollEnabled = false
        termsTextView.bottomAnchor.constraint(
            equalTo: margins.bottomAnchor,
            constant: Theme.termsButtonBottomMargin
        ).isActive = true
        termsTextView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        termsTextView.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: Theme.primaryButtonColor
        ]
        // formatting
        let termsText = localized("display_yat.terms")
        let termsTextColoredPart = localized("display_yat.terms.colored")
        let attributedText = NSMutableAttributedString(string: termsText)
        if let termsTextColoredPartStartIndex = termsText.indexDistance(of: termsTextColoredPart) {
            let range = NSRange(location: termsTextColoredPartStartIndex, length: termsTextColoredPart.count)
            attributedText.addAttribute(
                .link,
                value: "https://dev.yat.rocks/partner/\(YatLib.appConfig.pathKey)/create",
                range: range
            )
            attributedText.addAttribute(
                .foregroundColor,
                value: Theme.primaryButtonColor,
                range: range
            )
        }
        termsTextView.attributedText = attributedText
        termsTextView.font = Theme.termsFont
        termsTextView.textColor = Color.termsGray
        termsTextView.textAlignment = .center
        termsTextView.sizeToFit()
        
        // upgrade to custom Yat button
        upgradeToCustomYatButton.backgroundColor = Color.clear
        upgradeToCustomYatButton.tintColor = Color.clear
        upgradeToCustomYatButton.setTitle(
            localized("display_yat.upgrade_to_custom_yat"),
            for: .normal
        )
        upgradeToCustomYatButton.setTitleColor(Color.white, for: .normal)
        upgradeToCustomYatButton.titleLabel?.font = Theme.buttonFont
        upgradeToCustomYatButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(upgradeToCustomYatButton)
        upgradeToCustomYatButton.widthAnchor.constraint(
            equalTo: containerView.widthAnchor,
            constant: -32
        ).isActive = true
        upgradeToCustomYatButton.heightAnchor.constraint(
            equalToConstant: Theme.buttonHeight
        ).isActive = true
        upgradeToCustomYatButton.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        upgradeToCustomYatButton.bottomAnchor.constraint(
            equalTo: termsTextView.topAnchor,
            constant: Theme.upgradeToCustomYatButtonBottomMargin
        ).isActive = true
        upgradeToCustomYatButton.addTarget(
            self,
            action: #selector(onUpgradeToCustomYatButtonTouchUpInside),
            for: .touchUpInside
        )
        // button gradient
        upgradeToCustomYatButtonGradientView.translatesAutoresizingMaskIntoConstraints = false
        upgradeToCustomYatButtonGradientView.layer.cornerRadius = 2
        upgradeToCustomYatButtonGradientView.layer.masksToBounds = true
        containerView.addSubview(upgradeToCustomYatButtonGradientView)
        upgradeToCustomYatButtonGradientView.widthAnchor.constraint(
            equalTo: upgradeToCustomYatButton.widthAnchor
        ).isActive = true
        upgradeToCustomYatButtonGradientView.heightAnchor.constraint(
            equalTo: upgradeToCustomYatButton.heightAnchor
        ).isActive = true
        upgradeToCustomYatButtonGradientView.centerXAnchor.constraint(
            equalTo: upgradeToCustomYatButton.centerXAnchor
        ).isActive = true
        upgradeToCustomYatButtonGradientView.centerYAnchor.constraint(
            equalTo: upgradeToCustomYatButton.centerYAnchor
        ).isActive = true
        containerView.sendSubviewToBack(upgradeToCustomYatButtonGradientView)
        // web link icon
        containerView.addSubview(webLinkIconImageView)
        webLinkIconImageView.image = Theme.webLinkIconWhiteImage
        webLinkIconImageView.translatesAutoresizingMaskIntoConstraints = false
        webLinkIconImageView.heightAnchor.constraint(
            equalToConstant: 16
        ).isActive = true
        webLinkIconImageView.widthAnchor.constraint(
            equalToConstant: 16
        ).isActive = true
        webLinkIconImageView.centerYAnchor.constraint(
            equalTo: upgradeToCustomYatButton.centerYAnchor
        ).isActive = true
        webLinkIconImageView.trailingAnchor.constraint(
            equalTo: upgradeToCustomYatButton.trailingAnchor,
            constant: -16
        ).isActive = true
        // upgrade Yat activity indicator
        upgradeToCustomYatActivityIndicator.style = .medium
        upgradeToCustomYatActivityIndicator.color = .white
        upgradeToCustomYatActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(upgradeToCustomYatActivityIndicator)
        upgradeToCustomYatActivityIndicator.hidesWhenStopped = true
        upgradeToCustomYatActivityIndicator.centerXAnchor.constraint(
            equalTo: upgradeToCustomYatButton.centerXAnchor
        ).isActive = true
        upgradeToCustomYatActivityIndicator.centerYAnchor.constraint(
            equalTo: upgradeToCustomYatButton.centerYAnchor
        ).isActive = true
        containerView.bringSubviewToFront(upgradeToCustomYatActivityIndicator)
        // got it button
        checkoutButton.layer.cornerRadius = 2
        checkoutButton.tintColor = Theme.primaryButtonColor
        checkoutButton.backgroundColor = Theme.primaryButtonColor
        checkoutButton.setTitle(localized("display_yat.got_it"), for: .normal)
        checkoutButton.setTitleColor(Color.white, for: .normal)
        checkoutButton.titleLabel?.font = Theme.buttonFont
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(checkoutButton)
        checkoutButton.widthAnchor.constraint(
            equalTo: containerView.widthAnchor,
            constant: -32
        ).isActive = true
        checkoutButton.heightAnchor.constraint(
            equalToConstant: Theme.buttonHeight
        ).isActive = true
        checkoutButton.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        checkoutButton.bottomAnchor.constraint(
            equalTo: upgradeToCustomYatButton.topAnchor,
            constant: -12
        ).isActive = true
        checkoutButton.addTarget(
            self,
            action: #selector(onCheckoutButtonTouchUpInside),
            for: .touchUpInside
        )
        // checkout activity indicator
        checkoutActivityIndicator.style = .medium
        checkoutActivityIndicator.color = .white
        checkoutActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(checkoutActivityIndicator)
        checkoutActivityIndicator.hidesWhenStopped = true
        checkoutActivityIndicator.centerXAnchor.constraint(
            equalTo: checkoutButton.centerXAnchor
        ).isActive = true
        checkoutActivityIndicator.centerYAnchor.constraint(
            equalTo: checkoutButton.centerYAnchor
        ).isActive = true
        containerView.bringSubviewToFront(checkoutActivityIndicator)
    }
    
    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    @objc func onCheckoutButtonTouchUpInside() {
        checkoutButton.isEnabled = false
        upgradeToCustomYatButton.isEnabled = false
        backButton.isEnabled = false
        closeButton.isEnabled = false
        checkoutButton.setTitle("", for: .normal)
        checkoutActivityIndicator.startAnimating()
        // checkout
        YatAPI.shared.checkout {
            (order) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                [weak self] in
                self?.onCheckoutSuccessful(order: order)
            }
        } onError: {
            (_) in
            DispatchQueue.main.async {
                [weak self] in
                self?.displayError(messageKey: "common.error.message.checkout")
            }
        }

    }
    
    @objc func onUpgradeToCustomYatButtonTouchUpInside() {
        checkoutButton.isEnabled = false
        upgradeToCustomYatButton.isEnabled = false
        backButton.isEnabled = false
        closeButton.isEnabled = false
        upgradeToCustomYatButton.setTitle("", for: .normal)
        upgradeToCustomYatActivityIndicator.startAnimating()
        // clear cart
        YatAPI.shared.clearCart {
            DispatchQueue.main.async {
                [weak self] in
                self?.continueToWebAppForYatCreation()
            }
        } onError: {
            (_) in
            DispatchQueue.main.async {
                [weak self] in
                self?.displayError(messageKey: "common.error.message.clear_cart")
            }
        }
    }
    
    private func continueToWebAppForYatCreation() {
        dismiss(animated: true) {
            if let url = URL(
                string: YatAPI.yatWebAppBaseURL
                    + "/partner/\(YatLib.appConfig.pathKey)/create?refresh_token="
                    + YatAPI.credentials.refreshToken
            ) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func onBackButtonTouchUpInside() {
        dismiss(animated: true)
    }
    
    @objc func onCloseButtonTouchUpInside() {
        YatLib.stop()
    }
    
    @objc func onGotItButtonTouchUpInside() {
        // checkout
    }
    
    private func onCheckoutSuccessful(order: YatOrder) {
        let updateRequest = YatUpdateRequest()
        updateRequest.insertRecords = YatLib.records
        YatAPI.shared.updateYat(
            yat: order.emojiId!,
            updateRequest: updateRequest
        ) {
            DispatchQueue.main.async {
                YatLib.complete(order: order)
            }
        } onError: {
            (error) in
            DispatchQueue.main.async {
                [weak self] in
                self?.displayError(messageKey: "common.error.message.update_yat")
            }
        }
    }
    
    private func displayError(messageKey: String) {
        checkoutButton.setTitle(
            localized("display_yat.got_it"),
            for: .normal
        )
        upgradeToCustomYatButton.setTitle(
            localized("display_yat.upgrade_to_custom_yat"),
            for: .normal
        )
        upgradeToCustomYatButton.isEnabled = true
        checkoutButton.isEnabled = true
        backButton.isEnabled = true
        closeButton.isEnabled = true
        upgradeToCustomYatActivityIndicator.stopAnimating()
        checkoutActivityIndicator.stopAnimating()
        
        let alert = UIAlertController(
            title: localized("common.error.title"),
            message: localized(messageKey),
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: localized("common.close"),
                style: .default,
                handler: nil
            )
        )
        self.present(alert, animated: true)
    }
    
}
