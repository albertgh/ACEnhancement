//
//  UIAlertController+ACEnhance.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/12/6.
//


import UIKit

extension ACENamespaceWrapper where WrappedType == UIAlertController {
    
    /** sample
        `darkStyle` only available for iOS 13
    
     UIAlertController.ace.showAlert(
     inVC: self,
     darkStyle: true,
     titleText: "test",
     messageText: "some msg",
     cancelTuple: ("cancel", { (action) in
        }),
     normalActionTuples:  [
         ("ok", { (action) in
         })
        ]
     )
     */
    public static func showAlert(inVC: UIViewController,
                                 darkStyle: Bool = false,
                                 titleText: String? = nil,
                                 messageText: String? = nil,
                                 cancelTuple: (String?, ((UIAlertAction) -> Void)?) = (nil, nil),
                                 normalActionTuples: [(String?, ((UIAlertAction) -> Void)?)] = [],
                                 destructiveTuple: (String?, ((UIAlertAction) -> Void)?) = (nil, nil)) {
        let alert = UIAlertController(title: titleText,
                                      message: messageText,
                                      preferredStyle: .alert)
        if darkStyle,
           #available(iOS 13, *) {
            alert.overrideUserInterfaceStyle = .dark
        }
        
        if let cancelAction = cancelTuple.1,
           let cancelString = cancelTuple.0,
           !cancelString.isEmpty {
            let cancelAlertAction = UIAlertAction(
                title: cancelString,
                style: .cancel,
                handler: cancelAction)
            alert.addAction(cancelAlertAction)
        }
        
        for normalActionTuple in normalActionTuples {
            if let normalAction = normalActionTuple.1,
               let normalString = normalActionTuple.0,
               !normalString.isEmpty {
                let normalAlertAction = UIAlertAction(
                    title: normalString,
                    style: .default,
                    handler: normalAction)
                alert.addAction(normalAlertAction)
            }
        }
        
        if let destructiveAction = destructiveTuple.1,
           let destructiveString = destructiveTuple.0,
           !destructiveString.isEmpty {
            let destructiveAlertAction = UIAlertAction(
                title: destructiveString,
                style: .destructive,
                handler: destructiveAction)
            alert.addAction(destructiveAlertAction)
        }
        
        inVC.present(alert, animated: true) {
        }
    }
    
    /** sample
     `darkStyle` only available for iOS 13

    UIAlertController.ace.showToast(inVC: self, uiStyle: .dark, dismissAfter: 1, messageText: "toast")
     */
    public static func showToast(inVC: UIViewController,
                                 darkStyle: Bool = false,
                                 dismissAfter: TimeInterval = 0.25,
                                 messageText: String) {
        let alert = UIAlertController(title: "",
                                      message: messageText,
                                      preferredStyle: .alert)
        if darkStyle,
           #available(iOS 13, *) {
            alert.overrideUserInterfaceStyle = .dark
        }
        alert.ace_attributedMessage(NSAttributedString(string: messageText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]))

        inVC.present(alert, animated: true) {
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
            alert.dismiss(animated: true) {
            }
        }
    }
}
    
extension UIAlertController {
    @discardableResult
    func ace_attributedTitle(_ attributedTitle: NSAttributedString) -> UIAlertController {
        setValue(attributedTitle, forKey: "attributedTitle")
        return self
    }

    @discardableResult
    func ace_attributedMessage(_ attributedMsg: NSAttributedString) -> UIAlertController {
        setValue(attributedMsg, forKey: "attributedMessage")
        return self
    }
    
    @discardableResult
    func ace_attributedDetailMessage(_ attributedDetailMsg: NSAttributedString) -> UIAlertController {
        setValue(attributedDetailMsg, forKey: "attributedDetailMessage")
        return self
    }

    @discardableResult
    func ace_setCornerRadius(_ cornerRadius: CGFloat) -> UIAlertController {
        ace_setCornerRadius(cornerRadius, in: view)
        return self
    }
    @objc private dynamic func ace_setCornerRadius(_ cornerRadius: CGFloat, in parent: UIView) {

        let subviews = parent.subviews
        for v in subviews {
            if v.layer.cornerRadius > 0 && !v.isKind(of: UITextField.self) {
                v.layer.cornerRadius = cornerRadius
            }
            ace_setCornerRadius(cornerRadius, in: v)
        }
    }

    @discardableResult
    func ace_setMessageHeight(_ height: CGFloat) -> UIAlertController {
        ace_setMessageHeight(height, in: view)
        return self
    }
    @objc private dynamic func ace_setMessageHeight(_ height: CGFloat, in parent: UIView) {
        let subviews = parent.subviews
        for v in subviews {
            if v.isKind(of: UILabel.self) && (v as! UILabel).text == message {
                v.addConstraint(NSLayoutConstraint(item: v,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1,
                                                   constant: height))
            } else {
                ace_setMessageHeight(height, in: v)
            }
        }
    }
}
