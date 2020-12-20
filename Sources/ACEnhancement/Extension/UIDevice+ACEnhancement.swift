//
//
//  Created by albertchu on 2020/1/20.
//
//

import UIKit
import AVFoundation

extension ACENamespaceWrapper where WrappedType == UIDevice {
    public static func videoOrientation() -> AVCaptureVideoOrientation {
        switch UIDevice.current.orientation {
        case .portrait:
            return .portrait

        case .landscapeLeft:
            return .landscapeRight

        case .landscapeRight:
            return .landscapeLeft

        case .portraitUpsideDown:
            return .portraitUpsideDown

        default:
            return .portrait
        }
    }
}
