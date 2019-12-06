//
//  Color.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-08.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  /// Create a color using a hex integer (e.g. 0xAABBCC)
  public convenience init(hex: Int32) {
    let red = CGFloat((hex >> 16) & 0xff)
    let green = CGFloat((hex >> 8) & 0xff)
    let blue = CGFloat((hex >> 0) & 0xff)
    self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
  }
  
  /// Create a color using a hex string (e.g. "AABBCC")
  public convenience init?(hexString: String) {
    guard let hex = Int32(hexString, radix: 16) else {
      return nil
    }
    self.init(hex: hex)
  }
  
  public var rgbComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) { // swiftlint:disable:this large_tuple
    var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r, g, b, a)
  }
  
  /**
   Get transit color between two color, with progress
   
   */
  public static func transitColor(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> UIColor {
    let (fromR, fromG, fromB, fromA) = fromColor.rgbComponents
    let (toR, toG, toB, toA) = toColor.rgbComponents
    let r = fromR + (toR - fromR) * progress
    let b = fromB + (toB - fromB) * progress
    let g = fromG + (toG - fromG) * progress
    let a = fromA + (toA - fromA) * progress
    return UIColor(red: r, green: g, blue: b, alpha: a)
  }
  
  public static let brandGreen = UIColor(hex: 0x55A200)
  public static let brandLightTint = UIColor(hex: 0xDAE0E2)
  public static let brandDarkTint = UIColor(hex: 0x2E3234)
  
  public static let formTitleColor = UIColor(hex: 0x707375)
  public static let formErrorColor = UIColor(hex: 0xE64437)
  public static let formWarningColor = UIColor(hex: 0xF4D641)
  public static let formSuccessColor = UIColor(hex: 0x55A200)
  
  public static let standardBackgroundColor = UIColor(hex: 0xF3F7F8)
  
}
