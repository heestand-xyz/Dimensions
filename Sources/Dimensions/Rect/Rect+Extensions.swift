//
//  Rect+Extensions.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import CoreGraphicsExtensions
import Spatial
import SpatialExtensions

public extension Rect {
    
    func contains(_ point: P) -> Bool {
        if let rect = self as? CGRect, let point = point as? CGPoint {
            return rect.contains(point)
        } else if let rect = self as? Rect3D, let point = point as? Point3D {
            return rect.contains(point)
        } else {
            fatalError("Unknown rect type.")
        }
    }
    
    func offset(by point: P) -> Self {
        if let rect = self as? CGRect, let point = point as? CGPoint {
            return CGRect(origin: rect.origin + point, size: rect.size) as! Self
        } else if let rect = self as? Rect3D, let point = point as? Point3D {
            return Rect3D(origin: rect.origin + point, size: rect.size) as! Self
        } else {
            fatalError("Unknown rect type.")
        }
    }
    
    func contains(_ rect: Self) -> Bool {
        if let lhsRect = self as? CGRect, let rhsRect = rect as? CGRect {
            return lhsRect.contains(rhsRect)
        } else if let lhsRect = self as? Rect3D, let rhsRect = rect as? Rect3D {
            return lhsRect.contains(rhsRect)
        } else {
            fatalError("Unknown rect type.")
        }
    }
    
    func intersects(_ rect: Self) -> Bool {
        if let lhsRect = self as? CGRect, let rhsRect = rect as? CGRect {
            return lhsRect.intersects(rhsRect)
        } else if let lhsRect = self as? Rect3D, let rhsRect = rect as? Rect3D {
            return lhsRect.intersects(rhsRect)
        } else {
            fatalError("Unknown rect type.")
        }
    }
    
    func union(_ rect: Self) -> Self {
        if let lhsRect = self as? CGRect, let rhsRect = rect as? CGRect {
            return lhsRect.union(rhsRect) as! Self
        } else if let lhsRect = self as? Rect3D, let rhsRect = rect as? Rect3D {
            return lhsRect.union(rhsRect) as! Self
        } else {
            fatalError("Unknown rect type.")
        }
    }
}
