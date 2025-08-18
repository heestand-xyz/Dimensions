//
//  Rect.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import Spatial

public protocol Rect<D>: Sendable {
    associatedtype D: Dimensions
    static var zero: Self { get }
    associatedtype P: Point where P.D == D
    var min: P { get }
    var mid: P { get }
    var max: P { get }
    associatedtype S: Size where S.D == D
    var size: S { get }
}

extension Rect {
    public var origin: P { min }
    public var center: P { mid }
}

// MARK: - Dimension

extension CGRect: Rect {
    public typealias D = `2D`
    public var min: CGPoint {
        CGPoint(x: minX, y: minY)
    }
    public var mid: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    public var max: CGPoint {
        CGPoint(x: maxX, y: maxY)
    }
}

extension Rect3D: Rect {
    public typealias D = `3D`
    public var mid: Point3D {
        center
    }
}

// MARK: - Hash

extension Hasher {
    public mutating func combine<R: Rect>(rect: R) {
        if let rect = rect as? CGRect {
            combine(rect)
        } else if let rect3D = rect as? Rect3D {
            combine(rect3D)
        } else {
            fatalError("Unknown rect type.")
        }
    }
    
    public mutating func combine<R: Rect>(rects: [R]) {
        for rect in rects {
            combine(rect: rect)
        }
    }
    
    public mutating func combine<T: Hashable, R: Rect>(rects: [T: R]) {
        for (key, rect) in rects {
            combine(key)
            combine(rect: rect)
        }
    }
}
