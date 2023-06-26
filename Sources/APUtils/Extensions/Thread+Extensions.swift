//
//  Thread+Extensions.swift
//  
//
//  Created by Antonio on 21/06/23.
//

import Foundation

/// Synchronously executes a block of code on the main thread.
///
/// - Note: This function will block the calling thread until the `executionBlock` has completed on the main thread.
///
/// This function checks if the current thread is the main thread. If it is not,
/// it uses `DispatchQueue.main.sync` to synchronously dispatch the `executionBlock` to the main thread.
/// If the current thread is already the main thread, it immediately executes the `executionBlock`.
///
///
/// ```swift
/// mainThread { [weak self] in
///     self?.label.text = "Updated on the main thread"
/// }
/// ```
///
/// - Parameter executionBlock: The block of code to be executed on the main thread
///
/// - Warning: Be careful when calling this function from the main thread with a block that could
/// potentially block the thread (like waiting for a network response), as it could lead to a deadlock.
///
public func mainThread(_ executionBlock: () -> Void) {
    if !Thread.isMainThread {
        DispatchQueue.main.sync { executionBlock() }
    }
    else { executionBlock() }
}
