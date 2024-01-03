# Demo Sequence Images Loading
As a developer, We'd like to develop a custom UIView as sequence images loading view.

# Why to build Sequence Images Loading module
## The prolem 1
We have 2 solution to load sequence images

<img src="Screenshots/Challenge_1.gif" width="600"/>

## The problem 2
<img src="Screenshots/Challenge_2.png" width="600"/>

Reference: iOS memory deep dive in WWDC 2018 https://developer.apple.com/videos/play/wwdc2018/416

## The problem 3
<img src="Screenshots/Challenge_3.png" width="600"/>

# Features 
- Load sequence images as progress bar.
- Aniamate updated values.
    
# Techniques
- UIKit
- Grand central Dispatch (GCD): to multithread 
- Follow SOLID principles

## Environment
- XCode 15.0 ++
- iOS 13 ++

## How to use
### For UIKit
```
import SequenceImagesLoading

// init sequence images loading instance
// declare image file name and image bundle name which bundle these images were stored
let strImageFileName = "ks_activity_seq_"
let strImageBundleName = "Assets_Katespade_Activity"

var arrImageFiles: [String] = [String]()
for idx in 0...72 {
    let strFileName = strImageFileName + String.stringFromInt(idx, numberZeroChar: 3)
    arrImageFiles.append(strFileName)
}
    
let seqImagesView = SequenceImagesLoading(sequenceImageFileNames: arrImageFiles, imageType: .png, inBundleName: strImageBundleName)

// start aniamation
seqImagesView.startAnimation(duration: numPercentage) { _ in
}
```

### For SwiftUI
```
import SequenceImagesLoading

/// Contruct SequenceImagesView
struct SequenceImagesView : View {
    @Binding var numPercentage: TimeInterval
    @State var repeatTimes: Int = 0
    
    var body: some View {
        // declare image file name and image bundle name which bundle these images were stored
        let strImageFileName = "ks_activity_seq_"
        let strImageBundleName = "Assets_Katespade_Activity"
        var arrImageFiles: [SequenceImageFile] = [SequenceImageFile]()
        
        for idx in 0...72 {
            let strFileName = strImageFileName + String.stringFromInt(idx, numberZeroChar: 3)
            arrImageFiles.append(SequenceImageFile(fileName: strFileName, inBundleName: strImageBundleName))
        }
        
        return SequenceImagesLoadingView(duration: $numPercentage, repeatTimes: $repeatTimes, arrImageFiles: arrImageFiles)
            .frame(width: 400.0, height: 400.0)
    }
}
```


