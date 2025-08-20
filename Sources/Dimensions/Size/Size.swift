//
//  Size.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import Spatial

public protocol Size<D>: Sendable {
    associatedtype D: Dimensions
    var dimensions: D.Type { get }
    static var zero: Self { get }
    associatedtype P: Point where P.D == D
    var point: P { get }
    func getWidth() -> Double
    func getHeight() -> Double
    func getDepth() -> Double
    mutating func setWidth(_ value: Double)
    mutating func setHeight(_ value: Double)
    mutating func setDepth(_ value: Double)
}

// MARK: - Dimension

extension CGSize: Size {
    public var dimensions: `2D`.Type { `2D`.self }
    public var point: CGPoint {
        CGPoint(x: width, y: height)
    }
    public func getWidth() -> Double { width }
    public func getHeight() -> Double { height }
    public func getDepth() -> Double { 0.0 }
    public mutating func setWidth(_ value: Double) {
        width = value
    }
    public mutating func setHeight(_ value: Double) {
        height = value
    }
    public mutating func setDepth(_ value: Double) {}
}

extension Size3D: Size {
    public var dimensions: `3D`.Type { `3D`.self }
    public var point: Point3D {
        Point3D(x: width, y: height, z: depth)
    }
    public func getWidth() -> Double { width }
    public func getHeight() -> Double { height }
    public func getDepth() -> Double { depth }
    public mutating func setWidth(_ value: Double) {
        width = value
    }
    public mutating func setHeight(_ value: Double) {
        height = value
    }
    public mutating func setDepth(_ value: Double) {
        depth = value
    }
}

// MARK: - Hash

extension Hasher {
    public mutating func combine<S: Size>(size: S) {
        if let size = size as? CGSize {
            combine(size)
        } else if let size3D = size as? Size3D {
            combine(size3D)
        } else {
            fatalError("Unknown size type.")
        }
    }
    
    public mutating func combine<S: Size>(sizes: [S]) {
        for size in sizes {
            combine(size: size)
        }
    }
    
    public mutating func combine<T: Hashable, S: Size>(sizes: [T: S]) {
        for (key, size) in sizes {
            combine(key)
            combine(size: size)
        }
    }
}
