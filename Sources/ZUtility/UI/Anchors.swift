//
//  Anchors.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

public protocol LayoutByConstraints {}

extension LayoutByConstraints where Self: UIView {
  
  /// Marks a view that has been programmatically created to expect to to be laid out using NSLayoutConstraint
  ///
  /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` and then returns itself.
  ///
  /// You can use this in conjunction to Then.swift and do something like:
  ///
  ///     private let someView = UIView().then {
  ///       $0.backgroundColor = .white
  ///     }.layoutByConstraints()
  ///
  @discardableResult
  public func layoutByConstraints() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}

extension UIView: LayoutByConstraints {}

/// A special UILayoutGuide for padding which you can adjust the insets directly
public class UIPaddingGuide: UILayoutGuide {
  
  fileprivate override init() {
    super.init()
    identifier = "UIPaddingGuide"
  }
  
  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  /// The insets for this guide
  public var paddingInsets: UIEdgeInsets = .zero {
    didSet {
      leftConstraint?.constant = paddingInsets.left
      topConstraint?.constant = paddingInsets.top
      rightConstraint?.constant = -paddingInsets.right
      bottomConstraint?.constant = -paddingInsets.bottom
    }
  }
  
  fileprivate var leftConstraint: NSLayoutConstraint?
  fileprivate var topConstraint: NSLayoutConstraint?
  fileprivate var rightConstraint: NSLayoutConstraint?
  fileprivate var bottomConstraint: NSLayoutConstraint?
}

extension UIView {
  
  /// Activate constraints on this view which will pin it to its superview
  ///
  /// - parameter insets: Constants around each edge to pad the view
  ///
  /// - returns: The constraints that were created and activated
  @discardableResult
  public func pinToSuperview(insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
    guard let superview = self.superview else {
      fatalError("\(self) does not belong to any view hierarchy")
    }
    
    return pinTo(anchorable: superview, insets: insets)
  }
  
  /// Creates a UILayoutGuide for padding within a view
  ///
  /// - parameter insets: The padding insets
  /// - parameter view: Optionally, a view to add the padding guide instead of itself
  /// - parameter pinToLayoutMargins: Whether or not to pin the guide to the layout margins or the view itself
  ///
  /// - returns: A padding guide you should use to constrain subviews to
  public func addPaddingGuide(insets: UIEdgeInsets, to view: UIView? = nil, pinToLayoutMargins: Bool = false) -> UIPaddingGuide {
    let view = view ?? self
    let guide = UIPaddingGuide()
    guide.paddingInsets = insets
    
    view.addLayoutGuide(guide)
    
    let container: Anchorable = pinToLayoutMargins ? layoutMarginsGuide : view
    
    let topConstraint = guide.topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top)
    let bottomConstraint = guide.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -insets.bottom)
    let leftConstraint = guide.leftAnchor.constraint(equalTo: container.leftAnchor, constant: insets.left)
    let rightConstraint = guide.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -insets.right)
    
    guide.topConstraint = topConstraint
    guide.bottomConstraint = bottomConstraint
    guide.leftConstraint = leftConstraint
    guide.rightConstraint = rightConstraint
    
    NSLayoutConstraint.activate([ topConstraint, bottomConstraint, leftConstraint, rightConstraint ])
    
    return guide
  }
}

extension UILayoutGuide {
  
  /// Create a layout guide with an identifier
  public convenience init(identifier: String) {
    self.init()
    self.identifier = identifier
  }
}

public protocol Anchorable {
  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var leftAnchor: NSLayoutXAxisAnchor { get }
  var rightAnchor: NSLayoutXAxisAnchor { get }
  var topAnchor: NSLayoutYAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }
  var widthAnchor: NSLayoutDimension { get }
  var heightAnchor: NSLayoutDimension { get }
  var centerXAnchor: NSLayoutXAxisAnchor { get }
  var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: Anchorable {}
extension UILayoutGuide: Anchorable {}

extension Anchorable {
  
  /// Activate constriants on this anchorable thing which will pin it to some other anchorable thing
  ///
  /// - parameter thing: The anchorable thing to pin to
  /// - parameter insets: Constants around each edge to pad the view
  ///
  /// - returns: The constraints that were created and activated
  @discardableResult
  public func pinTo(anchorable thing: Anchorable, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
    // This precondition doesnt work if the views both belong to eventually the same superview up the chain
    // I'll figure out a better way later
    //    precondition(self.isDescendant(of: view), "\(self) must live in \(view)'s hierarchy.")
    
    let constraints = [
      leftAnchor.constraint(equalTo: thing.leftAnchor, constant: insets.left),
      topAnchor.constraint(equalTo: thing.topAnchor, constant: insets.top),
      rightAnchor.constraint(equalTo: thing.rightAnchor, constant: -insets.right),
      bottomAnchor.constraint(equalTo: thing.bottomAnchor, constant: -insets.bottom)
    ]
    NSLayoutConstraint.activate(constraints)
    return constraints
  }
}
