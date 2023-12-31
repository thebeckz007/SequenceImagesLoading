//
//  NSThreadSafe.swift
//
//  Created by Phan Anh Duy on 17/11/2023.
//
import Foundation

extension NSObject {
    /// Run this closure in thread safe
    ///
    /// We will run this closure in thread safe to avoid data racing
    ///
    /// - parameter closure: the code block will be perform in thread safe
    public func threadSafe(closure: () -> Void) {
        objc_sync_enter(self)
        closure()
        objc_sync_exit(self)
    }
}
