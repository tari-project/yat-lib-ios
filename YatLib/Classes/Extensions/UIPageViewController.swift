//
//  UIPageViewController.swift
//  YatLib
//
//  Created by kutsal kaan bilgin on 15.04.2021.
//

import Foundation
import UIKit

extension UIPageViewController {

    func enableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }

    func disableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
}
