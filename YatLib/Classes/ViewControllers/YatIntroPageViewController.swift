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

class YatIntroPageViewController: UIPageViewController {
    
    private let pageControl = UIPageControl()
    
    private let page1ViewController = YatIntroPage1ViewController()
    private let page2ViewController = YatIntroPage2ViewController()
    private let page3ViewController = YatIntroPage3ViewController()
    
    private(set) lazy var pages: [UIViewController] = {
        return [
            page1ViewController,
            page2ViewController,
            page3ViewController
        ]
    }()
    
    // Track the current index
    private var currentIndex: Int?
    private var pendingIndex: Int?
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        disableSwipeGesture()
        page1ViewController.delegate = self
        page2ViewController.delegate = self
        page3ViewController.delegate = self
        
        if let firstViewController = pages.first {
            setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return Theme.statusBarStyle
    }
    
}

extension YatIntroPageViewController {
    
    private func setupUI() {
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = Theme.primaryButtonColor
        pageControl.pageIndicatorTintColor = Color.lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        self.view.addSubview(self.pageControl)

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        pageControl.bottomAnchor.constraint(
            equalTo: margins.bottomAnchor,
            constant: -10
        ).isActive = true
        pageControl.centerXAnchor.constraint(
            equalTo: margins.centerXAnchor
        ).isActive = true
    }
    
}

extension YatIntroPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard pages.count > previousIndex else {
            return nil
        }
        return pages[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = index + 1
        let orderedViewControllersCount = pages.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return pages[nextIndex]
    }
    
}

extension YatIntroPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        pendingIndex = pages.firstIndex(of: pendingViewControllers.first!)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
    
}

extension YatIntroPageViewController:
    YatIntroPage1ViewControllerDelegate,
    YatIntroPage2ViewControllerDelegate,
    YatIntroPage3ViewControllerDelegate {
    
    func goToPage2() {
        setViewControllers(
            [page2ViewController],
            direction: .forward,
            animated: true
        ) {
            [weak self] (_) in
            self?.pageControl.currentPage = 1
        }
    }
    
    func goToPage3() {
        setViewControllers(
            [page3ViewController],
            direction: .forward,
            animated: true
        ) {
            [weak self] (_) in
            self?.pageControl.currentPage = 2
        }
    }
    
    func goToDisplayYatPage(order: YatOrder) {
        let displayYatViewController = DisplayYatViewController()
        displayYatViewController.order = order
        displayYatViewController.modalPresentationStyle = .fullScreen
        displayYatViewController.modalTransitionStyle = .coverVertical
        present(
            displayYatViewController,
            animated: true
        )
    }
    
    func connectExistingYat() {
        let alert = UIAlertController(
            title: localized("common.under_construction_icon"),
            message: localized("common.under_construction"),
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: localized("common.ok"),
                style: .default,
                handler: nil
            )
        )
        self.present(alert, animated: true)
    }
    
}
