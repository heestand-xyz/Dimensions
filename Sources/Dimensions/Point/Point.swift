//
//  Point.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import Spatial

public protocol Point: Sendable {
    associatedtype D: Dimensions
    var dimensions: D.Type { get }
    func distance(to other: Self) -> Double
    static var zero: Self { get }
    associatedtype S: Size where S.D == D
    var size: S { get }
    func getX() -> Double
    func getY() -> Double
    func getZ() -> Double
    mutating func setX(_ value: Double)
    mutating func setY(_ value: Double)
    mutating func setZ(_ value: Double)
}

// MARK: - Dimension

extension CGPoint: Point {
    public var dimensions: `2D`.Type { `2D`.self }
    public var size: CGSize {
        CGSize(width: x, height: y)
    }
    public func getX() -> Double { x }
    public func getY() -> Double { y }
    public func getZ() -> Double { 0.0 }
    public mutating func setX(_ value: Double) {
        x = value
    }
    public mutating func setY(_ value: Double) {
        y = value
    }
    public mutating func setZ(_ value: Double) {}
}

extension Point3D: Point {
    public var dimensions: `3D`.Type { `3D`.self }
    public var size: Size3D {
        Size3D(width: x, height: y, depth: z)
    }
    public func getX() -> Double { x }
    public func getY() -> Double { y }
    public func getZ() -> Double { z }
    public mutating func setX(_ value: Double) {
        x = value
    }
    public mutating func setY(_ value: Double) {
        y = value
    }
    public mutating func setZ(_ value: Double) {
        z = value
    }
}

// MARK: - Distance

extension CGPoint {
    public func distance(to other: CGPoint) -> Double {
        hypot(x - other.x, y - other.y)
    }
}

// MARK: - Hash

extension Hasher {
    public mutating func combine<P: Point>(point: P) {
        if let point = point as? CGPoint {
            combine(point)
        } else if let point3D = point as? Point3D {
            combine(point3D)
        } else {
            fatalError("Unknown point type.")
        }
    }
    
    public mutating func combine<P: Point>(points: [P]) {
        for point in points {
            combine(point: point)
        }
    }
    
    public mutating func combine<T: Hashable, P: Point>(points: [T: P]) {
        for (key, point) in points {
            combine(key)
            combine(point: point)
        }
    }
}
