//
//  DimensionsKind.swift
//  Dimensions
//
//  Created by Anton Heestand on 2025-08-17.
//

public enum DimensionsKind: Int, Codable, Hashable, Sendable {
    case dimensions2 = 2
    case dimensions3 = 3
}

extension DimensionsKind {
    public var type: any Dimensions.Type {
        switch self {
        case .dimensions2:
            `2D`.self
        case .dimensions3:
            `3D`.self
        }
    }
}
