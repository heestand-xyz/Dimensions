//
//  Point+Extensions.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import CoreGraphicsExtensions
import Spatial
import SpatialExtensions

public func min<P: Point>(_ lhs: P, _ rhs: P) -> P {
    if let lhsPoint = lhs as? CGPoint, let rhsPoint = rhs as? CGPoint {
        return min(lhsPoint, rhsPoint) as! P
    } else if let lhsPoint = lhs as? Point3D, let rhsPoint = rhs as? Point3D {
        return min(lhsPoint, rhsPoint) as! P
    } else {
        fatalError("Unknown point type.")
    }
}

public func max<P: Point>(_ lhs: P, _ rhs: P) -> P {
    if let lhsPoint = lhs as? CGPoint, let rhsPoint = rhs as? CGPoint {
        return max(lhsPoint, rhsPoint) as! P
    } else if let lhsPoint = lhs as? Point3D, let rhsPoint = rhs as? Point3D {
        return max(lhsPoint, rhsPoint) as! P
    } else {
        fatalError("Unknown point type.")
    }
}

public func abs<P: Point>(_ point: P) -> P {
    if let point = point as? CGPoint {
        return abs(point) as! P
    } else if let point = point as? Point3D {
        return abs(point) as! P
    } else {
        fatalError("Unknown point type.")
    }
}

private extension Point {
    
    func edit(
        in2D edit2D: (CGPoint) -> CGPoint,
        in3D edit3D: (Point3D) -> Point3D
    ) -> Self {
        if let point = self as? CGPoint {
            return edit2D(point) as! Self
        } else if let point = self as? Point3D {
            return edit3D(point) as! Self
        } else {
            fatalError("Unknown point type.")
        }
    }
    
    func edit(
        with other: Self,
        in2D edit2D: (CGPoint, CGPoint) -> CGPoint,
        in3D edit3D: (Point3D, Point3D) -> Point3D
    ) -> Self {
        let lhs: Self = self
        let rhs: Self = other
        if let lhsPoint = lhs as? CGPoint, let rhsPoint = rhs as? CGPoint {
            return edit2D(lhsPoint, rhsPoint) as! Self
        } else if let lhsPoint = lhs as? Point3D, let rhsPoint = rhs as? Point3D {
            return edit3D(lhsPoint, rhsPoint) as! Self
        } else {
            fatalError("Unknown point type.")
        }
    }
    
    func edit(
        with other: CGFloat,
        in edit: (CGFloat, CGFloat) -> CGFloat
    ) -> Self {
        let lhs: Self = self
        let rhs: CGFloat = other
        if let lhsPoint = lhs as? CGPoint {
            return CGPoint(
                x: edit(lhsPoint.x, rhs),
                y: edit(lhsPoint.y, rhs)
            ) as! Self
        } else if let lhsPoint = lhs as? Point3D {
            return Point3D(
                x: edit(lhsPoint.x, rhs),
                y: edit(lhsPoint.y, rhs),
                z: edit(lhsPoint.z, rhs)
            ) as! Self
        } else {
            fatalError("Unknown point type.")
        }
    }
}

private extension CGFloat {
    
    func edit<P: Point>(
        with other: P,
        in edit: (CGFloat, CGFloat) -> CGFloat
    ) -> P {
        let lhs: CGFloat = self
        let rhs: P = other
        if let rhsPoint = rhs as? CGPoint {
            return CGPoint(
                x: edit(lhs, rhsPoint.x),
                y: edit(lhs, rhsPoint.y)
            ) as! P
        } else if let rhsPoint = rhs as? Point3D {
            return Point3D(
                x: edit(lhs, rhsPoint.x),
                y: edit(lhs, rhsPoint.y),
                z: edit(lhs, rhsPoint.z)
            ) as! P
        } else {
            fatalError("Unknown point type.")
        }
    }
}

public extension Point {
    
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

public extension Point {
    
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
