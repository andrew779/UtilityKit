//
//  Codable.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

extension Encodable {
  
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
  
  func asArray() throws -> [Any] {
    let data = try JSONEncoder().encode(self)
    guard let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any] else {
      throw NSError()
    }
    return array
  }
  
}

extension Decodable {
  public static func decodeFromDic<T: Decodable>(dic: [String: Any]) -> T? {
    do {
      let data = try JSONSerialization.data(withJSONObject: dic, options: [])
      let result = try JSONDecoder().decode(T.self, from: data)
      return result
    } catch {
      debugPrint("Error \(error)")
      return nil
    }
  }
}

extension Array where Element: Encodable {
  public func convertToDicArray() -> [[String: Any]] {
    var result: [[String: Any]] = []
    for item in self {
      do {
        let dic = try item.asDictionary()
        result.append(dic)
      } catch {
        print("error when encode item \(error)")
      }
    }
    return result
  }
}
