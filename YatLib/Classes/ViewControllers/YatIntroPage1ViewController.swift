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

protocol YatIntroPage1ViewControllerDelegate: class {
    func goToPage2()
}

class YatIntroPage1ViewController: UIViewController {
    
    private let containerView = UIView()
    private let yatLogoImageView = UIImageView()
    private let txInfoContainerView = UIView()
    private let txInfoTitleLabel = UILabel()
    private let txInfoFromLabel = UILabel()
    private let txInfoFromAddressLabel = UILabel()
    private let txInfoFromAddressLabelGradient = HorizontalGradientView(
        startColor: Color.clear,
        endColor: Color.white
    )
    private let txInfoToLabel = UILabel()
    private let txInfoToAddressLabel = UILabel()
    private let txInfoToAddressLabelGradient = HorizontalGradientView(
        startColor: Color.clear,
        endColor: Color.white
    )
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
    // background images
    private let cardanoLogoImageView = UIImageView()
    private let ethereumLogoImageView = UIImageView()
    private let bitcoinLogoImageView = UIImageView()
    private let tronLogoImageView = UIImageView()
    private let dashLogoImageView = UIImageView()
    private let tetherLogoImageView = UIImageView()
    
    weak var delegate: YatIntroPage1ViewControllerDelegate?
    
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
        // tx info container view
        txInfoContainerView.backgroundColor = Color.white
        txInfoContainerView.layer.cornerRadius = 25
        containerView.addSubview(txInfoContainerView)
        txInfoContainerView.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.widthAnchor.constraint(equalToConstant: 292).isActive = true
        txInfoContainerView.heightAnchor.constraint(equalToConstant: 205).isActive = true
        txInfoContainerView.centerXAnchor.constraint(
            equalTo: containerView.centerXAnchor
        ).isActive = true
        txInfoContainerView.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: Theme.page1TxInfoContainerTopMargin
        ).isActive = true
        txInfoContainerView.layer.shadowColor = Theme.viewElevationShadowColor.cgColor
        txInfoContainerView.layer.shadowOpacity = 0.15
        txInfoContainerView.layer.shadowOffset = CGSize(width: 10, height: 40)
        txInfoContainerView.layer.shadowRadius = 25
        // tx info title
        txInfoTitleLabel.font = UIFont.AllianceNo1.bold.withSize(14)
        txInfoTitleLabel.textColor = Color.black
        txInfoTitleLabel.text = localized("step1.tx_info.sending_btc")
        txInfoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.addSubview(txInfoTitleLabel)
        txInfoTitleLabel.topAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: 20
        ).isActive = true
        txInfoTitleLabel.centerXAnchor.constraint(
            equalTo: txInfoContainerView.centerXAnchor
        ).isActive = true
        // cardano logo
        containerView.addSubview(cardanoLogoImageView)
        cardanoLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        cardanoLogoImageView.image = UIImage(
            named: "CardanoLogo",
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )
        cardanoLogoImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        cardanoLogoImageView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        cardanoLogoImageView.trailingAnchor.constraint(
            equalTo: containerView.trailingAnchor
        ).isActive = true
        cardanoLogoImageView.centerYAnchor.constraint(
            equalTo: txInfoContainerView.centerYAnchor
        ).isActive = true
        containerView.sendSubviewToBack(cardanoLogoImageView)
        // ethereum logo
        containerView.addSubview(ethereumLogoImageView)
        ethereumLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        ethereumLogoImageView.image = UIImage(
            named: "EthereumLogo",
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )
        ethereumLogoImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        ethereumLogoImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        ethereumLogoImageView.trailingAnchor.constraint(
            equalTo: txInfoContainerView.trailingAnchor
        ).isActive = true
        ethereumLogoImageView.topAnchor.constraint(
            equalTo: txInfoContainerView.bottomAnchor,
            constant: -25
        ).isActive = true
        containerView.sendSubviewToBack(ethereumLogoImageView)
        // bitcoin logo
        containerView.addSubview(bitcoinLogoImageView)
        bitcoinLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        bitcoinLogoImageView.image = UIImage(
            named: "BitcoinLogo",
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )
        bitcoinLogoImageView.widthAnchor.constraint(equalToConstant: 54).isActive = true
        bitcoinLogoImageView.heightAnchor.constraint(equalToConstant: 86).isActive = true
        bitcoinLogoImageView.leadingAnchor.constraint(
            equalTo: containerView.leadingAnchor
        ).isActive = true
        bitcoinLogoImageView.bottomAnchor.constraint(
            equalTo: txInfoContainerView.bottomAnchor,
            constant: 40
        ).isActive = true
        containerView.sendSubviewToBack(bitcoinLogoImageView)
        // tron logo
        containerView.addSubview(tronLogoImageView)
        tronLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        tronLogoImageView.image = UIImage(
            named: "TronLogo",
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )
        tronLogoImageView.widthAnchor.constraint(equalToConstant: 59).isActive = true
        tronLogoImageView.heightAnchor.constraint(equalToConstant: 59).isActive = true
        tronLogoImageView.leadingAnchor.constraint(
            equalTo: txInfoContainerView.leadingAnchor,
            constant: -24
        ).isActive = true
        tronLogoImageView.bottomAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: 25
        ).isActive = true
        containerView.sendSubviewToBack(tronLogoImageView)
        // dash logo
        containerView.addSubview(dashLogoImageView)
        dashLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        dashLogoImageView.image = UIImage(
            named: "DashLogo",
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )
        dashLogoImageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        dashLogoImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        dashLogoImageView.trailingAnchor.constraint(
            equalTo: txInfoContainerView.trailingAnchor,
            constant: -10
        ).isActive = true
        dashLogoImageView.bottomAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: 24
        ).isActive = true
        containerView.sendSubviewToBack(dashLogoImageView)
        // tether logo
        containerView.addSubview(tetherLogoImageView)
        tetherLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        tetherLogoImageView.image = UIImage(
            named: "TetherLogo",
            in: Bundle(for: YatIntroPageViewController.self),
            compatibleWith: nil
        )
        tetherLogoImageView.widthAnchor.constraint(equalToConstant: 33).isActive = true
        tetherLogoImageView.heightAnchor.constraint(equalToConstant: 33).isActive = true
        tetherLogoImageView.trailingAnchor.constraint(
            equalTo: dashLogoImageView.leadingAnchor,
            constant: -5
        ).isActive = true
        tetherLogoImageView.bottomAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: -2
        ).isActive = true
        containerView.sendSubviewToBack(tetherLogoImageView)
        // tx info from
        txInfoFromLabel.font = UIFont.AllianceNo1.bold.withSize(12)
        txInfoFromLabel.textColor = Color.lightGray
        txInfoFromLabel.text = localized("step1.tx_info.from")
        txInfoFromLabel.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.addSubview(txInfoFromLabel)
        txInfoFromLabel.topAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: 46
        ).isActive = true
        txInfoFromLabel.leadingAnchor.constraint(
            equalTo: txInfoContainerView.leadingAnchor,
            constant: 20
        ).isActive = true
        // tx info from address
        txInfoFromAddressLabel.font = UIFont.AllianceNo1.semiBold.withSize(16)
        txInfoFromAddressLabel.textColor = Color.xDarkGray
        txInfoFromAddressLabel.text = localized("step1.tx_info.from.address")
        txInfoFromAddressLabel.alpha = 0.77
        txInfoFromAddressLabel.backgroundColor = Color.xxLightGray
        txInfoFromAddressLabel.textAlignment = .center
        txInfoFromAddressLabel.layer.cornerRadius = 20
        txInfoFromAddressLabel.layer.masksToBounds = true
        txInfoFromAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.addSubview(txInfoFromAddressLabel)
        txInfoFromAddressLabel.topAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: 70
        ).isActive = true
        txInfoFromAddressLabel.heightAnchor.constraint(
            equalToConstant: 40
        ).isActive = true
        txInfoFromAddressLabel.widthAnchor.constraint(
            equalTo: txInfoContainerView.widthAnchor,
            constant: -40
        ).isActive = true
        txInfoFromAddressLabel.centerXAnchor.constraint(
            equalTo: txInfoContainerView.centerXAnchor
        ).isActive = true
        // tx info from addres gradient
        txInfoFromAddressLabelGradient.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.addSubview(txInfoFromAddressLabelGradient)
        txInfoFromAddressLabelGradient.topAnchor.constraint(
            equalTo: txInfoFromAddressLabel.topAnchor
        ).isActive = true
        txInfoFromAddressLabelGradient.bottomAnchor.constraint(
            equalTo: txInfoFromAddressLabel.bottomAnchor
        ).isActive = true
        txInfoFromAddressLabelGradient.trailingAnchor.constraint(
            equalTo: txInfoFromAddressLabel.trailingAnchor
        ).isActive = true
        txInfoFromAddressLabelGradient.widthAnchor.constraint(
            equalToConstant: 90
        ).isActive = true
        // tx info to
        txInfoToLabel.font = UIFont.AllianceNo1.bold.withSize(12)
        txInfoToLabel.textColor = Color.lightGray
        txInfoToLabel.text = localized("step1.tx_info.to")
        txInfoToLabel.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.addSubview(txInfoToLabel)
        txInfoToLabel.topAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: 121
        ).isActive = true
        txInfoToLabel.leadingAnchor.constraint(
            equalTo: txInfoContainerView.leadingAnchor,
            constant: 20
        ).isActive = true
        // tx info to address
        txInfoToAddressLabel.font = UIFont.AllianceNo1.semiBold.withSize(16)
        txInfoToAddressLabel.textColor = Color.xDarkGray
        txInfoToAddressLabel.text = localized("step1.tx_info.to.address")
        txInfoToAddressLabel.alpha = 0.77
        txInfoToAddressLabel.backgroundColor = Color.xxLightGray
        txInfoToAddressLabel.textAlignment = .center
        txInfoToAddressLabel.layer.cornerRadius = 20
        txInfoToAddressLabel.layer.masksToBounds = true
        txInfoToAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.addSubview(txInfoToAddressLabel)
        txInfoToAddressLabel.topAnchor.constraint(
            equalTo: txInfoContainerView.topAnchor,
            constant: 145
        ).isActive = true
        txInfoToAddressLabel.heightAnchor.constraint(
            equalToConstant: 40
        ).isActive = true
        txInfoToAddressLabel.widthAnchor.constraint(
            equalTo: txInfoContainerView.widthAnchor,
            constant: -40
        ).isActive = true
        txInfoToAddressLabel.centerXAnchor.constraint(
            equalTo: txInfoContainerView.centerXAnchor
        ).isActive = true
        // tx info to address gradient
        txInfoToAddressLabelGradient.translatesAutoresizingMaskIntoConstraints = false
        txInfoContainerView.addSubview(txInfoToAddressLabelGradient)
        txInfoToAddressLabelGradient.topAnchor.constraint(
            equalTo: txInfoToAddressLabel.topAnchor
        ).isActive = true
        txInfoToAddressLabelGradient.bottomAnchor.constraint(
            equalTo: txInfoToAddressLabel.bottomAnchor
        ).isActive = true
        txInfoToAddressLabelGradient.trailingAnchor.constraint(
            equalTo: txInfoToAddressLabel.trailingAnchor
        ).isActive = true
        txInfoToAddressLabelGradient.widthAnchor.constraint(
            equalToConstant: 90
        ).isActive = true
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
            format: Theme.isSmallScreen
                ? localized("step1.description.small_screen")
                : localized("step1.description"),
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
        titleLabel.text = localized("step1.title")
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
        delegate?.goToPage2()
    }
    
}
