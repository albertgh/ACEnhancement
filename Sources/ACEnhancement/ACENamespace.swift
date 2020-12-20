//
//  ACENamespace.swift
//
//  Created by albertchu on 2020/1/21.
//

import Foundation
import UIKit

// MARK: Wrapper
public struct ACENamespaceWrapper<WrappedType> {
    public let wrappedValue: WrappedType
    public init(_ value: WrappedType) {
        self.wrappedValue = value
    }
}

public protocol ACENamespace {
    associatedtype ACENamespaceWrappedType
    var ace: ACENamespaceWrappedType { get }
    static var ace: ACENamespaceWrappedType.Type { get }
}

public extension ACENamespace {
    var ace: ACENamespaceWrapper<Self> {
        return ACENamespaceWrapper(self)
    }
    static var ace: ACENamespaceWrapper<Self>.Type {
        return ACENamespaceWrapper.self
    }
}
