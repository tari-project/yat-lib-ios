//  YatCapsule.swift
	
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

final class YatCapsule: UIView {

    // MARK: - Subviews
    
    @View private var label: UILabel = {
        let view = UILabel()
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    // MARK: - Properties
    
    var text: String? {
        didSet {
            label.text = text
            updateLabel()
        }
    }
    
    var maxWidth: CGFloat = 0.0 {
        didSet { updateLabel() }
    }
    
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
        backgroundColor = Yat.style.backgroundColor
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor.capsuleShadow.cgColor
        layer.shadowRadius = 35.0
        layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
    }
    
    private func setupConstraints() {
        
        addSubview(label)
        
        let constratins = [
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17.0),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constratins)
    }
    
    private func updateLabel() {
        
        let baseFontSize = 16.0
        let size = NSAttributedString(string: label.text ?? "", attributes: [.font: UIFont.systemFont(ofSize: baseFontSize)]).size()
        
        let widthScale = maxWidth / size.width
        let heightScale = bounds.height / size.height
        let scale = min(widthScale, heightScale)
        
        label.font = .systemFont(ofSize: baseFontSize * scale)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2.0
    }
}
