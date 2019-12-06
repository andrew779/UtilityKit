//
//  Observable.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

/// Easy way to add observing to variables in Swift by Robert Hein
///
/// https://github.com/roberthein/Observable
public final class Observable<T> {
  
  public typealias Observer = (T, T?) -> Void
  
  private var observers: [Int: Observer] = [:]
  private var uniqueID = (0...).makeIterator()
  
  public var value: T {
    didSet {
      observers.values.forEach { $0(value, oldValue) }
    }
  }
  
  public init(_ value: T) {
    self.value = value
  }
  
  public func observe(_ observer: @escaping Observer) -> Disposable {
    guard let id = uniqueID.next() else { fatalError("There should always be a next unique id") }
    
    observers[id] = observer
    observer(value, nil)
    
    let disposable = Disposable { [weak self] in
      self?.observers[id] = nil
    }
    
    return disposable
  }
  
  public func removeAllObservers() {
    observers.removeAll()
  }
}
