# UIView

UIViews simplified

## Overview

UIView extension simplifies the way to work with UIViews

### Methods

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
