//
//
//  Created by albertchu on 2020/1/20.
//
//

import Foundation

extension String: ACENamespace {}
extension ACENamespaceWrapper where WrappedType == String {
    public var localString: String{
        get {
            let `self` = wrappedValue
            return NSLocalizedString(self, comment: self)
        }
    }
}
