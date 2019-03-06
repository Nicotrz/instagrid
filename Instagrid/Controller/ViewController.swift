//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 25/02/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    enum PickerChoose {
        case firstSquare
        case secondSquare
        case thirdSquare
        case fourthSquare
        case firstRectangle
        case secondRectangle
    }
    
    var pickerChoose: PickerChoose = .firstSquare
    
    @IBOutlet weak var myView: PictureView!
    
    @IBOutlet weak var swipeLabelView: UIView!
    
    
    @IBOutlet weak var firstRectangleView: UIView!
    @IBOutlet weak var firstRectangleImage: UIImageView!
    @IBOutlet weak var firstRectanglePlusLabel: UIButton!
    
    @IBOutlet weak var secondRectangleView: UIView!
    @IBOutlet weak var secondRectangleImage: UIImageView!
    @IBOutlet weak var secondRectanglePlusLabel: UIButton!
    
    @IBOutlet weak var firstSquareView: UIView!
    @IBOutlet weak var firstSquareImage: UIImageView!
    @IBOutlet weak var firstSquarePlusLabel: UIButton!
    
    @IBOutlet weak var secondSquareView: UIView!
    @IBOutlet weak var secondSquareImage: UIImageView!
    @IBOutlet weak var secondSquarePlusLabel: UIButton!
    
    @IBOutlet weak var thirdSquareView: UIView!
    @IBOutlet weak var thirdSquareImage: UIImageView!
    @IBOutlet weak var thirdSquarePlusLabel: UIButton!
    
    @IBOutlet weak var fourthSquareView: UIView!
    @IBOutlet weak var fourthSquareImage: UIImageView!
    @IBOutlet weak var fourthSquarePlusLabel: UIButton!
    
    @IBOutlet weak var selectedSquareFirst: UIImageView!
    @IBOutlet weak var selectedSquareSecond: UIImageView!
    @IBOutlet weak var selectedSquareThird: UIImageView!
    
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.setPictureView(firstSquareView: firstSquareView, secondSquareView: secondSquareView, thirdSquareView: thirdSquareView, fourthSquareView: fourthSquareView, firstRectangleView: firstRectangleView, secondRectangleView: secondRectangleView, selectedSquareFirst: selectedSquareFirst, selectedSquareSecond: selectedSquareSecond, selectedSquareThird: selectedSquareThird)
        let translationTransform = CGAffineTransform(translationX: 0, y: -20 )
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.arrowLabel.transform = translationTransform
            
        }, completion: nil)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        arrowLabel.transform = .identity
        super.viewWillTransition(to: size, with: coordinator)
        let translationTransform : CGAffineTransform
        if UIDevice.current.orientation.isLandscape {
            swipeLabel.text = "Swipe right to share"
            arrowLabel.text = ">"
            translationTransform = CGAffineTransform(translationX: 20, y: 0 )
        } else {
            swipeLabel.text = "Swipe up to share"
            arrowLabel.text = "^"
            translationTransform = CGAffineTransform(translationX: 0, y: -20 )
        }
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.arrowLabel.transform = translationTransform
            
        }, completion: nil)
    }
    


    @IBAction func addPictureToFirstRectangle(_ sender: Any) {
        callPicker(withPicker: .firstRectangle)
    }
        
    @IBAction func addPictureToSecondRectangle(_ sender: Any) {
        callPicker(withPicker: .secondRectangle)
    }
    
    @IBAction func addPictureToFirstSquare(_ sender: Any) {
        callPicker(withPicker: .firstSquare)
    }
    
    @IBAction func addPictureToSecondSquare(_ sender: Any) {
        callPicker(withPicker: .secondSquare)
    }
    
    @IBAction func addPictureToThirdSquare(_ sender: Any) {
        callPicker(withPicker: .thirdSquare)
    }
    
    @IBAction func addPictureToFourthSquare(_ sender: Any) {
        callPicker(withPicker: .fourthSquare)
    }
    
    
    func callPicker(withPicker picker: PickerChoose) {
        pickerChoose = picker
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.modalPresentationStyle = .overCurrentContext
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        switch pickerChoose {
        case .firstRectangle:
            setImage(ofView: firstRectangleImage, image: selectedImage, withPlusLabel: firstRectanglePlusLabel)
        case .secondRectangle:
            setImage(ofView: secondRectangleImage, image: selectedImage, withPlusLabel: secondRectanglePlusLabel)
        case .firstSquare:
            setImage(ofView: firstSquareImage, image: selectedImage, withPlusLabel: firstSquarePlusLabel)
        case .secondSquare:
            setImage(ofView: secondSquareImage, image: selectedImage, withPlusLabel: secondSquarePlusLabel)
        case .thirdSquare:
            setImage(ofView: thirdSquareImage, image: selectedImage, withPlusLabel: thirdSquarePlusLabel)
        case .fourthSquare:
            setImage(ofView: fourthSquareImage, image: selectedImage, withPlusLabel: fourthSquarePlusLabel)
        }
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func setImage (ofView imageView: UIImageView, image: UIImage, withPlusLabel label: UIButton ) {
        imageView.image = image
        imageView.isHidden = false
        label.isHidden = true
        imageView.isUserInteractionEnabled = true
    }

    //handle the cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
    
    @IBAction func shareGesture(_ sender: Any) {
        if UIDevice.current.orientation.isPortrait {
        let screenHeight = UIScreen.main.bounds.height
        let translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
            handleShare(withAnimation: translationTransform)
        }
    }
    
    @IBAction func shareGestureRight(_ sender: Any) {
        if UIDevice.current.orientation.isLandscape {
            let screenWidth = UIScreen.main.bounds.width
            let translationTransform = CGAffineTransform(translationX: screenWidth, y: 0)
            handleShare(withAnimation: translationTransform)
        }
    }
    
    func handleShare(withAnimation animation: CGAffineTransform) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.myView.transform = animation
            self.swipeLabelView.transform = animation
        })
        
        let shareContent = myView.asImage()
        let activityViewController = UIActivityViewController(activityItems: [shareContent as UIImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            UIView.animate(withDuration: 0.3, animations: {
                self.myView.transform = .identity
                self.swipeLabelView.transform = .identity
            })
            
        }
        present(activityViewController, animated: true, completion: { })

    }
}

