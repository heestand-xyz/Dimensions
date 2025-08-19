# Dimensions

Write dimension-agnostic code.

`iOS 16.0+` | `macOS 13.0+` | `tvOS 16.0+` | `visionOS 1.0+` | `watchOS 9.0+`

Generics for `2D` and `3D` types that unify `CGPoint` / `CGSize` / `CGRect` from `CoreGraphics` with `Point3D` / `Size3D` / `Rect3D` from `Spatial` to `any Point`, `any Size` and `any Rect`.

## Installation

Install via Swift package manager as a `dependency`:

```swift
.package(url: "https://github.com/heestand-xyz/Dimensions", from: "1.0.0")
```

and add it to a `target`:

```swift
dependencies: ["Dimensions"]
```

then `import`:

```swift
import Dimensions
```

## Dimensions Protocol

The `Dimensions` protocol has two conforming namespace enums:
```swift
`2D` and `3D`
```
These are used to align the protocols `Point`, `Size` and `Rect`.

> As the conforming namespace enums are prefixed with a number, make sure to add backticks around them.

### Type Erasure

Use the `any` keyword prefix to specify a type erased `Point`, `Size` or `Rect`:

```swift
let point: any Point = CGPoint.zero
let size: any Size = Size3D.zero
let rect: any Rect = Rect3D.zero
```

Access a dimensions `Point`, `Size` or `Rect` type with `P`, `S`, and `R`: 

```swift
let pointType: any Point.Type = `2D`.P.self
let sizeType: any Size.Type = `3D`.S.self
let rectType: any Rect.Type = `3D`.R.self
```

## DimensionsKind Enum

The `Dimensions` protocol has a static property called `kind`, use this to switch over the dimensions of a type erased `Point`, `Size` or `Rect`.

```swift
let point: any Point = CGPoint.zero
let dimensions: any Dimensions.Type = point.dimensions
let is2D: Bool = dimensions.kind == .dimensions2
// true
```

> The `DimensionsKind` conforms to `Codable`, `Hashable`, and `Sendable`.

> The `rawValue` is an `Int` of `2` or `3`.

Get the type of `Dimensions` like this:

```swift
DimensionsKind.dimensions3.type == `3D`.self
```

## Example Usage

When working with dimensional types, a generic constraint is needed.

*This won't work:* 

```swift
let pointA: any Point = CGPoint.zero
let pointB: any Point = Point3D.zero
let pointC = pointA + pointB // Binary operator '+' cannot be applied to two 'any Point' operands
```

Here is an example of a `Canvas` struct that adds two points:

```swift
struct Canvas<D: Dimensions> {
    let pointA: D.P
    let pointB: D.P
    func added() -> D.P {
        pointA + pointB
    }
}
        
let canvas2D = Canvas<`2D`>(
    pointA: CGPoint(x: 0.0, y: 1.0),
    pointB: CGPoint(x: 2.0, y: 3.0)
)
canvas2D.added()
// CGPoint(x: 2.0, y: 4.0)

let canvas3D = Canvas<`3D`>(
    pointA: Point3D(x: 0.0, y: 1.0, z: 2.0),
    pointB: Point3D(x: 3.0, y: 4.0, z: 5.0)
)
canvas3D.added()
// Point3D(x: 3.0, y: 5.0, z: 7.0)
```

## Operator Overloads

`Point` and `Size` have the following operator overloads:

2D Point example:

```swift
let pointA: `2D`.P = CGPoint(x: 1.0, y: 2.0)
let pointB: `2D`.P = CGPoint(x: 3.0, y: 4.0)
let pointC: `2D`.P = pointA + pointB
// CGPoint(x: 4.0, y: 6.0)
var pointD: `2D`.P = CGPoint(x: 10.0, y: 10.0)
pointD += pointC
// CGPoint(x: 14.0, y: 16.0)
let pointE: `2D`.P = -pointD
// CGPoint(x: -14.0, y: -16.0)
```

3D Size example:

```swift
let sizeA: `3D`.S = Size3D(width: 1.0, height: 2.0, depth: 3.0)
let sizeB: `3D`.S = Size3D(width: 4.0, height: 5.0, depth: 6.0)
let sizeC: `3D`.S = sizeA + sizeB
// Size3D(width: 5.0, height: 7.0, depth: 9.0)
var sizeD: `3D`.S = Size3D(width: 10.0, height: 10.0, depth: 10.0)
sizeD += sizeC
// Size3D(width: 15.0, height: 17.0, depth: 19.0)
let sizeE: `3D`.S = -sizeD
// Size3D(width: -15.0, height: -17.0, depth: -19.0)
```

> These all work with `+`, `-`, `*`, and `/`. 

## Properties and Functions

`Rect` has the following `Point` properties: `min` & `origin`, `mid` & `center`, and `max`.

`Rect` also has `contains`, `intersects` and `union` functions.

## Hashing

There are extensions on `Hasher` to `combine(point:)`, `combine(size:)`, and `combine(rect:)`. Also available for array and dictionary.   

