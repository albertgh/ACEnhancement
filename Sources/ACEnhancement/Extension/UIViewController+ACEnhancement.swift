//
//  UIViewController+ACEnhance.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/12/2.
//

import UIKit

extension ACENamespaceWrapper where WrappedType: UIViewController {
    func didThroughFirstAppear() -> Bool {
        let `self` = wrappedValue
        return self.ace_didThroughFirstAppear
    }
    func setFirstAppearDone() {
        let `self` = wrappedValue
        self.ace_didThroughFirstAppear = true
    }
}

extension UIViewController {
    private struct ACEUIVC_AssociatedKeys {
        static var didThroughFirstAppear = "didThroughFirstAppearAK"
    }
    
    dynamic var ace_didThroughFirstAppear: Bool {
        set {
            objc_setAssociatedObject(self, &ACEUIVC_AssociatedKeys.didThroughFirstAppear, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let didThrough = objc_getAssociatedObject(self, &ACEUIVC_AssociatedKeys.didThroughFirstAppear) as? Bool {
                return didThrough
            } else {
                return false
            }
        }
    }
}
