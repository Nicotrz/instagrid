//
//  ViewController.swift
//  Instagrid
//
//  Created by Nicolas Sommereijns on 25/02/2019.
//  Copyright © 2019 Nicolas Sommereijns. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    enum PickerChoose {
        case firstSquare
        case secondSquare
        case thirdSquare
        case fourthSquare
        case firstRectangle
        case secondRectangle
    }
    
    enum Direction {
        case up
        case left
    }
    
    
    var test = [UIImage]()
    
    let modelManager = InstagridModel()
    
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
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.setPictureView(firstSquareView: firstSquareView, secondSquareView: secondSquareView, thirdSquareView: thirdSquareView, fourthSquareView: fourthSquareView, firstRectangleView: firstRectangleView, secondRectangleView: secondRectangleView, selectedSquareFirst: selectedSquareFirst, selectedSquareSecond: selectedSquareSecond, selectedSquareThird: selectedSquareThird, arrowLabel: arrowLabel, swipeLabel: swipeLabel)
        checkPermission()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            myView.arrowDirrection = .left
        } else {
            myView.arrowDirrection = .down
        }
        super.viewWillTransition(to: size, with: coordinator)
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
    
    @IBAction func randomizePictures(_ sender: Any) {
        self.loadingIndicator.startAnimating()
        self.loadingView.isHidden = false
        DispatchQueue.global(qos: .background).async {
          self.loadImages()
            DispatchQueue.main.async {
            switch self.modelManager.state {
            case .firstDisplay:
                self.myView.setImage(ofView: self.firstRectangleImage, image: self.test[0], withPlusLabel: self.firstRectanglePlusLabel)
                self.myView.setImage(ofView: self.thirdSquareImage, image: self.test[1], withPlusLabel: self.thirdSquarePlusLabel)
                self.myView.setImage(ofView: self.fourthSquareImage, image: self.test[2], withPlusLabel: self.fourthSquarePlusLabel)
            case .secondDisplay:
                self.myView.setImage(ofView: self.firstSquareImage, image: self.test[0], withPlusLabel: self.firstSquarePlusLabel)
                self.myView.setImage(ofView: self.secondSquareImage, image: self.test[1], withPlusLabel: self.secondSquarePlusLabel)
                self.myView.setImage(ofView: self.secondRectangleImage, image: self.test[2], withPlusLabel: self.secondRectanglePlusLabel)
            case .thirdDisplay:
                self.myView.setImage(ofView: self.firstSquareImage, image: self.test[0], withPlusLabel: self.firstSquarePlusLabel)
                self.myView.setImage(ofView: self.secondSquareImage, image: self.test[1], withPlusLabel: self.secondSquarePlusLabel)
                self.myView.setImage(ofView: self.thirdSquareImage, image: self.test[2], withPlusLabel: self.thirdSquarePlusLabel)
                self.myView.setImage(ofView: self.fourthSquareImage, image: self.test[3], withPlusLabel: self.fourthSquarePlusLabel)
        }
                self.loadingIndicator.stopAnimating()
                self.loadingView.isHidden = true
            }
        }
    }

    func checkEquality(firstInt: Int, secondInt: Int, thirdInt: Int, fourthInt: Int ) -> Bool {
        
        if ( firstInt == secondInt || firstInt == thirdInt || firstInt == fourthInt || secondInt == thirdInt || secondInt == fourthInt || thirdInt == fourthInt ) {
            return true
        } else {
            return false
        }
    }
    
    func loadImages() {
        var result = [UIImage]()
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                         ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d",
                                             PHAssetMediaType.image.rawValue,
                                             PHAssetMediaType.video.rawValue)
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        var randomPictureOne = 0
        var randomPictureTwo = 0
        var randomPictureThree = 0
        var randomPictureFour = 0
            while self.checkEquality(firstInt: randomPictureOne, secondInt: randomPictureTwo, thirdInt: randomPictureThree, fourthInt: randomPictureFour) {
                let randomRange = 0...allPhotos.count - 1
                randomPictureOne = Int.random(in: randomRange)
                randomPictureTwo = Int.random(in: randomRange)
                randomPictureThree = Int.random(in: randomRange)
                randomPictureFour = Int.random(in: randomRange)
            }
            
            result.append ( self.modelManager.getAssetThumbnail(asset: allPhotos[randomPictureOne]) )
            result.append ( self.modelManager.getAssetThumbnail(asset: allPhotos[randomPictureTwo]) )
            result.append ( self.modelManager.getAssetThumbnail(asset: allPhotos[randomPictureThree]) )
            switch self.modelManager.state {
            case .thirdDisplay:
                result.append ( self.modelManager.getAssetThumbnail(asset: allPhotos[randomPictureFour]) )
            default:
                break
            }
        self.test=result
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
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
            myView.setImage(ofView: firstRectangleImage, image: selectedImage, withPlusLabel: firstRectanglePlusLabel)
        case .secondRectangle:
            myView.setImage(ofView: secondRectangleImage, image: selectedImage, withPlusLabel: secondRectanglePlusLabel)
        case .firstSquare:
            myView.setImage(ofView: firstSquareImage, image: selectedImage, withPlusLabel: firstSquarePlusLabel)
        case .secondSquare:
            myView.setImage(ofView: secondSquareImage, image: selectedImage, withPlusLabel: secondSquarePlusLabel)
        case .thirdSquare:
            myView.setImage(ofView: thirdSquareImage, image: selectedImage, withPlusLabel: thirdSquarePlusLabel)
        case .fourthSquare:
            myView.setImage(ofView: fourthSquareImage, image: selectedImage, withPlusLabel: fourthSquarePlusLabel)
        }
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    //handle the cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchToFirstDisplay(_ sender: Any) {
        myView.switchDisplay(state: .firstDisplay)
        modelManager.state = .firstDisplay
    }
    
    @IBAction func switchToSecondDisplay(_ sender: Any) {
        myView.switchDisplay(state: .secondDisplay)
        modelManager.state = .secondDisplay
    }
    
    @IBAction func switchToThirdDisplay(_ sender: Any) {
        myView.switchDisplay(state: .thirdDisplay)
        modelManager.state = .thirdDisplay
    }
    
    @IBAction func shareGesture(_ sender: Any) {
        if UIDevice.current.orientation.isPortrait {
            handleShare(withDirection: .up)
        }
    }
    
    @IBAction func shareGestureRight(_ sender: Any) {
        if UIDevice.current.orientation.isLandscape {
            handleShare(withDirection: .left)
        }
    }
    
    func handleShare(withDirection direction: Direction) {
        var x: CGFloat
        var y: CGFloat
        switch direction {
        case .up:
            x = 0
            y = -UIScreen.main.bounds.height
        case .left:
            x = -UIScreen.main.bounds.width
            y = 0
        }
        let translationTransform = CGAffineTransform(translationX: x, y: y)
        self.animate(transformation: translationTransform)
        let shareContent = modelManager.asImage(ofView: myView)
        let activityViewController = UIActivityViewController(activityItems: [shareContent as UIImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            self.animate(transformation: .identity )
            self.myView.animateTheArrowWhitoutDirection()
        }
        present(activityViewController, animated: true, completion: { })
    }
    
    func animate(transformation: CGAffineTransform) {
        UIView.animate(withDuration: 0.3, animations: {
            self.myView.transform = transformation
            self.swipeLabelView.transform = transformation
        })
    }
}

