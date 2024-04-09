//
//  Combine+Extensions.swift
//
//
//  Created by Antonio on 03/04/24.
//

#if canImport(Combine)
import Combine

public extension Publisher {
    func sink<O: AnyObject>(
        weak object: O,
        receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
        receiveValue: @escaping (O?, Output) -> Void
    ) -> AnyCancellable {
        sink(receiveCompletion: receiveCompletion) { [weak object] value in
            receiveValue(object, value)
        }
    }
}

public extension Publisher where Failure == Never {
    func sink<O: AnyObject>(weak object: O, receiveValue: @escaping (O?, Output) -> Void) -> AnyCancellable {
        sink { [weak object] value in
            receiveValue(object, value)
        }
    }
    
    func weakAssign<O: AnyObject>(to keyPath: ReferenceWritableKeyPath<O, Output>, on object: O) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
#endif
