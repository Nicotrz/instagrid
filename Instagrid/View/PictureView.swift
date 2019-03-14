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
    
    // Enumeration for the direction of the animated arrow
    enum ArrowDirrection
    {
        case down
        case left
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
    
    private var arrowLabel = UILabel()
    private var swipeLabel = UILabel()
    private var randomButton = UIButton()
    
    
    // When the arrowDirrection variable change, we change the text of the swipeLabel and the arrowLabel to match the screen, and we animate the arrow on the right direction
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
    
    // This function is called to animate the arrow only whitout knowing the direction
    func animateTheArrowWhitoutDirection() {
        // If the device is portrait oriented, we animate it on the down direction
        if UIDevice.current.orientation.isPortrait {
            animateTheArrow(arrowDirrection: .down)
        } else {
            // If the device is landscape oriented, we animate it on the left direction
            animateTheArrow(arrowDirrection: .left)
        }
    }
    
    // This function animate the arrow on the direction sended on argument
    private func animateTheArrow(arrowDirrection: ArrowDirrection) {
        // The object who will handle the animation
        let translationTransform: CGAffineTransform
        
        // This constand indicate the coordinates of the animation - setted in function of the direction sended on argument
        let x: CGFloat
        let y: CGFloat
        switch arrowDirrection {
        case .down:
            x = 0
            y = -20
        case .left:
            x = 20
            y = 0
        }
        translationTransform = CGAffineTransform(translationX: x, y: y)
        // We animate the arrow on loop ( repeat and autoreverse )
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.arrowLabel.transform = translationTransform
            
        }, completion: nil)
    }
    
    // This function set the properties with the argument sended by the controller
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
