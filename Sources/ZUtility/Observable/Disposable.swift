//
//  Disposable.swift
//  ZzzKit
//
//  Created by Hongming Zuo on 2019-03-09.
//  Copyright © 2019 zzz. All rights reserved.
//

import Foundation

/// Easy way to add observing to variables in Swift by Robert Hein
///
/// https://github.com/roberthein/Observable
public typealias Disposal = [Disposable]

public final class Disposable {
  
  private let dispose: () -> Void
  
  init(_ dispose: @escaping () -> Void) {
    self.dispose = dispose
  }
  
  deinit {
    dispose()
  }
  
  public func add(to disposal: inout Disposal) {
    disposal.append(self)
  }
}
