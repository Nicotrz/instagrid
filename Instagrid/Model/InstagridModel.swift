//
//  InstagridModel.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 07/03/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit
import Photos

class InstagridModel {
    
    enum State
    {
        case firstDisplay
        case secondDisplay
        case thirdDisplay
    }

    static var state: State = .secondDisplay
    
    static func asImage(ofView myView: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: myView.bounds)
        return renderer.image { rendererContext in
            myView.layer.render(in: rendererContext.cgContext)
        }
    }

    static func getAssetThumbnail(asset: PHAsset) -> UIImage {
        var retimage = UIImage()
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode   = PHImageRequestOptionsResizeMode.exact
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: requestOptions, resultHandler: {(result, info)->Void in
            if let myImage = result {
                retimage = myImage
            }
            
        })
        return retimage
    }
}
