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
    
    enum ArrowDirrection
    {
        case down
        case left
    }

    private var firstSquareView = UIView()
    private var secondSquareView =  UIView()
    private var thirdSquareView = UIView()
    private var fourthSquareView = UIView()
    private var firstRectangleView = UIView()
    private var secondRectangleView = UIView()
    private var selectedSquareFirst = UIImageView()
    private var selectedSquareSecond = UIImageView()
    private var selectedSquareThird = UIImageView()
    
    private var arrowLabel = UILabel()
    private var swipeLabel = UILabel()
    private var randomButton = UIButton()
    
    
    var arrowDirrection: ArrowDirrection = .down {
        didSet {
            arrowLabel.transform = .identity
            switch arrowDirrection {
            case .down:
                animateTheArrow(arrowDirrection: .down)
                swipeLabel.text = "Swipe up to share"
                arrowLabel.text = "^"
            case .left:
                animateTheArrow(arrowDirrection: .left)
                swipeLabel.text = "Swipe left to share"
                arrowLabel.text = "<"
            }
        }
    }
    
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
    
    func animateTheArrowWhitoutDirection() {
        if UIDevice.current.orientation.isPortrait {
            animateTheArrow(arrowDirrection: .down)
        } else {
            animateTheArrow(arrowDirrection: .left)
        }
    }
    
    private func animateTheArrow(arrowDirrection: ArrowDirrection) {
        let translationTransform: CGAffineTransform
        switch arrowDirrection {
        case .down:
            translationTransform = CGAffineTransform(translationX: 0, y: -20 )
        case .left:
            translationTransform = CGAffineTransform(translationX: 20, y: 0 )
        }
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.arrowLabel.transform = translationTransform
            
        }, completion: nil)
    }
    
    func setPictureView(firstSquareView: UIView, secondSquareView: UIView, thirdSquareView: UIView, fourthSquareView: UIView, firstRectangleView: UIView, secondRectangleView: UIView, selectedSquareFirst: UIImageView, selectedSquareSecond: UIImageView, selectedSquareThird: UIImageView, arrowLabel: UILabel, swipeLabel: UILabel, randomButton: UIButton) {
        self.firstSquareView = firstSquareView
        self.secondSquareView = secondSquareView
        self.thirdSquareView = thirdSquareView
        self.fourthSquareView = fourthSquareView
        self.firstRectangleView = firstRectangleView
        self.secondRectangleView = secondRectangleView
        self.selectedSquareFirst = selectedSquareFirst
        self.selectedSquareSecond = selectedSquareSecond
        self.selectedSquareThird = selectedSquareThird
        self.arrowLabel = arrowLabel
        self.swipeLabel = swipeLabel
        self.randomButton = randomButton
        self.arrowDirrection = .down
    }
    
    
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

    func setImage (ofView imageView: UIImageView, image: UIImage, withPlusLabel label: UIButton ) {
        imageView.image = image
        imageView.isHidden = false
        label.isHidden = true
        imageView.isUserInteractionEnabled = true
    }

}
