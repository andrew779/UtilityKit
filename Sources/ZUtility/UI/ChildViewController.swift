//
//  ChildViewController.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

// Credit to @mergesort / Public-Extension:
// https://github.com/mergesort/Public-Extension/blob/8d99dd44f933c14b189743d035c68f3f280f2061/PublicExtension.playground/Pages/UIViewController.xcplaygroundpage/Contents.swift

extension UIViewController {
  
  public func add(childViewController: UIViewController) {
    addChild(childViewController)
    view.addSubview(childViewController.view)
    childViewController.didMove(toParent: self)
  }
  
  public func insert(childViewController: UIViewController, belowSubview subview: UIView) {
    addChild(childViewController)
    view.insertSubview(childViewController.view, belowSubview: subview)
    childViewController.didMove(toParent: self)
  }
  
  public func insert(childViewController: UIViewController, aboveSubview subview: UIView) {
    addChild(childViewController)
    view.insertSubview(childViewController.view, aboveSubview: subview)
    childViewController.didMove(toParent: self)
  }
  
  public func insert(childViewController: UIViewController, at index: Int) {
    addChild(childViewController)
    view.insertSubview(childViewController.view, at: index)
    childViewController.didMove(toParent: self)
  }
  
  public func removeFromPV() {
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}
