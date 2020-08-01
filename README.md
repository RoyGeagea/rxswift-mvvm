# rxswift-mvvm

> Context:

An iOS app developed with Xcode 11 and written in Swift 5, built using the MVVM-C design pattern, truly extolling the virtues of MVVM over MVC.

In the tutorial accompanying this repo, I'll introduce you to the "Model-View-ViewModel" or "MVVM" design pattern. For a historical and pragmatic perspective, I'll compare the very well-known "Model-View-Controller" or "MVC" design pattern, long favored by many iOS developers, to MVVM, which has steadily been gaining traction among the same group of developers.

> Functions:

The app is capable of:

- Register a user
- Login a user
- Show the latest images on Pixabay

> Technologies:

- [RxSwift](https://github.com/ReactiveX/RxSwift): 
Rx-Swift is a reactive programming library in iOS app development. It is a multi-platform standard, its difficult-to-handle asynchronous code in Swift, that becomes much easier in Rx-Swift.
RxSwift makes easy to develop dynamic applications that respond to changes in data and respond to user events. Ultimately, it solves the issues related to asynchronous development.
- [UIKit](https://developer.apple.com/documentation/uikit):
UIKit framework where UI stands for User Interface, provides the window and view architecture for implementing your interface, the event handling infrastructure for delivering Multi-Touch and other types of input to your app.
When you launch any iOS app the screen you see it’s actually a UIViewController where we add more UI elements according to the requirement like if we need a user action, we use UIButton and just to show some information to use, we use UILabel. (more like Scrollable content use UIScrollView, UITableView etc). Everything that is visible to end user comes under UIKit framework.
- [Swift 5](https://developer.apple.com/swift/):
Swift is a multi-paradigm and versatile compiled programming language developed by Apple Inc. for iOS, iPadOS, macOS, watchOS, tvOS, Linux and z/OS. Swift is designed to work with the Apple Cocoa and Cocoa Touch frameworks and with the extensive existing Objective-C code base written for Apple products. It is built with the open source LLVM compiler framework and is included in Xcode since version 6, released in 2014. On Apple platforms, it uses the Objective-C runtime library which allows the use of C, Objective-C, C ++ and Swift. code to be executed in a program.
Apple wanted Swift to support many of the basic concepts associated with Objective-C, such as dynamic dispatching, generalized late binding, extensible programming and similar features, but in a "safer" way, making it easier to detect software bugs; Swift provides features to correct some common programming errors such as null pointer dereferencement and provides a syntax sugar to avoid the pyramid of fate. Swift supports the concept of protocol extensibility, a system of extensibility that can be applied to types, structures and classes, advocated by Apple as a real change in the programming paradigms they call "protocol-oriented programming" (similar to strokes).
- [CocoaPods](https://cocoapods.org):
CocoaPods is an application level dependency manager for the Objective-C, Swift and any other languages that run on the Objective-C runtime, such as RubyMotion, that provides a standard format for managing external libraries.

> Software architecture: MVVM

![](MVVM.png)

MVVM facilitates the separation of GUI development - whether via markup language or GUI code - from business logic or back-end logic (data model) development. The MVVM view model is a value converter, which means that the view model is responsible for exposing (converting) data objects from the model so that the objects can be easily managed and presented. In this respect, the view model is more model than view and manages most if not all of the display logic of the view. The view model can implement a mediator pattern, organizing access to the backend logic around the set of use cases supported by the view.

MVVM is a variant of Martin Fowler's Presentation Model design model. MVVM summarizes the state and behavior of a view in the same way, but a presentation model summarizes a view (creates a view model) independently of a specific user interface platform.

MVVM was invented by Microsoft architects Ken Cooper and Ted Peters to simplify event-driven user interface programming. The model has been integrated into Windows Presentation Foundation (WPF) (Microsoft's .NET graphics system) and Silverlight (an application derived from WPF Internet applications). John Gossman, one of Microsoft's WPF and Silverlight architects, announced MVVM on his blog in 2005.

> Set your Pixabay API key for the app

* Login to [Pixabay](https://pixabay.com/)
* Go to [API](https://pixabay.com/service/about/api/) page
* Open the iOS app, replace the token with your API key in onboarding-success.json file inside Assets folders

> Note

The app uses SSL pinning, [Public Key Hash Pinning](https://medium.com/supercharges-mobile-product-guide/public-key-hash-pinning-on-ios-703ca255cb11) technique
