//  OnboardingViewController.swift
	
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

final class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mainView = OnboardingView()
    private let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private let page1ViewController = OnboardingPage1ViewController()
    private let page2ViewController = OnboardingPage2ViewController()
    private let page3ViewController: OnboardingPage3ViewController
    
    private lazy var controllers = [
        page1ViewController,
        page2ViewController,
        page3ViewController
    ]
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
        setupFeedbacks()
    }
    
    // MARK: Initializers
    
    init(records: [YatRecordInput]) {
        page3ViewController = OnboardingPage3ViewController(records: records)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupPageController() {
        
        mainView.numberOfPages = controllers.count
        move(toIndex: 0)
        
        addChild(pageController)
        mainView.contentView.addSubview(pageController.view)
        
        pageController.view.frame = mainView.contentView.bounds
        pageController.didMove(toParent: self)
    }
    
    private func setupFeedbacks() {
        
        page1ViewController.onNextButtonTap = { [weak self] in
            self?.move(toIndex: 1)
        }
        
        page2ViewController.onNextButtonTap = { [weak self] in
            self?.move(toIndex: 2)
        }
        
        let closeAction: () -> Void = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        page1ViewController.onCloseButtonTap = closeAction
        page2ViewController.onCloseButtonTap = closeAction
        page3ViewController.onCloseButtonTap = closeAction
    }
    
    // MARK: - Actions
    
    private func move(toIndex index: Int) {
        let controller = controllers[index]
        pageController.setViewControllers([controller], direction: .forward, animated: true)
        mainView.currentPageIndex = index
    }
}
