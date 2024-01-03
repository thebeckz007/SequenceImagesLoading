//
//  SequenceImagesLoading.swift
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import UIKit

public typealias SequenceImagesAnimationCompletion = (Bool) -> Void

// MARK: Protocol
/// Protocol load sequence images
public protocol SequenceImagesLoadingProtocol {
    /// Start excute loading sequence images as an animation
    /// - parameter duration: range of duration to animate
    /// - parameter repeatTimes: It's a animating loop times. Note: if repeatTimes < 0, aniamtion will loop forever, if repeatTimes = 0, animation just 1 time and not repeat at all
    /// - parameter completion: this block will be fired whenever an animation sequence images loading was completed
    func startAnimation(duration: TimeInterval, repeatTimes: Int, completion: SequenceImagesAnimationCompletion?)
    
    /// Force stop animating sequence images
    func stopAnimation()
}

// MARK: Class SequenceImagesLoading
public class SequenceImagesLoading: UIImageView, SequenceImagesLoadingProtocol {
    // MAR:- Variables
    fileprivate var sequenceImageFiles: [SequenceImageFile] = [SequenceImageFile]()
    fileprivate var imageCompletionAnimation: SequenceImagesAnimationCompletion?
    
    fileprivate var repeatTimes: Int = 0
    fileprivate var curIndex: Int = 0
    fileprivate var toIndex: Int = 0
    fileprivate var animateNext: Bool = true  // true if animate to Next, false if animate to Previous
    
    fileprivate var dataCachingModule: CachingFileDataProtocol?
    fileprivate var timer: Timer?
    
    /// Initialize a SequenceImagesLodaing instance
    ///
    /// - parameter sequenceImageFiles: list of sequence file. NOTE: It should be a full path of image file
    public convenience init(sequenceImageFiles: [SequenceImageFile]) {
        self.init()
        
        self.sequenceImageFiles = sequenceImageFiles
        self.dataCachingModule = NSDataWithCaching.sharedInstance
        
        preloadSequenceImages()
    }
    
    // Trigger pre-loading sequence images
    private func preloadSequenceImages() {
        self.loadSequenceImages()
    }
    
    // Trigger loading sequence images
    private func loadSequenceImages() {
        for file in sequenceImageFiles {
            self.dataCachingModule?.getDataFilebyFileName(file.getFileName(), inMainThread: true, completion: { (data) in
            })
        }
    }
    
    // start animation
    public func startAnimation(duration: TimeInterval = 1.0, repeatTimes: Int = 0, completion: SequenceImagesAnimationCompletion?) {
        if self.sequenceImageFiles.count == 0 {
            return
        }
        
        self.repeatTimes = repeatTimes
        
        self.imageCompletionAnimation = completion
        self.toIndex = max(Int(round(Float(duration) * Float(self.sequenceImageFiles.count))),0)
        
        if self.toIndex > self.curIndex {
            // animate next from curIndex to toIndex
            self.animateNext = true
        } else if self.toIndex < self.curIndex {
            // animate previous from curIndex to toIndex
            self.animateNext = false
        } else {
            // do not at all
            endAnimationPathFileName()
            return
        }
        
        // Stop timer
        self.stopTimer()
        
        // Trigger new timer
        let timeLoadSteps = 0.1
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeLoadSteps), target: self, selector: #selector(self.animateLoadImage), userInfo: nil, repeats: true)
    }
    
    // stop animation
    public func stopAnimation() {
        self.endAnimationPathFileName()
    }
    
    // perform animation by update next image
    @objc private func animateLoadImage() {
        if ((self.animateNext && self.curIndex <= self.toIndex) // in case animate next to
             || (!self.animateNext && self.curIndex >= self.toIndex)) { // in case animate previous to
            
            self.animateAtIndex(self.curIndex)
            
            if self.animateNext {
                // to next
                self.curIndex += 1
            } else {
                // to previous
                self.curIndex -= 1
            }
        } else {
            self.repeatAnimationIfNeed()
        }
    }
    
    private func animateAtIndex(_ index: Int) {
        if index < 0 {
            return
        } else if index >= self.sequenceImageFiles.count {
            return
        }
              
        let file = self.sequenceImageFiles[index]
        
        self.dataCachingModule?.getDataFilebyFileName(file.getFileName(), inMainThread: true, completion: { (data) in
            if let _data = data {
                self.image = UIImage(data: _data)
            }
        })
    }
    
    private func repeatAnimationIfNeed() {
        if self.repeatTimes < 0 {
            // loop forever
            self.curIndex = 0
            self.animateLoadImage()
        } else if (self.repeatTimes >= 1) {
            // loop n times
            self.curIndex = 0
            self.repeatTimes -= 1
            self.animateLoadImage()
        } else {
            self.endAnimationPathFileName()
        }
    }
    
    //
    private func endAnimationPathFileName() {
        self.stopTimer()
        
        if let _completion = self.imageCompletionAnimation {
            _completion(true)
            self.imageCompletionAnimation = nil
        }
    }
    
    //
    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
