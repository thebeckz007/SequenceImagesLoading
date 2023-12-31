//
//  String+File.swift
//  
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import Foundation

//
extension String {
    /// hash this string into as key of string by MD5 itseft
    internal func keyString() -> String {
        return self.md5Hash()
    }
}

//
extension String {
    internal func pathFileFromMainBundleWithExtension(extensionFile: String) -> String? {
        return self.pathFileInBundle(Bundle.main, withExtensionFile: extensionFile)
    }
    
    internal func pathFileInBundle(_ bundle: Bundle, withExtensionFile extensionFile: String) -> String? {
        return bundle.path(forResource: self, ofType: extensionFile) ?? nil
    }
    
    internal func pathFileFromBundleName(_ bundleName: String,withExtensionFile extensionFile: String) -> String? {
        let path = Bundle.main.path(forResource:bundleName, ofType:"bundle")
        let bundleImages :Bundle = Bundle.init(path: path!)!
        
        return self.pathFileInBundle(bundleImages, withExtensionFile: extensionFile)
    }
}
