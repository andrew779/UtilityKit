//
//  LayoutProperty.swift
//  ZzzComponentTemplate
//
//  Created by Wenzhong Zheng on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import UIKit

public struct LayoutProperty<Anchor: LayoutAnchor> {
  fileprivate let anchor: Anchor
}

/// For supporting width and height constraints
extension LayoutProperty where Anchor: DimensionalLayoutAnchor {
  public func equal(constant: CGFloat) -> NSLayoutConstraint {
    let constraint = anchor.constraint(equalToConstant: constant)
    constraint.isActive = true
    return constraint
  }
}

extension LayoutProperty {
  public func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
    let contraint = anchor.constraint(equalTo: otherAnchor, constant: constant)
    contraint.isActive = true
    return contraint
  }
  
  public func greaterOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
    let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  public func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
    let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
    constraint.isActive = true
    return constraint
  }
}

//protocol Anchorable {
//  var leadingAnchor: NSLayoutXAxisAnchor { get }
//  var trailingAnchor: NSLayoutXAxisAnchor { get }
//  var leftAnchor: NSLayoutXAxisAnchor { get }
//  var rightAnchor: NSLayoutXAxisAnchor { get }
//  var topAnchor: NSLayoutYAxisAnchor { get }
//  var bottomAnchor: NSLayoutYAxisAnchor { get }
//  var widthAnchor: NSLayoutDimension { get }
//  var heightAnchor: NSLayoutDimension { get }
//  var centerXAnchor: NSLayoutXAxisAnchor { get }
//  var centerYAnchor: NSLayoutYAxisAnchor { get }
//}
//
//extension UIView: Anchorable {}
//extension UILayoutGuide: Anchorable {}

/**
 * This object will contain all layout properties, and will be the key object that we'll interact with when using our DSL.
 */
public class LayoutProxy {
  public lazy var leading = property(with: view.leadingAnchor)
  public lazy var trailing = property(with: view.trailingAnchor)
  public lazy var top = property(with: view.topAnchor)
  public lazy var bottom = property(with: view.bottomAnchor)
  public lazy var width = property(with: view.widthAnchor)
  public lazy var height = property(with: view.heightAnchor)
  public lazy var centerX = property(with: view.centerXAnchor)
  public lazy var centerY = property(with: view.centerYAnchor)
  
  private let view: Anchorable
  
  fileprivate init(view: Anchorable) {
    self.view = view
  }
  
  private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
    return LayoutProperty(anchor: anchor)
  }
}



public struct AnchorPoint {
  public let anchor: AnchorCase
  public var constant: CGFloat = 0
}

extension AnchorPoint {
  public func constant(_ value: CGFloat) -> AnchorPoint {
    AnchorPoint(anchor: anchor, constant: value)
  }
}

extension AnchorPoint {
  public enum AnchorCase {
    case top, safeTop
    case leading
    case trailing
    case bottom, safeBottom
    case centerX
    case centerY
  }
}
extension AnchorPoint {
  public static let top = AnchorPoint(anchor: .top)
  public static let safeTop = AnchorPoint(anchor: .safeTop)
  public static let leading = AnchorPoint(anchor: .leading)
  public static let trailing = AnchorPoint(anchor: .trailing)
  public static let bottom = AnchorPoint(anchor: .bottom)
  public static let safeBottom = AnchorPoint(anchor: .safeBottom)
  public static let centerX = AnchorPoint(anchor: .centerX)
  public static let centerY = AnchorPoint(anchor: .centerY)
}


extension UIView {
  /**:
   * example:
   * label.layout {
   *  $0.top == button.bottomAnchor + 20
   *  $0.leading == button.leadingAnchor
   *  $0.width <= view.widthAnchor - 40
   * }
   */
  /// if any nsconstraint reference needed, you can just get it from any layout configuration
  /// "bottomConstraintRef = $0.bottom == view.bottomAnchor"
  public func layout(using closure: (LayoutProxy) -> Void) {
    translatesAutoresizingMaskIntoConstraints = false
    closure(LayoutProxy(view: self))
  }
    
  public func layoutTo(_ view: UIView? = nil , anchorPoints points: [AnchorPoint]) {
    let anchorView = view ?? superview
    guard let view = anchorView else {
      fatalError("\(self) does not belong to any view hierarchy")
    }
    
    points.forEach { point in
      switch point.anchor {
      case .top:
        layout { $0.top == view.topAnchor + point.constant }
      case .safeTop:
        layout { $0.top == view.safeAreaLayoutGuide.topAnchor + point.constant }
      case .bottom:
        layout { $0.bottom == view.bottomAnchor + point.constant }
      case .safeBottom:
        layout { $0.bottom == view.safeAreaLayoutGuide.bottomAnchor + point.constant }
      case .leading:
        layout { $0.leading == view.leadingAnchor + point.constant }
      case .trailing:
        layout { $0.trailing == view.trailingAnchor + point.constant }
      case .centerX:
        layout { $0.centerX == view.centerXAnchor + point.constant }
      case .centerY:
        layout { $0.centerY == view.centerYAnchor + point.constant }
      }
    }
  }
  
  public func layoutToSuperView(with insets: UIEdgeInsets = .zero) {
    guard let superview = self.superview else {
      fatalError("\(self) does not belong to any view hierarchy")
    }
    
    layout {
      $0.leading == superview.leadingAnchor + insets.left
      $0.trailing == superview.trailingAnchor - insets.right
      $0.top == superview.topAnchor + insets.top
      $0.bottom == superview.bottomAnchor - insets.bottom
    }
  }
  
}

///plus and minus operators to enable us to combine a layout anchor and a constant into a tuple
public func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
  return (lhs, rhs)
}

public func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
  return (lhs, -rhs)
}

@discardableResult
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
  return lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func ==<A: DimensionalLayoutAnchor>(lhs: LayoutProperty<A>, rhs: CGFloat) -> NSLayoutConstraint {
  return lhs.equal(constant: rhs)
}

@discardableResult
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
  return lhs.equal(to: rhs)
}

@discardableResult
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
  return lhs.greaterOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
  return lhs.greaterOrEqual(to: rhs)
}

@discardableResult
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
  return lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
  return lhs.lessThanOrEqual(to: rhs)
}
