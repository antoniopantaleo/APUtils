# ResultBuilders

Handy DSLs structures

## Overview

ResultBuilders are a simple way to compose and manage code for different scenarios

### AutoLayoutBuilder

`AutoLayoutBuilder` lets you create a collection of `NSLayoutConstraint` inside a closure. 
Here you can use if statements, for loops and more

Activate a closure of `NSLayoutConstraint`s with `activate(_)`

```swift
NSLayoutConstraint.activate {
    // Express simple constraints
    view.centerXAnchor.constraint(equalTo: someView.centerXAnchor)
    view.centerYAnchor.constraint(equalTo: someView.centerYAnchor)
    // Unwrapping an optional variable
    if let fixedLogoSize = fixedLogoSize {
        someView.widthAnchor.constraint(equalToConstant: fixedLogoSize.width)
        someView.heightAnchor.constraint(equalToConstant: fixedLogoSize.height)
    }
    // Use if-then-else conditionals
    if alignLogoTop {
        // Use this constraint if True
        someView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    } else {
        // Use this constraint if False
        someView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }
    // You can use Void too
    print("Constraint activation finished")
}
```

> See more <doc:UIView> extensions
