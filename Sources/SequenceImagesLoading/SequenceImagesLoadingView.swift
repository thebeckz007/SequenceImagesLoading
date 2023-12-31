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
    @Binding var duration: TimeInterval
    @Binding var repeatTimes: Int
    let arrImageFiles: [SequenceImageFile]
    
    public init(duration: Binding<TimeInterval>, repeatTimes: Binding<Int>, arrImageFiles: [SequenceImageFile]) {
        self._duration = duration
        self._repeatTimes = repeatTimes
        self.arrImageFiles = arrImageFiles
    }
    
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
