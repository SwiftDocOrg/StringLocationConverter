# StringLocationConverter

A Swift package for converting `String.Index` values
into their corresponding `line` and `column` numbers.

## Usage

```swift doctest
import Foundation
import StringLocationConverter

let string = """
# [Universal Declaration of Human Rights][udhr]

## Article 1.

All human beings are born free and equal in dignity and rights.
They are endowed with reason and conscience
and should act towards one another in a spirit of brotherhood.

[udhr]: https://www.un.org/en/universal-declaration-human-rights/ "View full version"
"""

let range = string.range(of: "reason")!

let converter = StringLocationConverter(for: string)
let position = converter.location(for: range.lowerBound, in: string)!
position.line // => Int = 6
position.column // => Int = 23
```

## Installation

### Swift Package Manager

Add the StringLocationConverter package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/SwiftDocOrg/StringLocationConverter",
        from: "0.0.1"
    ),
  ]
)
```

Add `StringLocationConverter` as a dependency to your target(s):

```swift
targets: [
.target(
    name: "YourTarget",
    dependencies: ["StringLocationConverter"]),
```

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
