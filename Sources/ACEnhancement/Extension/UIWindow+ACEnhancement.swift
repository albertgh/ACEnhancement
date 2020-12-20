//
//
//  Created by albertchu on 2020/1/20.
//
//

import UIKit

extension ACENamespaceWrapper where WrappedType == UIWindow {
    public static let safeAreaTop: CGFloat = {
        guard #available(iOS 11, *) else { return 0 }
        let window = UIApplication.shared.windows[0]
        let hairHead: CGFloat = window.safeAreaInsets.top
        guard hairHead > 20.0 else { return 0 }
        return hairHead
    }()
    
    public static let safeAreaBottom: CGFloat = {
        guard #available(iOS 11, *) else { return 0 }
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    }()
    
    public static let mainSize: CGSize = {
        if UIScreen.main.bounds.size.height <  UIScreen.main.bounds.size.width {
            return CGSize(width: UIScreen.main.bounds.size.height, height: UIScreen.main.bounds.size.width)
        }
        return UIScreen.main.bounds.size
    }()
    
    public static func showLoading(dimmingAlpha: CGFloat = 0.3,
                                   yOffset: CGFloat = 0.0,
                                   darkStyle: Bool = false) {
        DispatchQueue.main.async {
            if let currentWindow: UIWindow = UIApplication.shared.windows.first {
                if let loadingBG = currentWindow.viewWithTag(UIWindow.ace_loadingBGViewTag()) {
                    loadingBG.removeFromSuperview()
                }
                
                var indicatorStyle: UIActivityIndicatorView.Style = .whiteLarge
                var indicatorColor: UIColor = .darkGray
                var bgEffectStyle: UIBlurEffect.Style = .light
                if #available(iOS 13, *) {
                    indicatorStyle = .large
                    bgEffectStyle = .systemUltraThinMaterialLight
                }
                if darkStyle {
                    indicatorStyle = .whiteLarge
                    indicatorColor = .white
                    bgEffectStyle = .dark
                    if #available(iOS 13, *) {
                        indicatorStyle = .large
                        bgEffectStyle = .systemUltraThinMaterialDark
                    }
                }
                
                let loadingBG = UIView()
                loadingBG.backgroundColor = UIColor.black.withAlphaComponent(dimmingAlpha)
                currentWindow.addSubview(loadingBG)
                loadingBG.isUserInteractionEnabled = true
                loadingBG.ace.constraintEdges()
                
                let loadingContainerViewEdge: CGFloat = 100.0
                let loadingContainerView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: bgEffectStyle))
                loadingContainerView.layer.cornerRadius = 8.0
                loadingContainerView.layer.masksToBounds = true
                loadingContainerView.clipsToBounds = true
                loadingBG.addSubview(loadingContainerView)
                loadingContainerView.ace.constraint(attribute: .centerX)
                loadingContainerView.ace.constraint(attribute: .centerY, constant: yOffset)
                loadingContainerView.ace.constraintW(loadingContainerViewEdge)
                loadingContainerView.ace.constraintH(loadingContainerViewEdge)
                
                let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: indicatorStyle)
                loadingIndicator.backgroundColor = .clear
                loadingIndicator.color = indicatorColor
                loadingIndicator.hidesWhenStopped = true
                loadingContainerView.contentView.addSubview(loadingIndicator)
                loadingIndicator.ace.constraint(attribute: .centerX)
                loadingIndicator.ace.constraint(attribute: .centerY)
                loadingIndicator.ace.constraintW(loadingContainerViewEdge)
                loadingIndicator.ace.constraintH(loadingContainerViewEdge)
                loadingIndicator.startAnimating()
                
                loadingBG.tag = UIWindow.ace_loadingBGViewTag()
                currentWindow.ace_loadingBGViewTag = UIWindow.ace_loadingBGViewTag()
            }
        }
    }
    public static func hideLoading() {
        DispatchQueue.main.async {
            if let currentWindow: UIWindow = UIApplication.shared.windows.first {
                if let loadingBG = currentWindow.viewWithTag(UIWindow.ace_loadingBGViewTag()) {
                    //loadingBG.ace.removeAllSubviews()
                    loadingBG.removeFromSuperview()
                }
            }
        }
    }
}

extension UIWindow {
    static func ace_loadingBGViewTag() -> Int {
        return 19930330
    }
    private struct ACEUIWINDOW_AssociatedKeys {
        static var loadingBGViewTagKey = "loadingBGViewTagKey"
    }
    
    dynamic var ace_loadingBGViewTag: Int? {
        set {
            objc_setAssociatedObject(self, &ACEUIWINDOW_AssociatedKeys.loadingBGViewTagKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let bgView = objc_getAssociatedObject(self, &ACEUIWINDOW_AssociatedKeys.loadingBGViewTagKey) as? Int {
                return bgView
            } else {
                return nil
            }
        }
    }
}
