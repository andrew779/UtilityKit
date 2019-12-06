//
//  Preferences.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
/// Basic Preferences wrap class, keys can be extened in extension
/// example: static var lastOptionalUpgradePopupVersion = Option<String?>(key: "upgrade.last-version-prompt", default: nil)
final class Preferences {
  
  // MARK: - Forced/Optional Upgrade
  
  /// The last optional version which the user was prompted for
// example: static var lastOptionalUpgradePopupVersion = Option<String?>(key: "upgrade.last-version-prompt", default: nil)
}

extension Preferences {
  /// An entry in the `Preferences`
  ///
  /// `ValueType` defines the type of value that will stored in the UserDefaults object
  struct Option<ValueType> {
    /// The current value of this preference
    ///
    /// Upon setting this value, UserDefaults will be updated
    var value: ValueType {
      didSet {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
      }
    }
    /// The key used for getting/setting the value in `UserDefaults`
    fileprivate let key: String
    /// Creates a preference
    fileprivate init(key: String, default: ValueType) {
      self.key = key
      value = (UserDefaults.standard.value(forKey: key) as? ValueType) ?? `default`
    }
  }
}
