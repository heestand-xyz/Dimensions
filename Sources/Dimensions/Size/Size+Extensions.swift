//
//  Size+Extensions.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import CoreGraphicsExtensions
import Spatial
import SpatialExtensions

public func min<S: Size>(_ lhs: S, _ rhs: S) -> S {
    if let lhsSize = lhs as? CGSize, let rhsSize = rhs as? CGSize {
        return min(lhsSize, rhsSize) as! S
    } else if let lhsSize = lhs as? Size3D, let rhsSize = rhs as? Size3D {
        return min(lhsSize, rhsSize) as! S
    } else {
        fatalError("Unknown size type.")
    }
}

public func max<S: Size>(_ lhs: S, _ rhs: S) -> S {
    if let lhsSize = lhs as? CGSize, let rhsSize = rhs as? CGSize {
        return max(lhsSize, rhsSize) as! S
    } else if let lhsSize = lhs as? Size3D, let rhsSize = rhs as? Size3D {
        return max(lhsSize, rhsSize) as! S
    } else {
        fatalError("Unknown size type.")
    }
}

public func abs<S: Size>(_ size: S) -> S {
    if let size = size as? CGSize {
        return abs(size) as! S
    } else if let size = size as? Size3D {
        return abs(size) as! S
    } else {
        fatalError("Unknown size type.")
    }
}

private extension Size {
    
    func edit(
        in2D edit2D: (CGSize) -> CGSize,
        in3D edit3D: (Size3D) -> Size3D
    ) -> Self {
        if let size = self as? CGSize {
            return edit2D(size) as! Self
        } else if let size = self as? Size3D {
            return edit3D(size) as! Self
        } else {
            fatalError("Unknown size type.")
        }
    }
    
    func edit(
        with other: Self,
        in2D edit2D: (CGSize, CGSize) -> CGSize,
        in3D edit3D: (Size3D, Size3D) -> Size3D
    ) -> Self {
        let lhs: Self = self
        let rhs: Self = other
        if let lhsSize = lhs as? CGSize, let rhsSize = rhs as? CGSize {
            return edit2D(lhsSize, rhsSize) as! Self
        } else if let lhsSize = lhs as? Size3D, let rhsSize = rhs as? Size3D {
            return edit3D(lhsSize, rhsSize) as! Self
        } else {
            fatalError("Unknown size type.")
        }
    }
    
    func edit(
        with other: CGFloat,
        in edit: (CGFloat, CGFloat) -> CGFloat
    ) -> Self {
        let lhs: Self = self
        let rhs: CGFloat = other
        if let lhsSize = lhs as? CGSize {
            return CGSize(
                width: edit(lhsSize.width, rhs),
                height: edit(lhsSize.height, rhs)
            ) as! Self
        } else if let lhsSize = lhs as? Size3D {
            return Size3D(
                width: edit(lhsSize.width, rhs),
                height: edit(lhsSize.height, rhs),
                depth: edit(lhsSize.depth, rhs)
            ) as! Self
        } else {
            fatalError("Unknown size type.")
        }
    }
}

private extension CGFloat {
    
    func edit<S: Size>(
        with other: S,
        in edit: (CGFloat, CGFloat) -> CGFloat
    ) -> S {
        let lhs: CGFloat = self
        let rhs: S = other
        if let rhsSize = rhs as? CGSize {
            return CGSize(
                width: edit(lhs, rhsSize.width),
                height: edit(lhs, rhsSize.height)
            ) as! S
        } else if let rhsSize = rhs as? Size3D {
            return Size3D(
                width: edit(lhs, rhsSize.width),
                height: edit(lhs, rhsSize.height),
                depth: edit(lhs, rhsSize.depth)
            ) as! S
        } else {
            fatalError("Unknown size type.")
        }
    }
}

public extension Size {
    
    static func + (lhs: Self, rhs: Self) -> Self {
        lhs.edit(with: rhs, in2D: +, in3D: +)
    }
    static func - (lhs: Self, rhs: Self) -> Self {
        lhs.edit(with: rhs, in2D: -, in3D: -)
    }
    static func * (lhs: Self, rhs: Self) -> Self {
        lhs.edit(with: rhs, in2D: *, in3D: *)
    }
    static func / (lhs: Self, rhs: Self) -> Self {
        lhs.edit(with: rhs, in2D: /, in3D: /)
    }
    
    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs.edit(with: rhs, in2D: +, in3D: +)
    }
    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs.edit(with: rhs, in2D: -, in3D: -)
    }
    static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs.edit(with: rhs, in2D: *, in3D: *)
    }
    static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs.edit(with: rhs, in2D: /, in3D: /)
    }
    
    static prefix func - (value: Self) -> Self {
        value.edit(in2D: { -$0 }, in3D: { -$0 })
    }
    
}

public extension Size {
    
    static func + (lhs: Self, rhs: CGFloat) -> Self {
        lhs.edit(with: rhs, in: +)
    }
    static func - (lhs: Self, rhs: CGFloat) -> Self {
        lhs.edit(with: rhs, in: -)
    }
    static func * (lhs: Self, rhs: CGFloat) -> Self {
        lhs.edit(with: rhs, in: *)
    }
    static func / (lhs: Self, rhs: CGFloat) -> Self {
        lhs.edit(with: rhs, in: /)
    }
    
    static func + (lhs: CGFloat, rhs: Self) -> Self {
        lhs.edit(with: rhs, in: +)
    }
    static func - (lhs: CGFloat, rhs: Self) -> Self {
        lhs.edit(with: rhs, in: -)
    }
    static func * (lhs: CGFloat, rhs: Self) -> Self {
        lhs.edit(with: rhs, in: *)
    }
    static func / (lhs: CGFloat, rhs: Self) -> Self {
        lhs.edit(with: rhs, in: /)
    }
    
    static func += (lhs: inout Self, rhs: CGFloat) {
        lhs = lhs.edit(with: rhs, in: +)
    }
    static func -= (lhs: inout Self, rhs: CGFloat) {
        lhs = lhs.edit(with: rhs, in: -)
    }
    static func *= (lhs: inout Self, rhs: CGFloat) {
        lhs = lhs.edit(with: rhs, in: *)
    }
    static func /= (lhs: inout Self, rhs: CGFloat) {
        lhs = lhs.edit(with: rhs, in: /)
    }
}
