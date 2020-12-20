//
//
//  Created by albertchu on 2020/1/20.
//
//

import UIKit

extension ACENamespaceWrapper where WrappedType: UICollectionView {
    public func reloadVisibleItems() {
        let `self` = wrappedValue
        self.reloadItems(at: self.indexPathsForVisibleItems)
    }
    
    public func scrollToLast(_ animated: Bool = false) {
        let `self` = wrappedValue

        guard self.numberOfSections > 0 else {
            return
        }

        let lastSection = self.numberOfSections - 1

        guard self.numberOfItems(inSection: lastSection) > 0 else {
            return
        }

        let lastItemIndexPath = IndexPath(item: self.numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        self.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: animated)
    }
}
