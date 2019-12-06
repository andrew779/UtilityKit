//
//  DateFormatter.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

extension DateFormatter {
  
  public enum ZzzStyle: String, CaseIterable {
    case iso8601Full = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS" // decode server dates
    case oddIso8601Full = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ" // decode CartItem's updated_on
    case oddIso860Short = "yyyy-MM-dd'T'HH:mm:ss" // decode order_date for order tracking info
    case commonUse = "yyyy-MM-dd" // Decode server birthday
    case monthDayYear = "MMMM dd, yyyy" // Used with Order History to display the date of the order
    case monthDay = "MMM d" // Used for Future Order Time when the date is not Today or Tomorrow
    case time = "h:mm a" // Used with Future Order Time. Display style after user selects date.
    case orderTimeFull = "E MMM d 'at' h:mm a" // used to when Future Order Time Picker
    case birthday = "dd/MM/yy" // Used to display a birthday. Also Coupons.
  }
  
  public static func with(customStyle: ZzzStyle) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.changeFormat(to: customStyle)
    if customStyle == .iso8601Full || customStyle == .oddIso8601Full {
      dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    }
    return dateFormatter
  }
  
  @discardableResult
  public func changeFormat(to customStyle: ZzzStyle) -> Self {
    self.dateFormat = customStyle.rawValue
    return self
  }
}
