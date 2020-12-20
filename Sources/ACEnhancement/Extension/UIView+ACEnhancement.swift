//
//
//  Created by albertchu on 2020/1/21.
//   
//

import UIKit

extension ACENamespaceWrapper where WrappedType: UIView {
    
    // MARK: constraint
    @discardableResult
    public func constraint(attribute: NSLayoutConstraint.Attribute,
                           relatedBy: NSLayoutConstraint.Relation = .equal,
                           toView: UIView? = nil,
                           on: NSLayoutConstraint.Attribute? = nil,
                           multiplier: CGFloat = 1,
                           constant: CGFloat = 0,
                           priority: Float? = nil) -> NSLayoutConstraint? {
        let `self` = wrappedValue
        
        var constraint: NSLayoutConstraint?
        
        guard let item = toView ?? self.superview else { return constraint }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let on = on ?? attribute
        constraint = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: relatedBy,
                                        toItem: item,
                                        attribute: on,
                                        multiplier: multiplier,
                                        constant: constant)
        
        constraint?.isActive = true
        guard let priority = priority else { return constraint }
        constraint?.priority = UILayoutPriority(priority)
        return constraint
    }
    
    public func constraintCenter(view: UIView? = nil) {
        constraint(attribute: .centerX)
        constraint(attribute: .centerY)
    }
    
    public func constraintEdges(view: UIView? = nil) {
        constraint(attribute: .top, toView: view)
        constraint(attribute: .left, toView: view)
        constraint(attribute: .right, toView: view)
        constraint(attribute: .bottom, toView: view)
    }
    
    @discardableResult
    public func constraintWH(attribute: NSLayoutConstraint.Attribute,
                             relatedBy: NSLayoutConstraint.Relation = .equal,
                             toView: UIView? = nil,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0,
                             priority: Float? = nil) -> NSLayoutConstraint? {
        let `self` = wrappedValue
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: relatedBy,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: multiplier,
                                            constant: constant)
        
        constraint.isActive = true
        guard let priority = priority else { return constraint }
        constraint.priority = UILayoutPriority(priority)
        
        return constraint
    }
    
    @discardableResult
    public func constraintW(_ width: CGFloat) -> NSLayoutConstraint? {
        return constraintWH(attribute: .width, constant: width)
    }
    
    @discardableResult
    public func constraintH(_ height: CGFloat) -> NSLayoutConstraint? {
        return constraintWH(attribute: .height, constant: height)
    }
    
    public func constraintSize(_ size: CGSize) {
        constraintWH(attribute: .width, constant: size.width)
        constraintWH(attribute: .height, constant: size.height)
    }
    
    // MARK: style
    public func addShadow() {
        let `self` = wrappedValue
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
    }
    
    public func addBorder(width: CGFloat = 1.0,
                          radius: CGFloat = 0.0,
                          color: UIColor = UIColor.gray) {
        let `self` = wrappedValue
        
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    // MARK: animations
    
    public func fadeAnimation(duration: TimeInterval, fade: Bool) {
        let `self` = wrappedValue
        
        if fade && self.isHidden == true {
            return
        } else if !fade && self.isHidden == false && self.alpha == 1.0 {
            return
        }
        
        if !fade {
            self.isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = fade ? 0.0 : 1.0
        }) { (_) in
            if fade {
                self.isHidden = true
                self.alpha = 0.0
            }
        }
    }
    
    public static func fadeAnimation(duration: TimeInterval, fade: Bool, views: [UIView]) {
        for view in views {
            view.ace.fadeAnimation(duration: duration, fade: fade)
        }
    }
    
    public func fadeoutThenFadein(totalDuration: TimeInterval) {
        let `self` = wrappedValue
        
        UIView.animate(withDuration: totalDuration / 2.0,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations:
                        {
                            self.alpha = 0.0
                        }
        ) { (_) in
        }
        UIView.animate(withDuration: totalDuration / 2.0,
                       delay: totalDuration / 2.0,
                       options: .curveEaseOut,
                       animations:
                        {
                            self.alpha = 1.0
                        }
        ) { (_) in
        }
    }
    
    public func shake() {
        let `self` = wrappedValue
        
        self.transform = CGAffineTransform(translationX: 20.0, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    // MARK: util
    public func removeAllSubviews() {
        let `self` = wrappedValue

        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}
