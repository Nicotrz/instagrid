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
    @IBOutlet weak var randomButton: UIButton!
    
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        myView.setPictureView(firstSquareView: firstSquareView, secondSquareView: secondSquareView, thirdSquareView: thirdSquareView, fourthSquareView: fourthSquareView, firstRectangleView: firstRectangleView, secondRectangleView: secondRectangleView, selectedSquareFirst: selectedSquareFirst, selectedSquareSecond: selectedSquareSecond, selectedSquareThird: selectedSquareThird, arrowLabel: arrowLabel, swipeLabel: swipeLabel, randomButton: randomButton)
        
        let swipeRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(shareGestureUp(_:)))
        swipeRecognizerUp.direction = .up
        myView.addGestureRecognizer(swipeRecognizerUp)
        
        let swipeRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(shareGestureLeft(_:)))
        swipeRecognizerLeft.direction = .left
        myView.addGestureRecognizer(swipeRecognizerLeft)
        
        let tapRecognizerFirstRectangle = UITapGestureRecognizer(target: self, action: #selector(addPictureToFirstRectangle(_:)))
        firstRectangleView.addGestureRecognizer(tapRecognizerFirstRectangle)
        
        let tapRecognizerSecondRectangle = UITapGestureRecognizer(target: self, action: #selector(addPictureToSecondRectangle(_:)))
        secondRectangleView.addGestureRecognizer(tapRecognizerSecondRectangle)
        
        let tapRecognizerFirstSquare = UITapGestureRecognizer(target: self, action: #selector(addPictureToFirstSquare(_:)))
        firstSquareView.addGestureRecognizer(tapRecognizerFirstSquare)
        
        let tapRecognizerSecondSquare = UITapGestureRecognizer(target: self, action: #selector(addPictureToSecondSquare(_:)))
        secondSquareView.addGestureRecognizer(tapRecognizerSecondSquare)
        
        let tapRecognizerThirdSquare = UITapGestureRecognizer(target: self, action: #selector(addPictureToThirdSquare(_:)))
        thirdSquareView.addGestureRecognizer(tapRecognizerThirdSquare)
        
        let tapRecognizerFourthSquare = UITapGestureRecognizer(target: self, action: #selector(addPictureToFourthSquare(_:)))
        fourthSquareView.addGestureRecognizer(tapRecognizerFourthSquare)
        
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !checkPermission() {
            warningPermission()
        }
    }
    
    func warningPermission() {
        let alert = UIAlertController(title: "Warning", message: "The app has no access to your photo library. The random feature cannot run! \r\r Please unlock the access on settings to use the feature.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
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
        if checkPermission() {
        self.loadingIndicator.startAnimating()
        UIView.animate(withDuration: 0.50, animations: {
            self.loadingView.alpha = 0.75
            
        }, completion: nil)
        DispatchQueue.global(qos: .background).async {
          let imagesToLoad = self.loadImages()
            DispatchQueue.main.async {
            switch self.modelManager.state {
            case .firstDisplay:
                self.myView.setImage(ofView: self.firstRectangleImage, image: imagesToLoad[0], withPlusLabel: self.firstRectanglePlusLabel)
                self.myView.setImage(ofView: self.thirdSquareImage, image: imagesToLoad[1], withPlusLabel: self.thirdSquarePlusLabel)
                self.myView.setImage(ofView: self.fourthSquareImage, image: imagesToLoad[2], withPlusLabel: self.fourthSquarePlusLabel)
            case .secondDisplay:
                self.myView.setImage(ofView: self.firstSquareImage, image: imagesToLoad[0], withPlusLabel: self.firstSquarePlusLabel)
                self.myView.setImage(ofView: self.secondSquareImage, image: imagesToLoad[1], withPlusLabel: self.secondSquarePlusLabel)
                self.myView.setImage(ofView: self.secondRectangleImage, image: imagesToLoad[2], withPlusLabel: self.secondRectanglePlusLabel)
            case .thirdDisplay:
                self.myView.setImage(ofView: self.firstSquareImage, image: imagesToLoad[0], withPlusLabel: self.firstSquarePlusLabel)
                self.myView.setImage(ofView: self.secondSquareImage, image: imagesToLoad[1], withPlusLabel: self.secondSquarePlusLabel)
                self.myView.setImage(ofView: self.thirdSquareImage, image: imagesToLoad[2], withPlusLabel: self.thirdSquarePlusLabel)
                self.myView.setImage(ofView: self.fourthSquareImage, image: imagesToLoad[3], withPlusLabel: self.fourthSquarePlusLabel)
        }
                self.loadingIndicator.stopAnimating()
                UIView.animate(withDuration: 0.5, animations: {
                    self.loadingView.alpha = 0.0
                }, completion: nil)
            }
        }
        } else {
            warningPermission()
        }
    }

    func checkEquality(firstInt: Int, secondInt: Int, thirdInt: Int, fourthInt: Int ) -> Bool {
        
        if ( firstInt == secondInt || firstInt == thirdInt || firstInt == fourthInt || secondInt == thirdInt || secondInt == fourthInt || thirdInt == fourthInt ) {
            return true
        } else {
            return false
        }
    }
    
    func loadImages() -> [UIImage] {
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
        return result
    }
    
    func checkPermission() -> Bool {
        var status = false
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            status = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    status = true
                }
            })
        case .denied:
            break
        case .restricted:
            break
        }
        return status
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
    
    @objc func shareGestureUp(_ sender: UIGestureRecognizer) {
        shareGesture(sender: sender, direction: .up)
    }
    
    @objc func shareGestureLeft(_ sender: UIGestureRecognizer) {
        shareGesture(sender: sender, direction: .left)
    }
    
    func shareGesture(sender: UIGestureRecognizer, direction: Direction) {
        if ( ( ( UIDevice.current.orientation.isPortrait ) && ( direction == .up ) ) || ( ( UIDevice.current.orientation.isLandscape ) && ( direction == .left ) ) ) {
            handleShare(withDirection: direction)
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
            self.randomButton.transform = transformation
        })
    }
}

