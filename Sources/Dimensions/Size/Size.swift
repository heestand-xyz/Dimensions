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
    static var zero: Self { get }
    associatedtype P: Point where P.D == D
    var point: P { get }
}

// MARK: - Dimension

extension CGSize: Size {
    public typealias D = `2D`
    public var point: CGPoint {
        CGPoint(x: width, y: height)
    }
}

extension Size3D: Size {
    public typealias D = `3D`
    public var point: Point3D {
        Point3D(x: width, y: height, z: depth)
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
