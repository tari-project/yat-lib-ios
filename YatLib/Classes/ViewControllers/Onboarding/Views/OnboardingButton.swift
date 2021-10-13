//  OnboardingButton.swift
	
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

final class OnboardingButton: UIButton {
    
    // MARK: - Subviews
    
    @View private var linkImageView: UIImageView = {
        let view = UIImageView(image: .webLinkIcon)
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    // MARK: - Properties
    
    var isLinkImageVisible: Bool = false {
        didSet { linkImageView.isHidden = !isLinkImageVisible }
    }
    var linkImageRightMargin: CGFloat = 25.0 {
        didSet { linkImageViewTrailingConstraint?.constant = -linkImageRightMargin }
    }
    var onTap: (() -> Void)?
    
    private var linkImageViewTrailingConstraint: NSLayoutConstraint?
    
    // MARK: - Initalizers
    
    init(style: ButtonStyle) {
        super.init(frame: .zero)
        setupView(style: style)
        setupConstraints()
        setupFeedback()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupView(style: ButtonStyle) {
        backgroundColor = style.backgroundColor
        setTitleColor(style.textStyle.color, for: .normal)
        titleLabel?.font = style.textStyle.font
        linkImageView.tintColor = style.textStyle.color
        layer.cornerRadius = 8.0
    }
    
    private func setupConstraints() {
        addSubview(linkImageView)
        
        let linkImageViewTrailingConstraint = linkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -linkImageRightMargin)
        self.linkImageViewTrailingConstraint = linkImageViewTrailingConstraint
        
        let constraints = [
            linkImageViewTrailingConstraint,
            linkImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupFeedback() {
        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Action Targets
    
    @objc private func onTouchUpInside() { onTap?() }
    
    // MARK: Autolayout
    
    override var intrinsicContentSize: CGSize { CGSize(width: UIView.noIntrinsicMetric, height: 48.0) }
}
