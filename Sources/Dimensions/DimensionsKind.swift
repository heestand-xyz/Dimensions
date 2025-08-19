//
//  DimensionsKind.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

public enum DimensionsKind: Int, Codable, Hashable, Sendable {
    case _2D = 2
    case _3D = 3
}

extension DimensionsKind {
    public var type: any Dimensions.Type {
        switch self {
        case ._2D:
            `2D`.self
        case ._3D:
            `3D`.self
        }
    }
}
