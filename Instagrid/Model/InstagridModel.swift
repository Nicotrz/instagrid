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
    
    // Enumeration for the differents display dispositions
    enum State
    {
        case firstDisplay
        case secondDisplay
        case thirdDisplay
    }

    // Variable to save the current state of the display ( secondDisplay by default )
    static var state: State = .secondDisplay
    
    // This function transform a UIView into a UIImage
    static func asImage(ofView myView: UIView) -> UIImage {
        // Set the GraphicImagerenderer into bounds of the result view
        let renderer = UIGraphicsImageRenderer(bounds: myView.bounds)
        // Return the result image by setting the context from the render of the view
        return renderer.image { rendererContext in
            myView.layer.render(in: rendererContext.cgContext)
        }
        
    }

    //This function takes an asset of PHPhotos and transform it into a UIImage
    static func getAssetThumbnail(asset: PHAsset) -> UIImage {
        // The result who will be sended
        var retimage = UIImage()
        // The manager who will handle the transformation
        let manager = PHImageManager.default()
        // This object will manage the options of the request
        let requestOptions = PHImageRequestOptions()
        // The size of the result will be the same as the original image with the best quality possible
        requestOptions.resizeMode   = PHImageRequestOptionsResizeMode.exact
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        // If needed, the image will be taken from iCloud
        requestOptions.isNetworkAccessAllowed = true
        // This option is needed to block the process until the image is fully loaded
        requestOptions.isSynchronous = true
        // The manager request the image for the asset sended as argument, with the size of the asset, on aspectFit mode with the options from requestOptions
        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: requestOptions, resultHandler: {(result, info)->Void in
            // The result is an optional UIImage, we need to unwrapped it first
            if let myImage = result {
                retimage = myImage
            }
        })
        return retimage
    }
}
