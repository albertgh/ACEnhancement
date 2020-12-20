//
//
//  Created by albertchu on 2020/1/20.
//
//

import Foundation

extension TimeInterval: ACENamespace {}
extension ACENamespaceWrapper where WrappedType == TimeInterval {
    public var timeString: String {
        get {
            let `self` = wrappedValue
            
            let df = DateComponentsFormatter()
            df.zeroFormattingBehavior = .pad
            if self >= 3600 {
                df.allowedUnits = [.hour, .minute, .second]
            } else {
                df.allowedUnits = [.minute, .second]
            }
            return df.string(from: self) ?? ""
        }
    }
}
