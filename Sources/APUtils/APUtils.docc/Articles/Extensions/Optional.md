# Optional

Easy ways to deal with optionals

## Overview

Optional extension adds some simple functionalities to handle optional values

### Methods

You can check if an optional string either nil or empy with `isNilOrEmpty`

```swift
let nilString: String? = nil
let emptyString: String? = ""
let notEmptyString: String? = "Hello world!"

print(nilString.isNilOrEmpty) // true
print(emptyString.isNilOrEmpty) // true
print(notEmptyString.isNilOrEmpty) // false
```

 

It works with collections too

```swift
let nilCollection: [String]? = nil
let emptyCollection: [String]? = []
let notEmptyCollection: [String]? = ["Hello", "world!"]

print(nilCollection.isNilOrEmpty) // true
print(emptyCollection.isNilOrEmpty) // true
print(notEmptyCollection.isNilOrEmpty) // false
```
