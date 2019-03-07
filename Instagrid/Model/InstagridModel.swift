//
//  InstagridModel.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 07/03/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class InstagridModel {
    
    enum State
    {
        case firstDisplay
        case secondDisplay
        case thirdDisplay
    }

    var state: State = .secondDisplay
    
    func asImage(ofView myView: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: myView.bounds)
        return renderer.image { rendererContext in
            myView.layer.render(in: rendererContext.cgContext)
        }
    }

}
