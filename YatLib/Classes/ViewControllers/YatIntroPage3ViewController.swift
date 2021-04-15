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

protocol YatIntroPage3ViewControllerDelegate: class {
    func goToDisplayYatPage(order: YatOrder)
    func connectExistingYat()
}

class YatIntroPage3ViewController: UIViewController {
    
    private let containerView = UIView()
    private let yatLogoImageView = UIImageView()
    private let backgroundGraphicImageView = UIImageView()
    private let emojiIdContainerView = UIView()
    private let fireEmoji1ImageView = UIImageView()
    private let hornSignEmojiImageView = UIImageView()
    private let sunglassesEmojiImageView = UIImageView()
    private let fireEmoji2ImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let seeYourYatButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView()
    private let connectExistingYatButton = UIButton()
    private let webLinkIconImageView = UIImageView()
    
    weak var delegate: YatIntroPage3ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        yatLogoImageView.widthAnchor.constraint(
            equalToConstant: 81
        ).isActive = true
        yatLogoImageView.heightAnchor.constraint(
            equalToConstant: 28
        ).isActive = true
        yatLogoImageView.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: Theme.yatLogoTopMargin
        ).isActive = true
        yatLogoImageView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        // background graphic
        containerView.addSubview(backgroundGraphicImageView)
        backgroundGraphicImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundGraphicImageView.image = Theme.infoPage3BackgroundGraphicImage
        backgroundGraphicImageView.widthAnchor.constraint(
            equalToConstant: 320
        ).isActive = true
        backgroundGraphicImageView.heightAnchor.constraint(
            equalToConstant: 320
        ).isActive = true
        backgroundGraphicImageView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        backgroundGraphicImageView.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: Theme.page3BackgroundTopMargin
        ).isActive = true
        
        // emoji container
        containerView.addSubview(emojiIdContainerView)
        emojiIdContainerView.translatesAutoresizingMaskIntoConstraints = false
        emojiIdContainerView.backgroundColor = Color.white
        emojiIdContainerView.centerXAnchor.constraint(
            equalTo: backgroundGraphicImageView.centerXAnchor
        ).isActive = true
        emojiIdContainerView.centerYAnchor.constraint(
            equalTo: backgroundGraphicImageView.centerYAnchor
        ).isActive = true
        emojiIdContainerView.layer.cornerRadius = 27
        emojiIdContainerView.layer.masksToBounds = true
        // fire 1
        fireEmoji1ImageView.image = Theme.fireImage
        fireEmoji1ImageView.translatesAutoresizingMaskIntoConstraints = false
        fireEmoji1ImageView.widthAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        fireEmoji1ImageView.heightAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        emojiIdContainerView.addSubview(fireEmoji1ImageView)
        fireEmoji1ImageView.leadingAnchor.constraint(
            equalTo: emojiIdContainerView.leadingAnchor,
            constant: 24
        ).isActive = true
        fireEmoji1ImageView.topAnchor.constraint(
            equalTo: emojiIdContainerView.topAnchor,
            constant: 10
        ).isActive = true
        emojiIdContainerView.bottomAnchor.constraint(
            equalTo: fireEmoji1ImageView.bottomAnchor,
            constant: 10
        ).isActive = true
        // horn sign
        hornSignEmojiImageView.image = Theme.hornSignImage
        hornSignEmojiImageView.translatesAutoresizingMaskIntoConstraints = false
        hornSignEmojiImageView.widthAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        hornSignEmojiImageView.heightAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        emojiIdContainerView.addSubview(hornSignEmojiImageView)
        hornSignEmojiImageView.leadingAnchor.constraint(
            equalTo: fireEmoji1ImageView.trailingAnchor,
            constant: 4
        ).isActive = true
        hornSignEmojiImageView.centerYAnchor.constraint(
            equalTo: fireEmoji1ImageView.centerYAnchor
        ).isActive = true
        // sunglasses
        sunglassesEmojiImageView.image = Theme.sunglassesImage
        sunglassesEmojiImageView.translatesAutoresizingMaskIntoConstraints = false
        sunglassesEmojiImageView.widthAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        sunglassesEmojiImageView.heightAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        emojiIdContainerView.addSubview(sunglassesEmojiImageView)
        sunglassesEmojiImageView.leadingAnchor.constraint(
            equalTo: hornSignEmojiImageView.trailingAnchor,
            constant: 4
        ).isActive = true
        sunglassesEmojiImageView.centerYAnchor.constraint(
            equalTo: fireEmoji1ImageView.centerYAnchor
        ).isActive = true
        // moon
        fireEmoji2ImageView.image = Theme.fireImage
        fireEmoji2ImageView.translatesAutoresizingMaskIntoConstraints = false
        fireEmoji2ImageView.widthAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        fireEmoji2ImageView.heightAnchor.constraint(
            equalToConstant: 36
        ).isActive = true
        emojiIdContainerView.addSubview(fireEmoji2ImageView)
        fireEmoji2ImageView.leadingAnchor.constraint(
            equalTo: sunglassesEmojiImageView.trailingAnchor,
            constant: 4
        ).isActive = true
        fireEmoji2ImageView.trailingAnchor.constraint(
            equalTo: emojiIdContainerView.trailingAnchor,
            constant: -24
        ).isActive = true
        fireEmoji2ImageView.centerYAnchor.constraint(
            equalTo: fireEmoji1ImageView.centerYAnchor
        ).isActive = true
        // emoji id container shadow
        emojiIdContainerView.layer.shadowColor = Theme.viewElevationShadowColor.cgColor
        emojiIdContainerView.layer.shadowOpacity = 0.2
        emojiIdContainerView.layer.shadowOffset = CGSize(width: 6, height: 6)
        emojiIdContainerView.layer.shadowRadius = 20
        emojiIdContainerView.layer.masksToBounds = false
        
        // connect existing Yat button
        connectExistingYatButton.layer.cornerRadius = 2
        connectExistingYatButton.tintColor = Theme.secondaryButtonColor
        connectExistingYatButton.backgroundColor = Theme.secondaryButtonColor
        connectExistingYatButton.setTitle(localized("step3.connect_an_existing_yat"), for: .normal)
        connectExistingYatButton.setTitleColor(Theme.secondaryButtonTextColor, for: .normal)
        connectExistingYatButton.titleLabel?.font = Theme.buttonFont
        connectExistingYatButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(connectExistingYatButton)
        connectExistingYatButton.widthAnchor.constraint(
            equalTo: containerView.widthAnchor,
            constant: -32
        ).isActive = true
        connectExistingYatButton.heightAnchor.constraint(
            equalToConstant: Theme.buttonHeight
        ).isActive = true
        connectExistingYatButton.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        connectExistingYatButton.bottomAnchor.constraint(
            equalTo: margins.bottomAnchor,
            constant: -48
        ).isActive = true
        // web link icon
        containerView.addSubview(webLinkIconImageView)
        webLinkIconImageView.image = Theme.webLinkIconImage
        webLinkIconImageView.translatesAutoresizingMaskIntoConstraints = false
        webLinkIconImageView.heightAnchor.constraint(
            equalToConstant: 16
        ).isActive = true
        webLinkIconImageView.widthAnchor.constraint(
            equalToConstant: 16
        ).isActive = true
        webLinkIconImageView.centerYAnchor.constraint(
            equalTo: connectExistingYatButton.centerYAnchor
        ).isActive = true
        webLinkIconImageView.trailingAnchor.constraint(
            equalTo: connectExistingYatButton.trailingAnchor,
            constant: -16
        ).isActive = true
        // see your Yat button
        seeYourYatButton.layer.cornerRadius = 2
        seeYourYatButton.tintColor = Theme.primaryButtonColor
        seeYourYatButton.backgroundColor = Theme.primaryButtonColor
        seeYourYatButton.setTitle(localized("step3.see_your_yat"), for: .normal)
        seeYourYatButton.setTitleColor(Color.white, for: .normal)
        seeYourYatButton.titleLabel?.font = Theme.buttonFont
        seeYourYatButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(seeYourYatButton)
        seeYourYatButton.widthAnchor.constraint(
            equalTo: containerView.widthAnchor,
            constant: -32
        ).isActive = true
        seeYourYatButton.heightAnchor.constraint(
            equalToConstant: Theme.buttonHeight
        ).isActive = true
        seeYourYatButton.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        seeYourYatButton.bottomAnchor.constraint(
            equalTo: connectExistingYatButton.topAnchor,
            constant: -12
        ).isActive = true
        // activity indicator
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.centerXAnchor.constraint(
            equalTo: seeYourYatButton.centerXAnchor
        ).isActive = true
        activityIndicator.centerYAnchor.constraint(
            equalTo: seeYourYatButton.centerYAnchor
        ).isActive = true
        containerView.bringSubviewToFront(activityIndicator)
        // description
        descriptionLabel.textColor = Color.xLightGray
        descriptionLabel.font = Theme.infoDescriptionFont
        descriptionLabel.text = String(
            format: localized("step3.description"),
            YatLib.appConfig.name
        )
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        descriptionLabel.widthAnchor.constraint(
            equalTo: containerView.widthAnchor,
            constant: -40
        ).isActive = true
        descriptionLabel.bottomAnchor.constraint(
            equalTo: seeYourYatButton.topAnchor,
            constant: Theme.infoDescriptionBottomMargin
        ).isActive = true
        descriptionLabel.sizeToFit()
        // title
        titleLabel.textColor = Theme.infoTitleColor
        titleLabel.font = Theme.infoTitleFont
        titleLabel.text = localized("step3.title")
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        titleLabel.widthAnchor.constraint(
            equalTo: containerView.widthAnchor,
            constant: -40
        ).isActive = true
        titleLabel.bottomAnchor.constraint(
            equalTo: descriptionLabel.topAnchor,
            constant: Theme.infoTitleBottomMargin
        ).isActive = true
        titleLabel.sizeToFit()
        
        // button actions
        seeYourYatButton.addTarget(
            self,
            action: #selector(onSeeYourYatButtonTouchUpInside),
            for: .touchUpInside
        )
        connectExistingYatButton.addTarget(
            self,
            action: #selector(onConnectExistingYatButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc func onSeeYourYatButtonTouchUpInside() {
        seeYourYatButton.setTitle("", for: .normal)
        seeYourYatButton.isEnabled = false
        connectExistingYatButton.isEnabled = false
        activityIndicator.startAnimating()
        getRandomYat()
    }
    
    @objc func onConnectExistingYatButtonTouchUpInside() {
        delegate?.connectExistingYat()
    }
    
    private func getRandomYat() {
        YatAPI.shared.getRandomYatAndAddToCart() {
            [weak self]
            (order) in
            DispatchQueue.main.async {
                [weak self] in
                self?.randomYatSuccessful(order: order)
            }
        } onError: {
            (error) in
            DispatchQueue.main.async {
                [weak self] in
                self?.displayError()
            }
        }
    }
    
    private func randomYatSuccessful(order: YatOrder) {
        seeYourYatButton.setTitle(
            localized("step3.see_your_yat"),
            for: .normal
        )
        seeYourYatButton.isEnabled = true
        connectExistingYatButton.isEnabled = true
        activityIndicator.stopAnimating()
        delegate?.goToDisplayYatPage(order: order)
    }
    
    private func displayError() {
        seeYourYatButton.setTitle(
            localized("step3.see_your_yat"),
            for: .normal
        )
        seeYourYatButton.isEnabled = true
        connectExistingYatButton.isEnabled = true
        activityIndicator.stopAnimating()
        
        let alert = UIAlertController(
            title: localized("common.error.title"),
            message: localized("common.error.message.random_yat"),
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
