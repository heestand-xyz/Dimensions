//
//  Dimensions.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import Spatial

public protocol Dimensions: Sendable {
    static var type: DimensionsType { get }
    associatedtype P: Point where P.D == Self
    associatedtype S: Size where S.D == Self
    associatedtype R: Rect where R.D == Self
}

public enum `2D`: Dimensions {
    public static var type: DimensionsType { .`2D` }
    public typealias P = CGPoint
    public typealias S = CGSize
    public typealias R = CGRect
}

public enum `3D`: Dimensions {
    public static var type: DimensionsType { .`3D` }
    public typealias P = Point3D
    public typealias S = Size3D
    public typealias R = Rect3D
}
