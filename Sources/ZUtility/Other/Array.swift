//
//  Array.swift
//  ZzzUtilityKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

extension Array {
  
  /// Obtain an item in this array safely if the index is valid
  ///
  /// - parameter index: An index within the array
  /// - returns: An element at the given index, or nil if the index is out of range
  public func at(_ index: Index) -> Element? {
    if index >= 0 && index < count {
      return self[index]
    }
    return nil
  }
}

extension Array where Element: Equatable {
  
  /// Remove a specific element from an array if it exists
  ///
  /// - parameter element: The element to remove
  @discardableResult
  public mutating func remove(element: Element) -> Element? {
    if let idx = firstIndex(of: element) {
      return remove(at: idx)
    }
    return nil
  }
}
