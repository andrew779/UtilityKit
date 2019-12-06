//
//  Shadow.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

/// Defines information around displaying a shadow
public struct Shadow {
  
  /// The color of the shadow (see layer.shadowColor)
  public var color: UIColor
  
  /// The offset (see layer.shadowOffset)
  public var offset: CGSize
  
  /// The radius (see layer.shadowRadius)
  public var radius: CGFloat
  
  /// The alpha (see layer.shadowOpacity)
  public var alpha: CGFloat
  
  /// The path (see layer.shadowPath)
  /// - note: This will be automatically created via a UIBezierPath during layoutSubviews if nil and will take into
  ///         account any `cornerRadius` set on the layer.
  public var path: CGPath?
  
  public init(color: UIColor, offset: CGSize, radius: CGFloat, alpha: CGFloat, path: CGPath? = nil) {
    self.color = color
    self.offset = offset
    self.radius = radius
    self.alpha = alpha
    self.path = path
  }
}

/// Some pre-defined shadows
extension Shadow {
  
  /// A shadow used on larger card style views
  public static let largeCardShadow = Shadow(color: .black, offset: CGSize(width: 0, height: 2), radius: 2.0, alpha: 0.3)
  
  /// A shadow used on smaller card style views
  public static let smallCardShadow = Shadow(color: .black, offset: CGSize(width: 0, height: 1), radius: 0.75, alpha: 0.15)
}

extension UIView {
  
  /// Sets a shadow on any view using the Shadow class
  public func setShadow(_ shadow: Shadow?) {
    guard let shadow = shadow else {
      layer.shadowColor = nil
      layer.shadowOffset = .zero
      layer.shadowRadius = 0.0
      layer.shadowOpacity = 0.0
      layer.shadowPath = nil
      return
    }
    layer.shadowColor = shadow.color.cgColor
    layer.shadowOffset = shadow.offset
    layer.shadowRadius = shadow.radius
    layer.shadowOpacity = Float(shadow.alpha)
    layer.shadowPath = shadow.path
  }
}
