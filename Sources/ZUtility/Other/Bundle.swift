//
//  Bundle.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

extension Bundle {
  
  /// Get the language the application is running in
  public var runningLanguage: String {
    guard let language = preferredLocalizations.first else {
      return "en"
    }
    return String(language[language.startIndex..<language.index(language.startIndex, offsetBy: 2)])
  }
  
  /// Get the locale identifier for the running language
  public var runningLocaleIdentifier: String {
    if runningLanguage.hasPrefix("fr") {
      return "fr_CA"
    }
    return "en_CA"
  }
  
  /// The version number of the bundle
  public var versionNumber: String? {
    return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
  
  /// The build number of the bundle
  public var buildNumber: String? {
    return object(forInfoDictionaryKey: "CFBundleVersion") as? String
  }
  
  /// The version string to display
  public var versionDisplayString: String {
    guard let versionNumber = versionNumber, let buildNumber = buildNumber else {
      return ""
    }
    #if PROD
    return "v\(versionNumber)"
    #else
    return "v\(versionNumber) (\(buildNumber))"
    #endif
  }
}
