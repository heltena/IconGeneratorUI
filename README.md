# IconGeneratorUI

Simple code to generate your Icons using SwiftUI.

## How to use it

First of all, add this package to your project. Then, create
a Playground on your project for macOS (important!). 

> **Note:** The IconGeneratorUI does not work on iOS platforms (but 
>           it generates PNG files that you can use in your iOS apps).

In order to run the Playground properly, you will need to create
a simple project targeted to macOS (a simple App in SwiftUI will
be enough).

Select this app and "My Mac", then open the playground. Now, you could
write something like:

```swift
import Cocoa
import PlaygroundSupport
import SwiftUI
import IconGeneratorUI

struct IconGeneratorView: View {
    var body: some View {
        ZStack {
            Color.blue
            Text("Hello world!")
                .foregroundColor(.white)
        }
        .frame(width: 1024, height: 1024)
        .clipShape(RoundedRectangle(cornerRadius: 200))
        .onTapGesture {
            let fileUrl = playgroundSharedDataDirectory.appendingPathComponent("Icon.png")
            do {
                try saveSnapshot(targetSize: CGSize(width: 1024, height: 1024), to: fileUrl)
            } catch {
                print("Cannot save \(error.localizedDescription)")
            }
        }
    }
}

PlaygroundPage.current.setLiveView(IconGeneratorView().scaleEffect(x: 0.5, y: 0.5))
```

And everytime you click on top of the icon, the playground will try to save 
the icon on a folder called *Shared Playground Data* into your Document folder.
If you don't have it, you will need to create this folder.
