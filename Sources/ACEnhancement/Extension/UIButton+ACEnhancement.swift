//
//  UIButton+ACEnhance.swift
//
//  Created by zhuyuankai on 2020/11/11.
//

import UIKit

public enum ACEButtonLayout {
    case top
    case left
    case right
    case bottom
}

extension ACENamespaceWrapper where WrappedType: UIButton {
    
    // MARK: layout
    public func layoutButton(with style: ACEButtonLayout,
                      imageTitleSpace: CGFloat) {
        let `self` = wrappedValue
        
        let imageWidth: CGFloat = self.imageView?.frame.size.width ?? 0.0
        let imageHeight: CGFloat = self.imageView?.frame.size.height ?? 0.0
        
        let labelWidth: CGFloat = self.titleLabel?.intrinsicContentSize.width ?? 0.0
        let labelHeight: CGFloat = self.titleLabel?.intrinsicContentSize.height ?? 0.0
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - imageTitleSpace / 2.0,
                                           left: 0.0,
                                           bottom: 0.0,
                                           right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0.0,
                                           left: -imageWidth,
                                           bottom: -imageHeight - imageTitleSpace / 2.0,
                                           right: 0.0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0.0,
                                           left: -imageTitleSpace / 2.0,
                                           bottom: 0.0,
                                           right: imageTitleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0.0,
                                           left: imageTitleSpace / 2.0,
                                           bottom: 0.0,
                                           right: -imageTitleSpace/2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0.0,
                                           left: 0.0,
                                           bottom: -labelHeight - imageTitleSpace / 2.0,
                                           right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - imageTitleSpace / 2.0,
                                           left: -imageWidth,
                                           bottom: 0.0,
                                           right: 0.0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0.0,
                                           left: labelWidth + imageTitleSpace / 2.0,
                                           bottom: 0.0,
                                           right: -labelWidth - imageTitleSpace / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0.0,
                                           left: -imageWidth - imageTitleSpace / 2.0,
                                           bottom: 0.0,
                                           right: imageWidth + imageTitleSpace / 2.0)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    // MARK: enlarge
    public func enlargeEdge(_ edge: CGFloat) {
        let `self` = wrappedValue
        self.ace_enlargeEdge = edge
    }
    public func enlargeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        let `self` = wrappedValue
        self.ace_setEnlargeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

extension UIButton {
    // MARK: enlarge
    private struct EnlargeAssociatedKeys {
        static var topNameKey = "topNameKey"
        static var leftNameKey = "leftNameKey"
        static var bottomNameKey = "bottomNameKey"
        static var rightNameKey = "rightNameKey"
    }
    
    dynamic var ace_enlargeEdge: CGFloat {
        set {
            ace_setEnlargeInsets(top: newValue,
                                 left: newValue,
                                 bottom: newValue,
                                 right: newValue)
        }
        get {
            if let topEdge = objc_getAssociatedObject(self, &EnlargeAssociatedKeys.topNameKey) as? NSNumber {
                return CGFloat(topEdge.floatValue)
            } else {
                return 0
            }
        }
    }
    func ace_setEnlargeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        objc_setAssociatedObject(self, &EnlargeAssociatedKeys.topNameKey, NSNumber(value: Float(top)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &EnlargeAssociatedKeys.leftNameKey, NSNumber(value: Float(left)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &EnlargeAssociatedKeys.bottomNameKey, NSNumber(value: Float(bottom)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &EnlargeAssociatedKeys.rightNameKey, NSNumber(value: Float(right)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    private dynamic func ace_enlargedRect() -> CGRect {
        let topEdge = objc_getAssociatedObject(self, &EnlargeAssociatedKeys.topNameKey) as? NSNumber
        let leftEdge = objc_getAssociatedObject(self, &EnlargeAssociatedKeys.leftNameKey) as? NSNumber
        let bottomEdge = objc_getAssociatedObject(self, &EnlargeAssociatedKeys.bottomNameKey) as? NSNumber
        let rightEdge = objc_getAssociatedObject(self, &EnlargeAssociatedKeys.rightNameKey) as? NSNumber
        if let topEdge = topEdge, let rightEdge = rightEdge, let bottomEdge = bottomEdge, let leftEdge = leftEdge {
            return CGRect(x: bounds.origin.x - CGFloat(leftEdge.floatValue),
                          y: bounds.origin.y - CGFloat(topEdge.floatValue),
                          width: bounds.size.width + CGFloat(leftEdge.floatValue) + CGFloat(rightEdge.floatValue),
                          height: bounds.size.height + CGFloat(topEdge.floatValue) + CGFloat(bottomEdge.floatValue))
        } else {
            return bounds
        }
    }
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = ace_enlargedRect()
        if rect.equalTo(self.bounds) || self.isHidden {
            return super.hitTest(point, with: event)
        }
        return rect.contains(point) ? self : nil
    }
}
