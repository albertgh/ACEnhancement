//
//
//  Created by albertchu on 2020/1/20.
//
//

import UIKit
import Photos

extension ACENamespaceWrapper where WrappedType == PHAsset {
    public func requestImage(size: CGSize? = nil,
                             iCloudProgress: @escaping ((Double) -> Void),
                             completion: @escaping (UIImage?) -> Void) {
        //let `self` = wrappedValue
        let asset = wrappedValue
        
        var requestSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        if let customSize = size {
            requestSize = customSize
        }
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = false
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .fast
        PHImageManager
            .default()
            .requestImage(for: asset,
                          targetSize: requestSize,
                          contentMode: .aspectFill,
                          options: options) { (image, info) in
                
                var isError = false
                if let info = info,
                   let _ = info[PHImageErrorKey] {
                    isError = true
                }
                
                var isCancelled = false
                if let info = info,
                   let cancelled = info[PHImageCancelledKey] as? NSNumber,
                   cancelled.boolValue == true {
                    isCancelled = true
                }
                
                var isDegraded = false
                if let info = info,
                   let degraded = info[PHImageResultIsDegradedKey] as? NSNumber,
                   degraded.boolValue == true {
                    isDegraded = true
                }
                
                var isInCloud = false
                if let info = info,
                   let inCloud = info[PHImageResultIsInCloudKey] as? NSNumber,
                   inCloud.boolValue == true {
                    isInCloud = true
                }
                
                if !isError, !isCancelled, !isDegraded, !isInCloud {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    if isInCloud {
                        // download from iCloud
                        let cloudRequestOptions = PHImageRequestOptions()
                        cloudRequestOptions.deliveryMode = .highQualityFormat
                        cloudRequestOptions.isSynchronous = false
                        cloudRequestOptions.isNetworkAccessAllowed = true
                        cloudRequestOptions.progressHandler = { (progress, error, stop, info) in
                            iCloudProgress(progress)
                        }
                        if #available(iOS 13, *) {
                            PHImageManager.default().requestImageDataAndOrientation(
                                for: asset,
                                options: cloudRequestOptions) { (data, _, _, _) in
                                var resultImage = image
                                if let data = data {
                                    resultImage = UIImage(data: data)
                                }
                                DispatchQueue.main.async {
                                    completion(resultImage)
                                }
                            }
                        } else {
                            PHImageManager.default().requestImageData(
                                for: asset,
                                options: cloudRequestOptions,
                                resultHandler: { (data, _, _, _) -> Void in
                                    var resultImage = image
                                    if let data = data {
                                        resultImage = UIImage(data: data)
                                    }
                                    DispatchQueue.main.async {
                                        completion(resultImage)
                                    }
                                })
                        }
                    }
                }
            }
    }
}
