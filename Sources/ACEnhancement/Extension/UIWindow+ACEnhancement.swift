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
    
    // MARK: common loading hud
    public static func showLoading(dimmingAlpha: CGFloat? = 0.3,
                                   yOffset: CGFloat? = 0.0,
                                   message: String? = nil,
                                   messageFont: UIFont? = UIFont.systemFont(ofSize: 18.0),
                                   darkStyle: Bool? = false) {
        DispatchQueue.main.async {
            if let currentWindow: UIWindow = UIApplication.shared.windows.first {
                if let existLoadingView = currentWindow.viewWithTag(UIWindow.ace_loadingBGViewTag()) {
                    //existLoadingView.ace.removeAllSubviews()
                    existLoadingView.removeFromSuperview()
                }
                
                let loadingView = UIWindow.ace.assembleLoadingView(dimmingAlpha: dimmingAlpha, yOffset: yOffset, message: message, darkStyle: darkStyle)
                currentWindow.addSubview(loadingView)
                loadingView.ace.constraintEdges()
                
                loadingView.tag = UIWindow.ace_loadingBGViewTag()
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
    private static func assembleLoadingView(dimmingAlpha: CGFloat? = 0.3,
                                            yOffset: CGFloat? = 0.0,
                                            message: String? = nil,
                                            messageFont: UIFont? = UIFont.systemFont(ofSize: 18.0),
                                            darkStyle: Bool? = false) -> UIView {
        var textColor: UIColor = .black
        var indicatorStyle: UIActivityIndicatorView.Style = .whiteLarge
        var indicatorColor: UIColor = .darkGray
        var bgEffectStyle: UIBlurEffect.Style = .light
        if #available(iOS 13, *) {
            indicatorStyle = .large
            bgEffectStyle = .systemUltraThinMaterialLight
        }
        if let dark = darkStyle, dark == true {
            textColor = .lightText
            indicatorStyle = .whiteLarge
            indicatorColor = .white
            bgEffectStyle = .dark
            if #available(iOS 13, *) {
                indicatorStyle = .large
                bgEffectStyle = .systemUltraThinMaterialDark
            }
        }
        
        var loadingBGAlpha: CGFloat = 0.3
        if let dimmingAlpha = dimmingAlpha {
            loadingBGAlpha = dimmingAlpha
        }
        let loadingBG = UIView()
        loadingBG.backgroundColor = UIColor.black.withAlphaComponent(loadingBGAlpha)
        loadingBG.isUserInteractionEnabled = true
        
        var loadingContainerViewYOffset: CGFloat = 0.0
        if let loadingYOffset = yOffset {
            loadingContainerViewYOffset = loadingYOffset
        }
        var loadingContainerViewW: CGFloat = 100.0
        var loadingContainerViewH: CGFloat = 100.0
        let loadingContainerView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: bgEffectStyle))
        loadingContainerView.layer.cornerRadius = 8.0
        loadingContainerView.layer.masksToBounds = true
        loadingContainerView.clipsToBounds = true
        loadingBG.addSubview(loadingContainerView)
        if let msg = message, msg.isEmpty == false {
            let gapSpace: CGFloat = 10.0
            loadingContainerViewW = 260.0
            loadingContainerViewH = 200.0
            let messageTextView: UITextView = UITextView()
            messageTextView.isEditable = false
            messageTextView.font = messageFont
            messageTextView.textColor = textColor
            messageTextView.textAlignment = .center
            messageTextView.text = message
            messageTextView.backgroundColor = .clear
            loadingContainerView.contentView.addSubview(messageTextView)
            
            messageTextView.sizeToFit()
            var tvH: CGFloat = 100.0
            let tvFullH: CGFloat = CGFloat(ceil(messageTextView.sizeThatFits(CGSize(width: (loadingContainerViewW - gapSpace * 2.0), height: tvH)).height))
            if tvFullH < 100.0 {
                loadingContainerViewH -= (tvH - tvFullH)
                tvH = messageTextView.contentSize.height
            }
            messageTextView.ace.constraint(attribute: .left, constant: gapSpace)
            messageTextView.ace.constraint(attribute: .right, constant: -gapSpace)
            messageTextView.ace.constraint(attribute: .bottom, constant: -gapSpace)
            messageTextView.ace.constraintH(tvH)
        }
        loadingContainerView.ace.constraint(attribute: .centerX)
        loadingContainerView.ace.constraint(attribute: .centerY, constant: loadingContainerViewYOffset)
        loadingContainerView.ace.constraintW(loadingContainerViewW)
        loadingContainerView.ace.constraintH(loadingContainerViewH)
        
        let loadingIndicatorEdge: CGFloat = 100.0
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: indicatorStyle)
        loadingIndicator.backgroundColor = .clear
        loadingIndicator.color = indicatorColor
        loadingIndicator.hidesWhenStopped = true
        loadingContainerView.contentView.addSubview(loadingIndicator)
        loadingIndicator.ace.constraint(attribute: .centerX)
        loadingIndicator.ace.constraint(attribute: .top, constant: 0)
        loadingIndicator.ace.constraintW(loadingIndicatorEdge)
        loadingIndicator.ace.constraintH(loadingIndicatorEdge)
        loadingIndicator.startAnimating()
        
        return loadingBG
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
