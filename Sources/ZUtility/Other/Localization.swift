//
//  Localization.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

extension String {
  func localized(_ args: CVarArg...) -> String {
    //Swift supports positional argument strings just like Android: "%$1d, %$2@" = "%d, %@" in that order..
    //    let str = NSLocalizedString(self, tableName: "Localizable.strings", bundle: Bundle.main, value: self, comment: self).replacingOccurrences(of: "$s", with: "$@")
    
    let str = NSLocalizedString(self, comment: self).replacingOccurrences(of: "$s", with: "$@")
    return withVaList(args) {
      NSString(format: str, arguments: $0) as String
    }
  }
}
