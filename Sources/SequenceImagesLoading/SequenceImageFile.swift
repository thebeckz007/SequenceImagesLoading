//
//  File.swift
//  
//
//  Created by Phan Anh Duy on 03/01/2024.
//

import Foundation

// MARK: Enum SequenceImageFileType
/// List of image file type was supported to load sequence images
///
/// - note : For now, we just supported png, jpg image file
public enum SequenceImageFileType : Int {
    /// png image file
    case png = 1
    
    /// jpg image file
    case jpg = 2
    
    var name : String {
        switch self {
        case .png:
            return "png"
        case .jpg:
            return "jpg"
        }
    }
}

public struct SequenceImageFile {
    private let fileName: String
    private let fileType: SequenceImageFileType
    
    private init(fileName: String, fileType: SequenceImageFileType) {
        self.fileName = fileName
        self.fileType = fileType
    }
}
extension SequenceImageFile {
    /// Initialize a SequenceImageFile instance
    ///
    /// - parameter fileName: sequence file name.
    /// *Note: file name only, not include the paths*
    /// - parameter imageType: image file type. Note: png image file is by the default
    /// - parameter inBundle: what bundle store these sequence image
    public init(fileName: String, imageType: SequenceImageFileType = .png, inBundle: Bundle) {
        let fullFileName = fileName.pathFileInBundle(inBundle, withExtensionFile: imageType.name)
        self.init(fileName: fullFileName ?? fileName, fileType: imageType)
    }
    
    /// Initialize a SequenceImageFile instance
    ///
    /// - parameter systemFileName: sequence file names what was stored/ located in assets bundle
    /// *Note: file name only, not include the paths*
    /// - parameter imageType: image file type. Note: png image file is by the default
    public init(systemFileName: String, imageType: SequenceImageFileType = .png) {
        self.init(fileName: systemFileName, imageType: imageType, inBundle: Bundle.main)
    }
    
    /// Initialize a SequenceImageFile instance
    ///
    /// - parameter fileName: sequence file name
    /// *Note: file name only, not include the paths*
    /// - parameter imageType: image file type. Note: png image file is by the default
    /// - parameter inBundleName: bunlde name which bundle store these sequence image
    public init(fileName: String, imageType: SequenceImageFileType = .png, inBundleName: String) {
        // read data of all image animation filess in other queue
        let path = Bundle.main.path(forResource:inBundleName, ofType:"bundle")
        let bundleImage :Bundle = Bundle.init(path: path!)!
        
        self.init(fileName: fileName, imageType: imageType, inBundle: bundleImage)
    }
}

extension SequenceImageFile {
    public func getFileName () -> String {
        return self.fileName
    }
}
