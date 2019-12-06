//
//  FirstResponder.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

private weak var firstResponder: UIResponder?

extension UIResponder {
  
  /// Get the current first responder
  public class var currentFirstResponder: UIResponder? {
    
    // Clever workaround for finding the first responder without resorting to using PRIVATE API.
    // Basically, sending an action to the application itself, will actually send said action to the first responder.
    // Meaning if we set the `firstResponder` to `self` as seen below, we will now effectively get the first responder.
    firstResponder = nil
    
    // For some extra safety, we'll make sure that this can actually perform the action. Technically this will always
    // return YES since we are adding the method to the UIResponder class, but just in case this workaround suddenly stops
    // working.
    UIApplication.shared.do {
      if $0.canPerformAction(#selector(findFirstResponder(_:)), withSender: nil) {
        $0.sendAction(#selector(findFirstResponder(_:)), to: nil, from: nil, for: nil)
      }
    }
    
    return firstResponder
  }
  
  @objc
  private func findFirstResponder(_ sender: AnyObject) {
    firstResponder = self
  }
}
