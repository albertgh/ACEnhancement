//
//  CGImage+ACEnhance.swift
//  InstaSlide
//
//  Created by zhuyuankai on 2020/11/27.
//

import UIKit

extension CGImage: ACENamespace {}

extension ACENamespaceWrapper where WrappedType == CGImage {
    
    public func transformedImage(_ transform: CGAffineTransform,
                                 zoomScale: CGFloat,
                                 sourceSize: CGSize,
                                 cropSize: CGSize,
                                 imageViewSize: CGSize) -> CGImage {
        let `self` = wrappedValue
        
        let expectedWidth = floor(sourceSize.width / imageViewSize.width * cropSize.width) / zoomScale
        let expectedHeight = floor(sourceSize.height / imageViewSize.height * cropSize.height) / zoomScale
        let outputSize = CGSize(width: expectedWidth, height: expectedHeight)
        let bitmapBytesPerRow = 0
        
        let context = CGContext(data: nil,
                                width: Int(outputSize.width),
                                height: Int(outputSize.height),
                                bitsPerComponent: self.bitsPerComponent,
                                bytesPerRow: bitmapBytesPerRow,
                                space: self.colorSpace!,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(CGRect(x: CGFloat.zero,
                             y: CGFloat.zero,
                             width: outputSize.width,
                             height: outputSize.height))
        
        var uiCoords = CGAffineTransform(scaleX: outputSize.width / cropSize.width,
                                         y: outputSize.height / cropSize.height)
        uiCoords = uiCoords.translatedBy(x: cropSize.width.ace.half,
                                         y: cropSize.height.ace.half)
        uiCoords = uiCoords.scaledBy(x: 1.0, y: -1.0)
        
        context?.concatenate(uiCoords)
        context?.concatenate(transform)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.draw(self, in: CGRect(x: (-imageViewSize.width.ace.half),
                                       y: (-imageViewSize.height.ace.half),
                                       width: imageViewSize.width,
                                       height: imageViewSize.height))
        
        let result = context!.makeImage()!
        
        return result
    }
}

