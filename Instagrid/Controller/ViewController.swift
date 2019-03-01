//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 25/02/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var myView: PictureView!
    @IBOutlet weak var firstRectangleView: UIView!
    @IBOutlet weak var secondRectangleView: UIView!
    @IBOutlet weak var firstSquareView: UIView!
    @IBOutlet weak var secondSquareView: UIView!
    @IBOutlet weak var thirdSquareView: UIView!
    @IBOutlet weak var fourthSquareView: UIView!
    @IBOutlet weak var selectedSquareFirst: UIImageView!
    @IBOutlet weak var selectedSquareSecond: UIImageView!
    @IBOutlet weak var selectedSquareThird: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.setPictureView(firstSquareView: firstSquareView, secondSquareView: secondSquareView, thirdSquareView: thirdSquareView, fourthSquareView: fourthSquareView, firstRectangleView: firstRectangleView, secondRectangleView: secondRectangleView, selectedSquareFirst: selectedSquareFirst, selectedSquareSecond: selectedSquareSecond, selectedSquareThird: selectedSquareThird)
    }

    @IBAction func switchToFirstDisplay(_ sender: Any) {
        myView.state = .firstDisplay
    }
    
    @IBAction func switchToSecondDisplay(_ sender: Any) {
        myView.state = .secondDisplay
    }
    
    @IBAction func switchToThirdDisplay(_ sender: Any) {
        myView.state = .thirdDisplay
    }
    
    
}

