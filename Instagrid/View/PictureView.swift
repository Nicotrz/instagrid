//
//  PictureView.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 01/03/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class PictureView: UIView {

    enum State
    {
        case firstDisplay
        case secondDisplay
        case thirdDisplay
    }

    var firstSquareView = UIView()
    var secondSquareView =  UIView()
    var thirdSquareView = UIView()
    var fourthSquareView = UIView()
    var firstRectangleView = UIView()
    var secondRectangleView = UIView()
    var selectedSquareFirst = UIImageView()
    var selectedSquareSecond = UIImageView()
    var selectedSquareThird = UIImageView()
    
    
    var state: State = .secondDisplay {
        didSet {
            switch state {
            case .firstDisplay:
                changeStateView(hideFirstSelected: false, hideSecondSelected: true, hideThirdSelected: true, hideFirstSquare: true, hideSecondSquare: true, hideThirdSquare: false, hideFourthSquare: false, hideFirstRectangle: false, hideSecondRectangle: true)
            case .secondDisplay:
                changeStateView(hideFirstSelected: true, hideSecondSelected: false, hideThirdSelected: true, hideFirstSquare: false, hideSecondSquare: false, hideThirdSquare: true, hideFourthSquare: true, hideFirstRectangle: true, hideSecondRectangle: false)
            case .thirdDisplay:
                changeStateView(hideFirstSelected: true, hideSecondSelected: true, hideThirdSelected: false, hideFirstSquare: false, hideSecondSquare: false, hideThirdSquare: false, hideFourthSquare: false, hideFirstRectangle: true, hideSecondRectangle: true)
            }
        }
    }
    
    func setPictureView(firstSquareView: UIView, secondSquareView: UIView, thirdSquareView: UIView, fourthSquareView: UIView, firstRectangleView: UIView, secondRectangleView: UIView, selectedSquareFirst: UIImageView, selectedSquareSecond: UIImageView, selectedSquareThird: UIImageView) {
        self.firstSquareView = firstSquareView
        self.secondSquareView = secondSquareView
        self.thirdSquareView = thirdSquareView
        self.fourthSquareView = fourthSquareView
        self.firstRectangleView = firstRectangleView
        self.secondRectangleView = secondRectangleView
        self.selectedSquareFirst = selectedSquareFirst
        self.selectedSquareSecond = selectedSquareSecond
        self.selectedSquareThird = selectedSquareThird
    }
    
    
    func changeStateView(hideFirstSelected: Bool, hideSecondSelected:Bool, hideThirdSelected: Bool, hideFirstSquare: Bool, hideSecondSquare: Bool, hideThirdSquare: Bool, hideFourthSquare: Bool, hideFirstRectangle: Bool, hideSecondRectangle: Bool ) {
        selectedSquareFirst.isHidden = hideFirstSelected
        selectedSquareSecond.isHidden = hideSecondSelected
        selectedSquareThird.isHidden = hideThirdSelected
        firstSquareView.isHidden = hideFirstSquare
        secondSquareView.isHidden = hideSecondSquare
        thirdSquareView.isHidden = hideThirdSquare
        fourthSquareView.isHidden = hideFourthSquare
        firstRectangleView.isHidden = hideFirstRectangle
        secondRectangleView.isHidden = hideSecondRectangle
    }
}
