# Regex

Regular expression convenient methods

## Overview

You can use the `=~` operator to match a string against a regular expression pattern. The operator returns a boolean value indicating whether the string matches the pattern.

```swift
let email = "john.doe@example.com"
if email =~ "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}" {
    print("Valid email")
} else {
    print("Invalid email")
}
```

## Extracting Matches

The `matches(for:)` method allows you to extract all matches in a string for a given regular expression pattern. It returns an array of strings representing the matched substrings.

```swift
let sentence = "The quick brown fox jumps over the lazy dog"
let matches = sentence.matches(for: "\\b\\w{5}\\b")
print(matches) // ["quick", "brown"]
```

## Replacing Matches

The `replace(regex:with:)` method replaces occurrences of a regular expression pattern in a string with the specified replacement text. It returns a new string with the matched substrings replaced.

```swift
let sentence = "Hello, world!"
let newSentence = sentence.replace(regex: "\\b\\w{5}\\b", with: "Swift")
print(newSentence) // "Hello, Swift!"
```
