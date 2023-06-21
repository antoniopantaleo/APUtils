# LRUCache

Cache your data efficiently 

## Overview

LRUChace stands for **L**ast **R**ecently **U**sed Cache.
It's a way to store data and get access to it faster. The data you saved at some point but you never used again, is freed from memory, leaving space to new ones.

The cache keeps in memory last used items.
The oldest get removed when the number of items exceeds the capacity of the cache

```swift
var cache = LRUCache<String,Int>(maxCapacity: 4)

cache["zero"] = 0
cache["one"] = 1
cache["two"] = 2
cache["three"] = 3
// This is the 5th value I save, but my cache can only save 4 values at the time. 
// The last recently used value ("zero") will be deleted 
cache["four"] = 4 

print(cache["one"])     // 1
print(cache["two"])     // 2
print(cache["three"])   // 3
print(cache["four"])    // 4
print(cache["zero"])    // nil
```
