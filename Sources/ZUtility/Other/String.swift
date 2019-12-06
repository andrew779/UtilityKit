//
//  String.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import UIKit

extension Optional where Wrapped == String {
  
  /// Whether or an optional String object is empty.
  ///
  /// This is basically a simple way to avoid having to unwrap `String?` to find out if its empty.
  /// If the `Optional` is `.none` (`nil`) then we return true, otherwise we return the wrapped
  /// string's `isEmpty`
  public var isEmpty: Bool {
    switch self {
    case .none:
      return true
    case .some(let string):
      return string.isEmpty
    }
  }
  
  /// Whether an optional String object matches a specific regular expression pattern
  ///
  /// This is basically a simple way to avoid having to unwrap `String?`.
  /// If the `Optional` is `.none` (`nil`) then we return true, otherwise we return the wrapped
  /// string's `matches`
  public func matches(pattern: String, options: NSRegularExpression.Options = []) -> Bool {
    if case .some(let string) = self {
      return string.matches(pattern: pattern, options: options)
    }
    
    return false
  }
  
  /// Whether an optional String object matches a specific regular expression pattern
  ///
  /// This is basically a simple way to avoid having to unwrap `String?`.
  /// If the `Optional` is `.none` (`nil`) then we return true, otherwise we return the wrapped
  /// string's `matches`
  public func matchResults(pattern: String, options: NSRegularExpression.Options = []) -> [NSTextCheckingResult] {
    if case .some(let string) = self {
      return string.matchResults(pattern: pattern, options: options)
    }
    
    return []
  }
}

extension String {
  
  // MARK: - Measurement
  
  public func measure(constrainedSize size: CGSize, font: UIFont) -> CGSize {
    return measure(constrainedSize: size, attributes: [.font: font])
  }
  
  public func measure(constrainedSize size: CGSize, attributes: [NSAttributedString.Key: Any]) -> CGSize {
    return (self as NSString).boundingRect(
      with: size,
      options: [.usesLineFragmentOrigin],
      attributes: attributes,
      context: nil
      ).size.roundedToDeviceScale
  }
  
  public func substring(from: Int) -> String {
    let startIndex = self.index(self.startIndex, offsetBy: from)
    let endIndex = self.endIndex
    return String(self[startIndex..<endIndex])
  }
  
  public func substring(from: Int, to: Int) -> String {
    let startIndex = self.index(self.startIndex, offsetBy: from)
    let endIndex = self.index(self.startIndex, offsetBy: to)
    return String(self[startIndex..<endIndex])
  }
  
  /// Split a string into N number of strings
  public func split(chunks: Int) -> [String] {
    let count = self.count
    var results = [String]()
    
    //Split into chunks..
    var i = 0
    var stopIndex = 0
    while i + chunks <= count {
      stopIndex += chunks
      results.append(substring(from: i, to: stopIndex))
      i += chunks
    }
    
    if stopIndex < count {
      results.append(substring(from: stopIndex, to: count))
    }
    
    return results
  }
  
  /// Tests whether or not a string matches a regular expression pattern.
  public func matches(pattern: String, options: NSRegularExpression.Options = []) -> Bool {
    do {
      let regex = try NSRegularExpression(pattern: pattern, options: options)
      return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
    } catch {
      print(error)
    }
    
    return false
  }
  
  /// Returns the matches found for a specified pattern in the string.
  public func matchResults(pattern: String, options: NSRegularExpression.Options = []) -> [NSTextCheckingResult] {
    do {
      let regex = try NSRegularExpression(pattern: pattern, options: options)
      return regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
    } catch {
      print(error)
    }
    
    return []
  }
}

extension NSAttributedString {
  
  public func measure(constrainedSize size: CGSize) -> CGSize {
    return self.boundingRect(
      with: size,
      options: [.usesLineFragmentOrigin],
      context: nil
      ).size.roundedToDeviceScale
  }
}
