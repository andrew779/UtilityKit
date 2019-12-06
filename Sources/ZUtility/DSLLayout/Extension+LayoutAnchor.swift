//
//  Extension+LayoutAnchor.swift
//  ZzzComponentTemplate
//
//  Created by Wenzhong Zheng on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import UIKit

/// Base constraint protocol as according to NSLayoutAnchor base class
public protocol LayoutAnchor {
  func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
  func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
  func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

/// use to map to height and width constraints which inherietant from base NSLayoutAnchor<AnchorType> generic class.
public protocol DimensionalLayoutAnchor: LayoutAnchor {
  func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}
extension NSLayoutDimension: DimensionalLayoutAnchor {}

extension NSLayoutConstraint {
    public func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
