//
//  Numeric.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

extension Int {
  
  /// Generates a Uniformed Random Integer in the range [min, max]
  ///
  /// - Returns: A Random Integer
  public static func random(min: Int = 0, max: Int = Int.max) -> Int {
    return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
  }
}

extension Float {
  
  /// Generates a Random Floating Point in the range [min, max]
  ///
  /// - Parameters:
  ///   - min: The lower bound of the random number to generate.
  ///   - max: The upper bound of the random number to generate.
  /// - Returns: A Random Floating Point
  public static func random(min: Float = 0.0, max: Float = 1.0) -> Float {
    return (Float(arc4random()) / Float(UInt32.max)) * (max - min) + min
  }
}

extension FloatingPoint {
  
  /// Scales a floating point number from the range [fMin, fMax] to the range [toMin, toMax]
  ///
  /// - Parameters:
  ///   - fMin: The current lower bound of the floating point number to scale.
  ///   - fMax: The current upper bound of the floating point number to scale.
  ///   - toMin: The lower bound of the range in which to scale to.
  ///   - toMax: The upper bound of the range in which to scale to.
  /// - Returns: The scaled Floating Point number in the range [toMin, toMax]
  public func scaleToRange(fMin: Self, fMax: Self, toMin: Self, toMax: Self) -> Self {
    return (((toMax - toMin) * (self - fMin)) / (fMax - fMin)) + toMin
  }
}
