//
//  String+Crypto.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 18/11/2023.
//

import Foundation

import CryptoKit

extension String {
    /// Hash itseft by MD5 algorithm
    ///
    /// - returns MD5 data as string
    func md5Hash() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}
