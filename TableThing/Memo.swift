import Foundation



public class Memo<T> {
  private var memo: MemoValue<T>

  
  public init(factory: @escaping ()->T) {
    memo = MemoValue(factory: factory)
  }
  
  
  public var value: T {
    return memo.value()
  }
}



public class ExternalMemo<T, U> {
  private var memo: ExternalMemoValue<T, U>
  
  
  public init(factory: @escaping (U)->T) {
    memo = ExternalMemoValue(factory: factory)
  }
  
  
  public func value(_ u:U) -> T {
    return memo.value(u)
  }
}



private enum MemoValue<T> {
  case unevaluated(()->T), evaluated(T)
  
  init(factory: @escaping ()->T) {
    self = .unevaluated(factory)
  }
  
  mutating func value() -> T {
    switch self {
    case let .evaluated(v):
      return v
    case let .unevaluated(f):
      self = .evaluated(f())
      return value()
    }
  }
}



private enum ExternalMemoValue<T,U> {
  case unevaluated((U)->T), evaluated(T)
  
  init(factory: @escaping (U)->T) {
    self = .unevaluated(factory)
  }
  
  mutating func value(_ u: U) -> T {
    switch self {
    case let .evaluated(v):
      return v
    case let .unevaluated(f):
      self = .evaluated(f(u))
      return value(u)
    }
  }
}

