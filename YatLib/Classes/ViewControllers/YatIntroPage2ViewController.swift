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

protocol YatIntroPage2ViewControllerDelegate: class {
    func goToPage3()
}

class YatIntroPage2ViewController: UIViewController {
    
    private let containerView = UIView()
    private let yatLogoImageView = UIImageView()
    private let backgroundGraphicImageView = UIImageView()
    private let sendingBTCToLabelContainerView = UIView()
    private let sendingBTCToLabel = UILabel()
    private let emojiContainerView = UIView()
    private let rocketEmojiImageView = UIImageView()
    private let fullMoonEmojiImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
    
    weak var delegate: YatIntroPage2ViewControllerDelegate?
    
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
        yatLogoImageView.widthAnchor.constraint(equalToConstant: 81).isActive = true
        yatLogoImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
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
        backgroundGraphicImageView.image = Theme.infoPage2BackgroundGraphicImage
        backgroundGraphicImageView.widthAnchor.constraint(
            equalToConstant: 256
        ).isActive = true
        backgroundGraphicImageView.heightAnchor.constraint(
            equalToConstant: 396
        ).isActive = true
        backgroundGraphicImageView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        backgroundGraphicImageView.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: Theme.page2BackgroundTopMargin
        ).isActive = true
        // "sending btc to" container
        containerView.addSubview(sendingBTCToLabelContainerView)
        sendingBTCToLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        sendingBTCToLabelContainerView.backgroundColor = Theme.containerBackgroundColor
        sendingBTCToLabelContainerView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        sendingBTCToLabelContainerView.topAnchor.constraint(
            equalTo: backgroundGraphicImageView.topAnchor,
            constant: Theme.sendingBTCToLabelTopMargin
        ).isActive = true
        sendingBTCToLabelContainerView.layer.cornerRadius = 12
        // "sending btc to" label
        sendingBTCToLabelContainerView.addSubview(sendingBTCToLabel)
        sendingBTCToLabel.translatesAutoresizingMaskIntoConstraints = false
        sendingBTCToLabel.textColor = Theme.infoTitleColor
        sendingBTCToLabel.font = UIFont.AllianceNo1.bold.withSize(14)
        sendingBTCToLabel.text = localized("step2.sending_btc_to")
        sendingBTCToLabel.sizeToFit()
        sendingBTCToLabel.centerXAnchor.constraint(
            equalTo: sendingBTCToLabelContainerView.centerXAnchor
        ).isActive = true
        sendingBTCToLabel.centerYAnchor.constraint(
            equalTo: sendingBTCToLabelContainerView.centerYAnchor
        ).isActive = true
        sendingBTCToLabelContainerView.widthAnchor.constraint(
            equalTo: sendingBTCToLabel.widthAnchor,
            constant: 8
        ).isActive = true
        sendingBTCToLabelContainerView.heightAnchor.constraint(
            equalTo: sendingBTCToLabel.heightAnchor,
            constant: 8
        ).isActive = true
        sendingBTCToLabelContainerView.layer.shadowColor = Theme.containerBackgroundColor.cgColor
        sendingBTCToLabelContainerView.layer.shadowOpacity = 0.75
        sendingBTCToLabelContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        sendingBTCToLabelContainerView.layer.shadowRadius = 8
        sendingBTCToLabelContainerView.layer.masksToBounds = false
        // emoji container
        containerView.addSubview(emojiContainerView)
        emojiContainerView.translatesAutoresizingMaskIntoConstraints = false
        emojiContainerView.backgroundColor = Color.white
        emojiContainerView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        emojiContainerView.topAnchor.constraint(
            equalTo: sendingBTCToLabelContainerView.bottomAnchor,
            constant: 16
        ).isActive = true
        emojiContainerView.layer.cornerRadius = 44
        emojiContainerView.layer.masksToBounds = true
        // rocket
        rocketEmojiImageView.image = Theme.rocketImage
        rocketEmojiImageView.translatesAutoresizingMaskIntoConstraints = false
        rocketEmojiImageView.widthAnchor.constraint(
            equalToConstant: 72
        ).isActive = true
        rocketEmojiImageView.heightAnchor.constraint(
            equalToConstant: 72
        ).isActive = true
        emojiContainerView.addSubview(rocketEmojiImageView)
        rocketEmojiImageView.leadingAnchor.constraint(
            equalTo: emojiContainerView.leadingAnchor,
            constant: 26
        ).isActive = true
        rocketEmojiImageView.topAnchor.constraint(
            equalTo: emojiContainerView.topAnchor,
            constant: 8
        ).isActive = true
        emojiContainerView.bottomAnchor.constraint(
            equalTo: rocketEmojiImageView.bottomAnchor,
            constant: 8
        ).isActive = true
        // moon
        fullMoonEmojiImageView.image = Theme.fullMoonImage
        fullMoonEmojiImageView.translatesAutoresizingMaskIntoConstraints = false
        fullMoonEmojiImageView.widthAnchor.constraint(
            equalToConstant: 72
        ).isActive = true
        fullMoonEmojiImageView.heightAnchor.constraint(
            equalToConstant: 72
        ).isActive = true
        emojiContainerView.addSubview(fullMoonEmojiImageView)
        fullMoonEmojiImageView.leadingAnchor.constraint(
            equalTo: rocketEmojiImageView.trailingAnchor,
            constant: 6
        ).isActive = true
        fullMoonEmojiImageView.trailingAnchor.constraint(
            equalTo: emojiContainerView.trailingAnchor,
            constant: -26
        ).isActive = true
        fullMoonEmojiImageView.topAnchor.constraint(
            equalTo: rocketEmojiImageView.topAnchor
        ).isActive = true
        // emoji container shadow
        emojiContainerView.layer.shadowColor = Theme.viewElevationShadowColor.cgColor
        emojiContainerView.layer.shadowOpacity = 0.10
        emojiContainerView.layer.shadowOffset = CGSize(width: 10, height: 20)
        emojiContainerView.layer.shadowRadius = 25
        emojiContainerView.layer.masksToBounds = false
        // button
        button.layer.cornerRadius = 2
        button.tintColor = Theme.primaryButtonColor
        button.backgroundColor = Theme.primaryButtonColor
        button.setTitle(localized("common.next"), for: .normal)
        button.setTitleColor(Color.white, for: .normal)
        button.titleLabel?.font = Theme.buttonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(button)
        button.widthAnchor.constraint(
            equalTo: containerView.widthAnchor,
            constant: -32
        ).isActive = true
        button.heightAnchor.constraint(
            equalToConstant: Theme.buttonHeight
        ).isActive = true
        button.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        button.bottomAnchor.constraint(
            equalTo: margins.bottomAnchor,
            constant: -48
        ).isActive = true
        // description
        descriptionLabel.textColor = Color.xLightGray
        descriptionLabel.font = Theme.infoDescriptionFont
        descriptionLabel.text = String(
            format: localized("step2.description"),
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
            equalTo: button.topAnchor,
            constant: Theme.infoDescriptionBottomMargin
        ).isActive = true
        descriptionLabel.sizeToFit()
        // title
        titleLabel.textColor = Theme.infoTitleColor
        titleLabel.font = Theme.infoTitleFont
        titleLabel.text = localized("step2.title")
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
        
        // button action
        button.addTarget(
            self,
            action: #selector(onNextButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc func onNextButtonTouchUpInside() {
        delegate?.goToPage3()
    }
    
}
