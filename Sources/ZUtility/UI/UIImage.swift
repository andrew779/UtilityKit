//
//  UIImage.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import UIKit

extension UIImage {
  
  /// The same thing as calling withRenderingMode(.templateAlways)
  public var template: UIImage {
    return withRenderingMode(.alwaysTemplate)
  }
  
  /// The same thing as calling withRenderingMode(.originalAlways)
  public var original: UIImage {
    return withRenderingMode(.alwaysOriginal)
  }
  
  /// Create a image tinted by a given color
  public func tinted(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage? {
    let bounds = CGRect(origin: .zero, size: size)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
    color.setFill()
    UIRectFill(bounds)
    
    self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
}
