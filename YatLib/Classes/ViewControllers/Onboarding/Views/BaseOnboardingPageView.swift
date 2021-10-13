//  BaseOnboardingPageView.swift
	
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
import TariCommon

class BaseOnboardingPageView: UIView {
    
    // MARK: - Subviews
    
    @View private var yatLogoView: UIImageView = {
        let view = UIImageView(image: .yatLogo)
        view.tintColor = Yat.style.yatLogoTintColor
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    @View var closeButton = CloseButton()
    
    @View private var topContentView = UIView()
    
    @View private var contentView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    @View var titleLabel: UILabel = {
        let view = UILabel()
        view.font = Yat.style.titleStyle.font
        view.textColor = Yat.style.titleStyle.color
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    @View var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = Yat.style.descriptionStyle.font
        view.textColor = Yat.style.descriptionStyle.color
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    @View var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10.0
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupConstraints() {
        
        contentView.setContentHuggingPriority(.defaultLow, for: .vertical)
        contentView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        [yatLogoView, closeButton, topContentView, titleLabel, descriptionLabel, buttonsStackView].forEach(addSubview)
        topContentView.addSubview(contentView)
        
        let smallScreenContentViewMargin = UIScreen.isSmallScreen ? 12.0 : 12.0
        
        let constraints = [
            yatLogoView.topAnchor.constraint(equalTo: topAnchor, constant: 30.0),
            yatLogoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0),
            topContentView.topAnchor.constraint(equalTo: yatLogoView.bottomAnchor, constant: smallScreenContentViewMargin),
            topContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: smallScreenContentViewMargin),
            topContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -smallScreenContentViewMargin),
            titleLabel.topAnchor.constraint(equalTo: topContentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
            buttonsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60.0),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let animationViewConstraints = [
            contentView.topAnchor.constraint(equalTo: topContentView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: topContentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints + animationViewConstraints)
    }
    
    // MARK: - Actions
    
    func showContent(withName name: String) {
        contentView.image = UIImage(named: name, in: .local, with: nil)
    }
}
