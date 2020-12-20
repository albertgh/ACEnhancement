//
//  NSObject+ACEnhance.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/11/12.
//

import Foundation

extension NSObject: ACENamespace {}
extension ACENamespaceWrapper where WrappedType: NSObject {
    public func setAssociated<T>(value: T, associatedKey: UnsafeRawPointer, policy: objc_AssociationPolicy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) -> Void {
        objc_setAssociatedObject(self, associatedKey, value, policy)
    }
    public func getAssociated(associatedKey: UnsafeRawPointer) -> Any? {
        let value = objc_getAssociatedObject(self, associatedKey)
        return value;
    }
}
