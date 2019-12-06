//
//  Extension+BarButtonItem.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
  
  /// A flexible space UIBarButtonItem
  public class var flexibleSpace: UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  }
  
  /// A fixed space with a given width
  public class func fixedSpace(_ width: CGFloat) -> UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil).then { $0.width = width }
  }
}
