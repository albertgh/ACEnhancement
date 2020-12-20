//
//
//  Created by albertchu on 2020/1/20.
//
//

import UIKit

extension ACENamespaceWrapper where WrappedType == UIColor {
    public static func hexString(_ string: String, alpha: CGFloat = 1.0) -> UIColor {
        var hex = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("0X") {
            hex = String(hex.dropFirst(2))
        }
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }

        let rStr = String(hex.prefix(2))
        hex = String(hex.dropFirst(2))
        let gStr = String(hex.prefix(2))
        hex = String(hex.dropFirst(2))
        let bStr = String(hex.prefix(2))

        var r: UInt64 = 0
        var g: UInt64 = 0
        var b: UInt64 = 0
        Scanner(string: "\(rStr)").scanHexInt64(&r)
        Scanner(string: "\(gStr)").scanHexInt64(&g)
        Scanner(string: "\(bStr)").scanHexInt64(&b)

        let color: UIColor = UIColor.init(red: CGFloat(r) / 255.0,
                                          green: CGFloat(g) / 255.0,
                                          blue: CGFloat(b) / 255.0,
                                          alpha: alpha)

        return color
    }

    public static func hex(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let r = (hex >> 16) & 0xFF
        let g = (hex >> 8) & 0xFF
        let b = hex & 0xFF

        let color: UIColor = UIColor.init(red: CGFloat(r) / 0xFF,
                                          green: CGFloat(g) / 0xFF,
                                          blue: CGFloat(b) / 0xFF,
                                          alpha: alpha)

        return color
    }
}
