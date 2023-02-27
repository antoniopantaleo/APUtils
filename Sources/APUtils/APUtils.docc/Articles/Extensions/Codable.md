# Codable

Simplify the way to encode and decode objects

## Overview

Codable extensions gives simple utilites methods to encode and decode a `Codable` entity

### Methods

Encode a `Codable` entity with `encoded`

```swift
let myEntry = Entry()
do {
    let encoded = try myEntry.encoded 
    print(type(of: encoded)) // Data
} catch {
    // unable to encode
}
```

 

Decode a `Codable` entity with `decoded()`

```swift
do {
    let decoded: MyEntry = try encoded.decoded()
    print(type(of: decoded)) // MyEntry
} catch {
    // unable to decode
}
```
