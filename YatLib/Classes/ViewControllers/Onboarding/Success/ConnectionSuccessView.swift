//  ConnectionSuccessView.swift
	
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

final class ConnectionSuccessView: UIView {
    
    // MARK: - Subviews
    
    @View private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Yat.style.backgroundColor
        view.layer.cornerRadius = 23.0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    @View var closeButton = CloseButton()
    @View var yatCapsule = YatCapsule()
    
    @View private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = localized("success.title")
        view.font = Yat.style.titleStyle.font
        view.textColor = Yat.style.titleStyle.color
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    @View private var descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = localized("success.description")
        view.font = Yat.style.descriptionStyle.font
        view.textColor = Yat.style.descriptionStyle.color
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    @View var confirmButton: OnboardingButton = {
        let view = OnboardingButton(style: Yat.style.primaryButtonStyle)
        view.setTitle(localized("success.button"), for: .normal)
        return view
    }()
    
    // MARK: - Properties
    
    private let capsuleMargin = 30.0
    private var contentViewTopConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupViews() {
        backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    private func setupConstraints() {
        
        addSubview(contentView)
        [closeButton, yatCapsule, titleLabel, descriptionLabel, confirmButton].forEach(contentView.addSubview)
        
        let contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: bottomAnchor)
        self.contentViewTopConstraint = contentViewTopConstraint
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        let constraints = [
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopConstraint,
        ]
        
        let contentViewContraints = [
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            yatCapsule.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55.0),
            yatCapsule.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: capsuleMargin),
            yatCapsule.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -capsuleMargin),
            yatCapsule.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            yatCapsule.heightAnchor.constraint(equalToConstant: 63.0),
            titleLabel.topAnchor.constraint(equalTo: yatCapsule.bottomAnchor, constant: 40.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0),
            confirmButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40.0),
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30.0),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0),
            confirmButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50.0),
        ]
        
        constraints.forEach { $0.priority = .init(999.0) }
        
        NSLayoutConstraint.activate(constraints + contentViewContraints)
    }
    
    // MARK: - Actions
    
    func showContent() {
        
        guard contentViewTopConstraint?.isActive == true else { return }
        
        contentViewTopConstraint?.isActive = false
        contentViewBottomConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut,
                       animations: { [weak self] in self?.layoutIfNeeded() },
                       completion: nil)
    }
    
    func hideContent() {
        
        guard contentViewTopConstraint?.isActive == false else { return }
        
        contentViewBottomConstraint?.isActive = false
        contentViewTopConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut,
                       animations: { [weak self] in self?.layoutIfNeeded() },
                       completion: nil)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        yatCapsule.maxWidth = bounds.height - 2.0 * capsuleMargin
    }
}
