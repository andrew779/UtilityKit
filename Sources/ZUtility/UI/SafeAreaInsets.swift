//
//  SafeAreaInsets.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  /// Safe area insets that are not affected by additional safe area insets set within UIViewController's.
  ///
  /// This is essentially just the phones safe area insets based on hardware (i.e. notch)
  @available(iOS 11.0, *)
  public var windowSafeAreaInsets: UIEdgeInsets {
    return UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
  }
}
