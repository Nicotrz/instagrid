//
//  PictureView.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 01/03/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class PictureView: UIView {

    // Enumeration for the different display states
    enum State
    {
        case firstDisplay
        case secondDisplay
        case thirdDisplay
    }

    // Elements of the view who will be used here
    private var firstSquareView = UIView()
    private var secondSquareView =  UIView()
    private var thirdSquareView = UIView()
    private var fourthSquareView = UIView()
    private var firstRectangleView = UIView()
    private var secondRectangleView = UIView()
    private var selectedSquareFirst = UIImageView()
    private var selectedSquareSecond = UIImageView()
    private var selectedSquareThird = UIImageView()
    
    // This function set the properties with the argument sended by the controller
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
    
    // This function is called to change the grid
    func switchDisplay(state: State ) {
        switch state {
        case .firstDisplay:
            changeStateView(hideFirstSelected: false, hideSecondSelected: true, hideThirdSelected: true, hideFirstSquare: true, hideSecondSquare: true, hideThirdSquare: false, hideFourthSquare: false, hideFirstRectangle: false, hideSecondRectangle: true)
        case .secondDisplay:
            changeStateView(hideFirstSelected: true, hideSecondSelected: false, hideThirdSelected: true, hideFirstSquare: false, hideSecondSquare: false, hideThirdSquare: true, hideFourthSquare: true, hideFirstRectangle: true, hideSecondRectangle: false)
        case .thirdDisplay:
            changeStateView(hideFirstSelected: true, hideSecondSelected: true, hideThirdSelected: false, hideFirstSquare: false, hideSecondSquare: false, hideThirdSquare: false, hideFourthSquare: false, hideFirstRectangle: true, hideSecondRectangle: true)
        }
    }
    
    
    
    // This function change the view with the argument sended
    private func changeStateView(hideFirstSelected: Bool, hideSecondSelected:Bool, hideThirdSelected: Bool, hideFirstSquare: Bool, hideSecondSquare: Bool, hideThirdSquare: Bool, hideFourthSquare: Bool, hideFirstRectangle: Bool, hideSecondRectangle: Bool ) {
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

    // This function set the image on one of the view of the grid with the UIImage, and will hide the + Label associated
    func setImage (ofView imageView: UIImageView, image: UIImage, withPlusLabel label: UIButton ) {
        imageView.image = image
        imageView.isHidden = false
        label.isHidden = true
        imageView.isUserInteractionEnabled = true
    }

}
