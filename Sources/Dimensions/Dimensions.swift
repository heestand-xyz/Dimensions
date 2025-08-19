//
//  Dimensions.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

import CoreGraphics
import Spatial

public protocol Dimensions: Sendable {
    static var kind: DimensionsKind { get }
    associatedtype P: Point where P.D == Self, P.S == S
    associatedtype S: Size where S.D == Self, S.P == P
    associatedtype R: Rect where R.D == Self, R.P == P, R.S == S
}

public enum `2D`: Dimensions {
    public static var kind: DimensionsKind { .dimensions2 }
    public typealias P = CGPoint
    public typealias S = CGSize
    public typealias R = CGRect
}

public enum `3D`: Dimensions {
    public static var kind: DimensionsKind { .dimensions3 }
    public typealias P = Point3D
    public typealias S = Size3D
    public typealias R = Rect3D
}
