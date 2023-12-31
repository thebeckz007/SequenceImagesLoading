//
//  String+Format.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//

import Foundation

extension String {
    /// Generate string of integer number
    ///
    /// Example: stringFromInt(15, numberZeroChar: 3) --> "015"
    ///
    /// - parameter number: BinaryInteger
    /// - returns string of integer number
    static public func stringFromInt<T: BinaryInteger>(_ number: T, numberZeroChar: Int) -> String {
        var formatString = ""
        let numZero = numberZeroChar - String(number).count
        if numZero > 0 {
            for _ in 1...numZero {
                formatString += "0"
            }
        }
        formatString += "%d"
        return String(format: formatString, number as! CVarArg)
    }
    
    /// Generate a string of percentage number
    ///
    /// - parameter numPercentage: the number of percentage, Note: FloatingPoint
    /// - returns a string of percentage number
    static func stringFromPercentageNumber<T: BinaryFloatingPoint>(numPercentage: T) -> String {
        return "\(Int(numPercentage * 100))" + "%"
    }
}
