//
//  AttributedStringBuilder.swift
//  ZzzUtilityKit
//
//  Created by Wenzhong Zheng on 2019-03-10.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation
import UIKit

/// Helps manifest attributed strings
public final class AttributedStringBuilder {
  /// Internal mutable attributed string
  private var string: NSMutableAttributedString
  
  /// Creates a builder with an empty string
  public init() {
    string = NSMutableAttributedString()
  }
  
  /// Create a string builder with some text and attributes already added
  public convenience init(text: String, with attributes: Attribute...) {
    self.init()
    add(text: text, with: attributes)
  }
  
  /// Create a string builder with some text and attributes already added
  public convenience init(text: String, with attributes: [Attribute]) {
    self.init()
    add(text: text, with: attributes)
  }
  
  /// Append text with some attributes to the attributed string
  public func add(text: String, with attributes: Attribute...) {
    add(text: text, with: attributes)
  }
  
  /// Append text with some attributes to the attributed string
  public func add(text: String, with attributes: [Attribute]) {
    var a: [NSAttributedString.Key: Any] = [:]
    attributes.forEach { a[$0.key] = $0.value }
    string.append(NSAttributedString(string: text, attributes: a))
  }
  
  /// Append text with some attributes to the attributed string and then return Self for chaining
  public func adding(text: String, with attributes: Attribute...) -> Self {
    return adding(text: text, with: attributes)
  }
  
  /// Append text with some attributes to the attributed string and then return Self for chaining
  public func adding(text: String, with attributes: [Attribute]) -> Self {
    add(text: text, with: attributes)
    return self
  }
  
  /// The attributed string which has been built by calling `add` and `adding`
  public var attributedString: NSAttributedString {
    // swiftlint:disable:next force_cast
    return string.copy() as! NSAttributedString
  }
}

// MARK: - Attributes
extension AttributedStringBuilder {
  
  /// A single attribute that may be added to an attributed string
  public struct Attribute {
    fileprivate let key: NSAttributedString.Key
    fileprivate let value: Any
    
    private init(key: NSAttributedString.Key, value: Any) {
      self.key = key
      self.value = value
    }
    
    public static func font(_ font: UIFont) -> Attribute {
      return Attribute(key: .font, value: font)
    }
    
    public static func paragraphStyle(_ style: NSParagraphStyle) -> Attribute {
      return Attribute(key: .paragraphStyle, value: style)
    }
    
    public static func foregroundColor(_ color: UIColor) -> Attribute {
      return Attribute(key: .foregroundColor, value: color)
    }
    
    public static func backgroundColor(_ color: UIColor) -> Attribute {
      return Attribute(key: .backgroundColor, value: color)
    }
    
    public static func ligatures(_ flag: Bool) -> Attribute {
      return Attribute(key: .ligature, value: flag ? 1 : 0)
    }
    
    public static func kerning(_ amount: CGFloat) -> Attribute {
      return Attribute(key: .kern, value: amount)
    }
    
    public static func strikethroughStyle(_ flag: Bool) -> Attribute {
      return Attribute(key: .strikethroughStyle, value: flag ? 1 : 0)
    }
    
    public static func strikethroughColor(_ color: UIColor) -> Attribute {
      return Attribute(key: .strikethroughColor, value: color)
    }
    
    public static func underlineStyle(_ flag: Bool) -> Attribute {
      return Attribute(key: .underlineStyle, value: flag ? 1 : 0)
    }
    
    public static func underlineColor(_ color: UIColor) -> Attribute {
      return Attribute(key: .underlineColor, value: color)
    }
    
    public static func strokeWidth(_ amount: CGFloat) -> Attribute {
      return Attribute(key: .strokeWidth, value: amount)
    }
    
    public static func strokeColor(_ color: UIColor) -> Attribute {
      return Attribute(key: .strokeColor, value: color)
    }
    
    public static func shadow(_ shadow: NSShadow) -> Attribute {
      return Attribute(key: .shadow, value: shadow)
    }
    
    public static func textEffect(_ effect: String) -> Attribute {
      return Attribute(key: .textEffect, value: effect)
    }
    
    public static func attachment(_ pkg: NSTextAttachment) -> Attribute {
      return Attribute(key: .attachment, value: pkg)
    }
    
    public static func link(_ url: URL) -> Attribute {
      return Attribute(key: .link, value: url)
    }
    
    public static func link(_ string: String) -> Attribute {
      return Attribute(key: .link, value: string)
    }
    
    public static func baselineOffset(_ offset: CGFloat) -> Attribute {
      return Attribute(key: .baselineOffset, value: offset)
    }
    
    public static func obliqueness(_ skew: CGFloat) -> Attribute {
      return Attribute(key: .obliqueness, value: skew)
    }
    
    public static func expansion(_ factor: CGFloat) -> Attribute {
      return Attribute(key: .expansion, value: factor)
    }
    
    public enum WritingDirection: Int {
      /// Left to right embedding
      case lre
      /// Right to left embedding
      case rle
      /// Left to right override
      case lro
      /// Right to left override
      case rlo
      
      public var rawValue: Int {
        switch self {
        case .lre:
          return NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.embedding.rawValue
        case .lro:
          return NSWritingDirection.leftToRight.rawValue | NSWritingDirectionFormatType.override.rawValue
        case .rle:
          return NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.embedding.rawValue
        case .rlo:
          return NSWritingDirection.rightToLeft.rawValue | NSWritingDirectionFormatType.override.rawValue
        }
      }
    }
    
    public static func writingDirection(_ directions: [WritingDirection]) -> Attribute {
      // Honestly not sure if this works lol, the doc says "array of nsnumbers" 🤷‍♂️
      return Attribute(key: .writingDirection, value: directions.map { $0.rawValue })
    }
    
    public enum TextOrientation: Int {
      case horizontal
      case vertical
    }
    
    public static func verticalGlyphForm(_ orientation: TextOrientation) -> Attribute {
      return Attribute(key: .verticalGlyphForm, value: orientation.rawValue)
    }
    
    public static func custom(key: NSAttributedString.Key, value: Any) -> Attribute {
      return Attribute(key: key, value: value)
    }
  }
}
