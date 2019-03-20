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


    // Enumeration of the differents view available on the PictureView
    enum PickerChoose {
        case firstSquare
        case secondSquare
        case thirdSquare
        case fourthSquare
        case firstRectangle
        case secondRectangle
    }
    
    // Enumeration of the different direction where we can send the PictureView when it is shared
    enum Direction {
        case up
        case left
    }

    // Enumeration for the direction of the animated arrow
    enum ArrowDirrection
    {
        case down
        case left
    }

    // Just to initialize the pickerChoose on a default value
    var pickerChoose: PickerChoose = .firstSquare
    
    // Set the differents IBOutlets
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

    
    
    // We add some instructions to the viewDidLoad
    override func viewDidLoad() {
        // We check if we have the clearance to load the photo library
        if checkPermission() {
            print("Ok we have the clearance")
        }

        // Setting the picture view with the IBOutlets
        myView.setPictureView(firstSquareView: firstSquareView, secondSquareView: secondSquareView, thirdSquareView: thirdSquareView, fourthSquareView: fourthSquareView, firstRectangleView: firstRectangleView, secondRectangleView: secondRectangleView, selectedSquareFirst: selectedSquareFirst, selectedSquareSecond: selectedSquareSecond, selectedSquareThird: selectedSquareThird )
        
        // Setting a gestureRecognizer for the share gesture ( up direction )
        let swipeRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(shareGestureUp(_:)))
        swipeRecognizerUp.direction = .up
        myView.addGestureRecognizer(swipeRecognizerUp)
        
        // Setting a gestureRecognizer for the share gesture ( left direction )
        let swipeRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(shareGestureLeft(_:)))
        swipeRecognizerLeft.direction = .left
        myView.addGestureRecognizer(swipeRecognizerLeft)
        
        // Setting tap recognizers for all of the subviews of the pictureView
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
        
        // now we let the viewDidLoad continue normally
        super.viewDidLoad()

    }
    
    // We add some instructions to the viewWillTransition ( the device changed orientation )
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // If the device is now landscape, we change the text and arrow to left, else we set it to down
        if UIDevice.current.orientation.isLandscape {
            arrowDirrection = .left
        } else {
            arrowDirrection = .down
        }
        // now we let the viewWillTransition continue normally
        super.viewWillTransition(to: size, with: coordinator)
    }

    // This function display a popup warning message with the message sended on argument
    func warning(withMessage message: String) {
        // setting the Alert with a warning title and the message sended on argument
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)

        // The only possible action is OK ( warning message only)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert
        self.present(alert, animated: true)
    }
    
    

    // Theses IBAction are called when the plus button is tapped OR with the differents UITapRecognizers. We call a picker with the concerned subview send on argument
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
    
    // This function is called when the random button is pressed
    @IBAction func randomizePictures(_ sender: Any) {
        // We can only do stuff if we have permission to access the photo album
        if checkPermission() {
            // We have the permission, we start by showing that the pictures are loading ( it can take a while because the pictures can be on iCloud ), so we show an activityIndicator and we display a gray loadingView who will be above everything else ( with animation, it's prettier :-) )
            self.loadingIndicator.startAnimating()
            UIView.animate(withDuration: 0.50, animations: {
                self.loadingView.alpha = 0.75
            }, completion: nil)
            // We need to use multithreading because if we don't, the loading interface won't show. We execute the loading query on background
            DispatchQueue.global(qos: .background).async {
                // Load the pictures
                let imagesToLoad = self.loadImages()
                // The pictures are loaded on a array, we can proceed to main thread
                DispatchQueue.main.async {
                    // If we didn't succeed to load at least 3 images, that means that the user don't have enought pictures on his library. We can't continue
                    if ( imagesToLoad.count < 3  ) {
                        // Showing a warning
                        self.warning(withMessage: "You need minimum 4 pictures on your library to use this feature")
                    } else {
                        // The user as enought picture. We can proceed. We set the images by watching the disposal of the screen
                        switch InstagridModel.state {
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
                    }
                    // Everything is over. We can stop the loading animation
                    self.loadingIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.5, animations: {
                        self.loadingView.alpha = 0.0
                    }, completion: nil)
                }
                }
            } else {
            // We didn't succeed to access the photo library because we don't have the clearence. We display a warning for the user
                warning(withMessage: "The app has no access to your photo library. The random feature cannot run! \r\r Please unlock the access on settings to use the feature.")
            }
        }

    // This little function will check an equality between all of the Int sended on argument. If one of the int is equal to another, it will send true, else it will send false
    func checkEquality(firstInt: Int, secondInt: Int, thirdInt: Int, fourthInt: Int ) -> Bool {
        return ( firstInt == secondInt || firstInt == thirdInt || firstInt == fourthInt || secondInt == thirdInt || secondInt == fourthInt || thirdInt == fourthInt )
    }
    
    // This function will load an array of random pictures from the photo library
    func loadImages() -> [UIImage] {
        // Init the result
        var result = [UIImage]()
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                         ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d",
                                             PHAssetMediaType.image.rawValue)
        //Go fetching the pictures with fetchOptions. Return an array of assets
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        // If we fetch less than 4 pictures, we stop here
        if allPhotos.count < 4 {
            return result
        }
        
        // Setting randomPictures number
        var randomPictureOne = 0
        var randomPictureTwo = 0
        var randomPictureThree = 0
        var randomPictureFour = 0
        

        // While at least one of the 4 number is equal to another, we catch 4 other random number in the range of pictures
            while self.checkEquality(firstInt: randomPictureOne, secondInt: randomPictureTwo, thirdInt: randomPictureThree, fourthInt: randomPictureFour) {
                let randomRange = 0...allPhotos.count - 1
                randomPictureOne = Int.random(in: randomRange)
                randomPictureTwo = Int.random(in: randomRange)
                randomPictureThree = Int.random(in: randomRange)
                randomPictureFour = Int.random(in: randomRange)
            }
            // We go catch the third first pictures based on random numbers
            result.append ( InstagridModel.getAssetThumbnail(asset: allPhotos[randomPictureOne]) )
            result.append ( InstagridModel.getAssetThumbnail(asset: allPhotos[randomPictureTwo]) )
            result.append ( InstagridModel.getAssetThumbnail(asset: allPhotos[randomPictureThree]) )
            // We don't need to use ressources for nothing. So we load the fourth one only if there is 4 pictures to load ( thirdDisplay )
            switch InstagridModel.state {
            case .thirdDisplay:
                result.append ( InstagridModel.getAssetThumbnail(asset: allPhotos[randomPictureFour]) )
            default:
                break
            }
        // Result ready to be returned
        return result
    }
    
    // This function check the permission to access the photo library
    func checkPermission() -> Bool {
        // By default, we consider we don't have it
        var status = false
        // We go catch the current status
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            // We do have the autorisation. Everything is good!
            status = true
        case .notDetermined:
            // The user didn't gave the autorisation yet. So we go ask him
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    // the user gave us his blessing
                    status = true
                }
            })
        case .denied:
            // The user denied..
            break
        case .restricted:
            // The user denied..
            break
        }
        // Value ready to be returned
        return status
    }

    // This function is for calling the pickerController. The argument is for telling us in what view the image will be loaded
    func callPicker(withPicker picker: PickerChoose) {
        // Setting the property pickerChoose
        pickerChoose = picker
        // Creating a new controller
        let picker = UIImagePickerController()
        // The user can edit the picture before validate it
        picker.allowsEditing = true
        // The picker is delegate to the main view
        picker.delegate = self
        // picker showed in full screen
        picker.modalPresentationStyle = .overCurrentContext
        // Picker ready to be presented
        present(picker, animated: true)
    }
    
    // Function called when the picker is closed
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original. But we need to unwrapped it first
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
    
    // Change the disposal of the grid between one of the three available
    @IBAction func switchToFirstDisplay(_ sender: Any) {
        myView.switchDisplay(state: .firstDisplay)
        InstagridModel.state = .firstDisplay
    }
    
    @IBAction func switchToSecondDisplay(_ sender: Any) {
        myView.switchDisplay(state: .secondDisplay)
        InstagridModel.state = .secondDisplay
    }
    
    @IBAction func switchToThirdDisplay(_ sender: Any) {
        myView.switchDisplay(state: .thirdDisplay)
        InstagridModel.state = .thirdDisplay
    }
    
    // Handle the share gesture up only if the device is in portrait mode
    @objc func shareGestureUp(_ sender: UIGestureRecognizer) {
        if ( UIApplication.shared.statusBarOrientation.isPortrait ) {
        handleShare(withDirection: .up)
        }
    }
    
    // Handle the share gesture left only if the device is in landscape mode
    @objc func shareGestureLeft(_ sender: UIGestureRecognizer) {
        if ( UIApplication.shared.statusBarOrientation.isLandscape ) {
            handleShare(withDirection: .left )
        }
    }
    
    // Here is where we handle the share itself in Direction ( to animate it )
    func handleShare(withDirection direction: Direction) {
        var x: CGFloat
        var y: CGFloat
        // Setting x and y to match the share gesture ( up or left )
        switch direction {
        case .up:
            x = 0
            y = -UIScreen.main.bounds.height
        case .left:
            x = -UIScreen.main.bounds.width
            y = 0
        }
        // We animate the transformation
        self.animate(transformation: CGAffineTransform(translationX: x, y: y))
        
        // We transform the view into an image
        let shareContent = InstagridModel.asImage(ofView: myView)
        
        // The activityViewController is used to handle the shareContent as UIImage
        let activityViewController = UIActivityViewController(activityItems: [shareContent as UIImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            // When the share is over, we can animate the objects back to their original places and start to animate the arrow again ( when we moved it, it automatically cut the animation )
            self.animate(transformation: .identity )
            self.animateTheArrowWhitoutDirection()
        }
        // The activityViewController is ready to be presented
        present(activityViewController, animated: true, completion: { })
    }
    
    // This function is used to animate the view, the swipe label and the random button with the transformation sended on argument
    func animate(transformation: CGAffineTransform) {
        UIView.animate(withDuration: 0.3, animations: {
            self.myView.transform = transformation
            self.swipeLabelView.transform = transformation
            self.randomButton.transform = transformation
        })
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
    
    // This function is called to animate the arrow only whitout knowing the direction
    func animateTheArrowWhitoutDirection() {
        // If the device is portrait oriented, we animate it on the down direction
        if UIApplication.shared.statusBarOrientation.isPortrait {
            animateTheArrow(arrowDirrection: .down)
        } else {
            // If the device is landscape oriented, we animate it on the left direction
            animateTheArrow(arrowDirrection: .left)
        }
    }
}

