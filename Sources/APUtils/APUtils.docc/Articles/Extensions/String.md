# String

Evergreen string utils

## Overview

String extension adds some utils and functinalities to String values

### Methods

You can generate a _lorem ipsum_ placeholder with `loremIpsum`

```swift
let lorem = String.loremIpsum
print(lorem) // Lorem ipsum dolor sit amet, consectetur...
```

By default this generates the entire text. You can limit characters number with `loremIpsum(ofLength:)`

```swift
let lorem = String.loremIpsum(ofLength: 5)
print(lorem) // Lorem
```

### Subscripts

You can easily get substring using array notation with `[]`

```swift
let string = "Hello World"

print(string[0..<4] // "Hell"
print(string[6..8] // "Wo"
print(string[5..8] // " World"
```
