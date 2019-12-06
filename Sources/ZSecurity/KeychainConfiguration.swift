//
//  KeychainConfiguration.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-17.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

public struct KeychainConfiguration {
  public static let serviceName = "MyAppService"
  
  /*
   Specifying an access group to use with `KeychainPasswordItem` instances
   will create items shared accross both apps.
   
   For information on App ID prefixes, see:
   https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/AppID.html
   and:
   https://developer.apple.com/library/ios/technotes/tn2311/_index.html
   */
  //    static let accessGroup = "[YOUR APP ID PREFIX].com.example.apple-samplecode.GenericKeychainShared"
  
  /*
   Not specifying an access group to use with `KeychainPasswordItem` instances
   will create items specific to each app.
   */
  public static let accessGroup: String? = nil
}
