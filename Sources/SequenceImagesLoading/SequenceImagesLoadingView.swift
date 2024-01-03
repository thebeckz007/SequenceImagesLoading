//
//  File.swift
//  
//
//  Created by Phan Anh Duy on 03/01/2024.
//

import Foundation
import SwiftUI

// MARK: SequenceImagesLoadingView
// integrate SequenceImagesLoading as an UIImageView in UIKit to SequenceImagesLoadingView as a View in SwiftUI
public struct SequenceImagesLoadingView: UIViewRepresentable {
    public typealias UIViewType = SequenceImagesLoading
    @Binding public var duration: TimeInterval
    @Binding public var repeatTimes: Int
    public let arrImageFiles: [SequenceImageFile]
    
    public func makeUIView(context: Context) -> SequenceImagesLoading {
        let view = SequenceImagesLoading(sequenceImageFiles: arrImageFiles)
        
        // enable auto resize image
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
        
        return view
    }
    
    public func updateUIView(_ view: SequenceImagesLoading, context: Context) {
        view.startAnimation(duration: self.duration, repeatTimes: self.repeatTimes) { _ in
        }
    }
}
