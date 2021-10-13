//  OnboardingPage3ViewController.swift
	
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
import Combine
import TariCommon

final class OnboardingPage3ViewController: UIViewController {
    
    // MARK: - Properties
    
    var onCloseButtonTap: (() -> Void)?
    
    private let mainView = OnboardingPage3View()
    private let model: OnboardingPage3Model
    private var cancelables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init(records: [YatRecordInput]) {
        model = OnboardingPage3Model(records: records)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedbacks()
    }
    
    // MARK: - Setups
    
    private func setupFeedbacks() {
        
        mainView.getYatButton.onTap = { [weak self] in
            self?.model.openCreateYatFlow()
        }
        
        mainView.connectYatButton.onTap = { [weak self] in
            self?.model.openConnectYatPage()
        }
        
        mainView.closeButton.onTap = { [weak self] in
            self?.onCloseButtonTap?()
        }
        
        model.$errorMessage
            .sink { [weak self] in self?.show(errorMessage: $0) }
            .store(in: &cancelables)
    }
    
    // MARK: - Actions
    
    private func show(errorMessage: ErrorMessage?) {
        guard let errorMessage = errorMessage else { return }
        let controller = UIAlertController(title: errorMessage.title, message: errorMessage.description, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: localized("common.ok"), style: .default))
        present(controller, animated: true)
    }
}
