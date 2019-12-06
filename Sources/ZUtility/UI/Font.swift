//
//  Font.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-08.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

private let brandFontMapping: [UIFont.Weight: String] = [
  .light: "PingFangTC-Thin",
  .regular: "PingFangTC-Regular",
  .bold: "PingFangTC-Semibold",
  .heavy: "PingFangTC-Semibold"
]

extension UIFont {
  public static func brandFont(ofSize: CGFloat, weight: Weight = .regular) -> UIFont {
    guard let fontName = brandFontMapping[weight], let result = UIFont(name: fontName, size: ofSize) else {
      fatalError("Font weight not found")
    }
    return result
  }
  
}
