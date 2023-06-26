# UIView

UIViews simplified

## Overview

UIView extension simplifies the way to work with UIViews

### Methods

You can get or set whether the view is visible or not

```swift 
let view = UIView()
view.isVisible // is the opposite of `isHidden`
```

You can easily define a view that uses autolayout with `autolayout`

```swift
let view = UIView.autolayout
print(view.translatesAutoresizingMaskIntoConstraints) // false

let button = UIButton.autolayout
print(button.translatesAutoresizingMaskIntoConstraints) // false
```

If you need to define an autolayouted `UICollectionView` you can do it with `autolayout(collectionViewLayout:)`

```swift
let collectionView = UICollectionView.autolayout(collectionViewLayout: UICollectionViewLayout())
print(collectionView.translatesAutoresizingMaskIntoConstraints) // false
```

 

You can add multiple subviews using variadic parameters with `addSubviews(_)`
```swift
let containerView = UIView()

let subView1 = UIView()
let subView2 = UIView()
let subView3 = UIView()

containerView.addSubviews(subView1, subView2, subView3)
```

You can add a subview and instantly activate its constraints


```swift
let view = UIView.autolayout
let button = UIButton.autolayout

view.addSubview(button) { view, button in
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
}
```
