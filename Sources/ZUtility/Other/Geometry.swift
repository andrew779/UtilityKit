//
//  Geometry.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import UIKit
import AVFoundation.AVUtilities

// swiftlint:disable identifier_name

/// The value of pi
public let π = CGFloat.pi
/// The value of ½ pi
public let π_2 = π / 2.0
/// The value of ¼ pi
public let π_4 = π / 4.0

extension CGFloat {
  
  /// The length of a single pixel on the current device's screen
  public static var hairlineLength: CGFloat {
    return 1.0 / UIScreen.main.scale
  }
  
  /// Get a value which has been rounded to the device's display scale
  ///
  /// Example: On a 2x device, 0.75 will be roudned to 1.0, and 0.66 will be rounded to 0.5
  public var roundedToDeviceScale: CGFloat {
    return CGFloat(ceil(self * UIScreen.main.scale) / UIScreen.main.scale)
  }
}

extension CGRect {
  
  /// Create a CGRect with a 0,0 origin and a given size
  public init(size: CGSize) {
    self.init(origin: .zero, size: size)
  }
  
  /// Create a CGRect with a 0,0 origin and a given width and height
  public init(width: CGFloat, height: CGFloat) {
    self.init(x: 0.0, y: 0.0, width: width, height: height)
  }
  
  /// The center point in this CGRect
  public var center: CGPoint {
    return CGPoint(x: origin.x + width / 2.0, y: origin.y + height / 2.0)
  }
  
  /// The boxed NSValue of this CGRect
  public var boxed: NSValue {
    return NSValue(cgRect: self)
  }
  
  /// Obtain a CGRect whos values have been rounded to device scale
  public var roundedToDeviceScale: CGRect {
    return CGRect(
      x: origin.x.roundedToDeviceScale,
      y: origin.y.roundedToDeviceScale,
      width: width.roundedToDeviceScale,
      height: height.roundedToDeviceScale
    )
  }
  
  /// Round this entire rect to device scale
  public mutating func roundToDeviceScale() {
    origin.x = origin.x.roundedToDeviceScale
    origin.y = origin.y.roundedToDeviceScale
    size.width = size.width.roundedToDeviceScale
    size.height = size.height.roundedToDeviceScale
  }
  
  /// Center this rect vertically within a container rect
  public mutating func centerVertically(inside containerRect: CGRect) {
    origin.y = containerRect.minY + ((containerRect.height - height) / 2.0).roundedToDeviceScale
  }
  
  /// Center this rect horizontally within a container rect
  public mutating func centerHorizontally(inside containerRect: CGRect) {
    origin.x = containerRect.minX + ((containerRect.width - width) / 2.0).roundedToDeviceScale
  }
  
  /// Center this rect vertically & horizontally within a container rect
  public mutating func center(inside containerRect: CGRect) {
    centerVertically(inside: containerRect)
    centerHorizontally(inside: containerRect)
  }
}

extension CGSize {
  
  /// The boxed NSValue of this CGSize
  public var boxed: NSValue {
    return NSValue(cgSize: self)
  }
  
  /// Create a square CGSize with a given length
  ///
  /// - parameter square: The width and height of the pixels
  public init(square length: CGFloat) {
    self.init(width: length, height: length)
  }
  
  /// Obtain a CGSize whos values have been rounded to device scale
  public var roundedToDeviceScale: CGSize {
    return CGSize(
      width: width.roundedToDeviceScale,
      height: height.roundedToDeviceScale
    )
  }
  
  /// Round this entire CGSize to device scale
  public mutating func roundToDeviceScale() {
    width = width.roundedToDeviceScale
    height = height.roundedToDeviceScale
  }
  
  /// Get a resized CGSize which maintains its aspect ratio within a constrained size
  ///
  /// - parameter constrainedSize: The box which this size must fit inside while maintaining the aspect ratio
  /// - parameter upscale: Whether or not to upscale an image if it's smaller than the constrained size. Defaults to false
  public func aspectRatioInside(constrainedSize: CGSize, shouldUpscale: Bool = false) -> CGSize {
    if !shouldUpscale {
      // This image will fit itself just fine in the contrained size
      if width < constrainedSize.width && height < constrainedSize.height {
        return self
      }
    }
    return AVMakeRect(aspectRatio: self, insideRect: CGRect(size: constrainedSize)).size.roundedToDeviceScale
  }
  
  /// Get a rect in which this size is centered inside a container rect
  public func centered(inside containerRect: CGRect) -> CGRect {
    return CGRect(
      origin: CGPoint(
        x: containerRect.minX + ((containerRect.width - width) / 2.0).roundedToDeviceScale,
        y: containerRect.minY + ((containerRect.height - height) / 2.0).roundedToDeviceScale
      ),
      size: self
    )
  }
  
  /// Get a rect in which this size is horizontally centered inside a container rect
  public func horizontallyCentered(inside containerRect: CGRect, y: CGFloat = 0.0) -> CGRect {
    return CGRect(
      origin: CGPoint(
        x: containerRect.minX + ((containerRect.width - width) / 2.0).roundedToDeviceScale,
        y: y
      ),
      size: self
    )
  }
  
  /// Get a rect in which this size is vertically centered inside a container rect
  public func verticallyCentered(inside containerRect: CGRect, x: CGFloat = 0.0) -> CGRect {
    return CGRect(
      origin: CGPoint(
        x: x,
        y: containerRect.minY + ((containerRect.height - height) / 2.0).roundedToDeviceScale
      ),
      size: self
    )
  }
  
  /// Multiply a CGSize by a given value
  public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(
      width: lhs.width * rhs,
      height: lhs.height * rhs
    )
  }
  
  /// Multiply a CGSize by a given value
  public static func *= (lhs: inout CGSize, rhs: CGFloat) {
    lhs.width *= rhs
    lhs.height *= rhs
  }
}

extension CGPoint {
  
  /// The boxed NSValue of this CGPoint
  public var boxed: NSValue {
    return NSValue(cgPoint: self)
  }
  
  /// Obtain a CGPoint whos values have been rounded to device scale
  public var roundedToDeviceScale: CGPoint {
    return CGPoint(
      x: x.roundedToDeviceScale,
      y: y.roundedToDeviceScale
    )
  }
  
  /// Round this entire CGPoint to device scale
  public mutating func roundToDeviceScale() {
    x = x.roundedToDeviceScale
    y = y.roundedToDeviceScale
  }
  
  /// Offset this point by a given distance in each direction
  public func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
    return CGPoint(
      x: x + dx,
      y: y + dy
    )
  }
}

extension UIEdgeInsets {
  
  /// Create a UIEdgeInsets with a uniform inset/outset
  public init(uniform value: CGFloat) {
    self.init(top: value, left: value, bottom: value, right: value)
  }
  
  /// Create a rectangle UIEdgeInsets with the same uniform values for left/right and uniform values for top/bottom
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }
  
  /// Return an inversed insets copy
  public func inversed() -> UIEdgeInsets {
    return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
  }
  
  /// Inverse the current insets
  public mutating func inverse() {
    top = -top
    left = -left
    bottom = -bottom
    right = -right
  }
  
  /// The combined value of the left and right insets
  public var width: CGFloat {
    return left + right
  }
  
  /// The combined value of the top and bottom insets
  public var height: CGFloat {
    return top + bottom
  }
}
