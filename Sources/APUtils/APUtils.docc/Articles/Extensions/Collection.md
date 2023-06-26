# Collection

Give superpowers to Arrays, Sets and Dictionaries

## Overview

Collection extensions provide useful methods to simplify indexes access, perform common operations and provide useful utilities

### Methods

Count all occurences of a certain item in a collection with `occurences(of:)`

```swift
let collection = ["Jim", "Kevin", "Dwight", "Dwight", "Kevin", "Kevin"]

collection.occurences(of: "Jim") // returns 1
collection.occurences(of: "Dwight") // returns 2
collection.occurences(of: "Kevin") // returns 3
collection.occurences(of: "Creed") // returns 0
```
 

You can make interception between sets to retrieve the common elements between them with `intercection(_ sequence:)`

```swift
let setA: Set<String> = ["Foo", "Bar"]
let setB: Set<String> = ["Bar", "Baz"]

let interception = setA.interception(setB) // returns ["Bar"]
```

You can concatenate two sequences in a new one 

```swift 
let collectionOne = ["Jim", "Kevin", "Pam", "Dwight"]
let collectionTwo = ["Angela", "Oscar"]

let newCollection = collectionOne.concatenate(with: collectionTwo) // ["Jim", "Kevin", "Pam", "Dwight", "Angela", "Oscar"] 
```
 

If you use `Combine`, you can merge multiple Publishers into a single one and handles all the events in a single closure with `mergeToAnyPublisher`

```swift
let publisher1 = Just(1)
let publisher2 = Just(2)
let publisher3 = Just(3)

[publisher1, publisher2, publisher3]
  .mergeToAnyPublisher()
  .receive(on: RunLoop.main)
  .sink { number in
      // logic here
  }
  .store(in: &cancellables)
```

### Subscripts

You can _safely_ access to an index with `[safe:]` subscript

```swift
let collection = [1,2,3]

collection[safe: 0] // returns 1
collection[safe: 3] // returns nil
```

 

You can _safely_ access to an index and fallback to a default value with `[_, default:]` subscript

```swift
let collection = ["Foo", "Bar"]

collection[0, default: "Baz"] // returns "Foo"
collection[2, default: "Baz"] // returns "Baz"
```
