//
//  InstagridModel.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 07/03/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class InstagridModel {
    
    func asImage(ofView myView: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: myView.bounds)
        return renderer.image { rendererContext in
            myView.layer.render(in: rendererContext.cgContext)
        }
    }

}
