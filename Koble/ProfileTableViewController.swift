//
//  ProfileTableViewController.swift
//  Koble
//
//  Created by Denys Ladden on 4/18/22.
//

import UIKit
import Gallery//the gallery imported with pods https://github.com/hyperoslo/Gallery
import ProgressHUD

class ProfileTableViewController: UITableViewController {

    //MARK: - IBOitlets
    
    //All of the labels and text fields
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameAgeLabel: UILabel!
    @IBOutlet weak var interestTextField: UITextField!//SHOWN ON YOUR PROFILE
    @IBOutlet weak var addInterestTextField: UITextField!//USER ADDS THIS
    @IBOutlet weak var aboutInterestTextField: UITextView!//BIO BUT FOR INTEREST
    @IBOutlet weak var birthDayTextField: UITextField!//BIBRTHDAY NEEDS TO (AUTO UPDATE)
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var interestedInTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var workTextField: UITextField!
    
    //this all the darn views...
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    
    //MARK: - Vars
    //variable to prevent edditing for eddit button
    var edittingMode = false
    //variable used to check if user changed profile image
    var imageProfile: UIImage?//optional since if it is not UI image it will change to imageProfile
    //variable for uploading image for PROFILE specifically
    var uploadProfImage = true
    
    
    //Global Variable: GalleryController is the main entry point, just instantiate and give it the delegate
    //github.com/hyperoslo/Gallery
    var mediaGallery: GalleryController!//forece unwrap so that we intiliaze it
    
   

  
    
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //overwritng dark mode so app is only light mode
        overrideUserInterfaceStyle = .light
        //setting up certain styling constraints
        setupBackground()
        
        if FirebaseUser.currentUser() != nil{
            //function which will load curent user data
            loadUserInfo()
            
            //edit mode set to false, user cant eddit fields until he clicks EDIT
            updateEdditnMode()
            
        }//end load current user
        
        
       
        
    }//end viewDidLoad()
    
    //getting rid of the selection headers
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //getting rid of the selection Footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    
    
    //MARK: - IBActions
    
    
    @IBAction func mediaButtonPressed(_ sender: Any) {
        ProgressHUD.show("take a selfie 🤳", icon: .heart)
        showMediaOptions()
        
    }
    //edit button and its fuunctionalities
    @IBAction func editButtonPressed(_ sender: Any) {
        
        
        edittingMode.toggle()//switch which on pressed will switch value to true
        updateEdditnMode()
        //if editmode func show keyboard else hide it
        edittingMode ? showKeyboard() : hideKeyboard()
        showSaveBUtton()
        
    }//end editButtonPressed
    
    
    //saves the data of the user. Function to EDIT USER DATA!!
    @objc func editUserData(){
        //accesing the current FirebaseUser to upload the data
        let user = FirebaseUser.currentUser()!
        //inputs are stored to the user or inputed as a string in some cases
        interestTextField.text = user.interest
        user.interest = addInterestTextField.text ?? ""
        //updating the about interest if EMPTY
        user.aboutInterest = aboutInterestTextField.text
        user.currentJob = workTextField.text ?? ""
        user.isFemale = genderTextField.text == "female"//if not female the false
        user.interestedIn = interestedInTextField.text ?? ""
        user.city = cityTextField.text ?? ""
        user.country = countryTextField.text ?? ""
        user.currentJob = workTextField.text ?? ""
        
        
        //Making sure that the user image is only uploaded if it was changed
        //Firebase services are constly and we dont want to upload image file everytime
        //if not nil user changed the user image
        if imageProfile != nil{
            //TODO: - Upload new user image then save user
            //print("Image is selected and save pressed")
            //UPLOAD profImg and UPLOAD multiple Interest images
            
            //force enrwap since we check if it is nill above and forece cmopletion
            //checks for the link
            uploadProfImg(imageProfile!) {(profImgLink)in
                //link is added to the profImgLink variable beloning to user
                //a default value of "" is given since it is an optional
                user.profImgLink = profImgLink ?? ""
                //
                user.profImg = self.imageProfile
                //call self since it is not in scope of saveUSerData
                self.saveUSerData(user: user)
                self.loadUserInfo()//ensures that user info updated
            }
            
        }else{
            //save
            saveUSerData(user: user)
            loadUserInfo()
            
        }//end if for Profile image
        
        //ending / disabeling edditing and resets save button
        edittingMode = false//disableing editing mode
        updateEdditnMode()//disabling all fields
        showSaveBUtton()//button disapears bc editing mode is now set to false
       
        
        
    }//end editUser Data Objective-c
        
    
    
    
    
        //passing FirebaseUser takes a user and saves it (get the user
        private func saveUSerData(user: FirebaseUser){
            //calling functions in FirebaseUser
            user.saveUSerLoc()
            user.saveUserToFirestore()
        
        }//end saveUSER DATA
        
   
    @IBAction func settingsButtonPressed(_ sender: Any) {
        
        showEdditOptions()
        
    }
    
    //MARK: - Setup
    
    private func setupBackground(){
        
        profilePicture.layer.cornerRadius = 26
        
        view1.layer.cornerRadius = 12
        view2.layer.cornerRadius = 12
        view3.layer.cornerRadius = 12
        view3.layer.shadowColor = UIColor.gray.cgColor
        view3.layer.shadowOpacity = 1
        view3.layer.shadowOffset = .zero
        view3.layer.shadowRadius = 5
        
        view4.layer.cornerRadius = 12
        view4.layer.shadowColor = UIColor.gray.cgColor
        view4.layer.shadowOpacity = 1
        view4.layer.shadowOffset = .zero
        view4.layer.shadowRadius = 5
        
        view5.layer.cornerRadius = 12
        view5.layer.shadowColor = UIColor.gray.cgColor
        view5.layer.shadowOpacity = 1
        view5.layer.shadowOffset = .zero
        view5.layer.shadowRadius = 5
        
        view6.layer.cornerRadius = 12
        view7.layer.cornerRadius = 12
        view8.layer.cornerRadius = 10
        
    }//end func setupBackground
    
    //this function creates a save button only when user presses the edit button
    private func showSaveBUtton(){
        //ui button with ttarget and tyoe action is the function which triggers the use of this button
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editUserData))
        //putting the button in the nav bar (if editing mode then saveButton else change it to nil
        navigationItem.rightBarButtonItem = edittingMode ? saveButton : nil
        
        saveButton.tintColor = UIColor.gray
        
        
    }
    
    //MARK: - Loading user data
    
    //USER DATA UPDATE FOR RETURNING USER
    private func loadUserInfo(){
        //getting current user and storing it in current user
        let currentUser = FirebaseUser.currentUser()!
        //accesing the
        FilesStorage.downloadImage(imageUrl: currentUser.profImgLink){
            (image) in 
        }
        
        
        //PROFILE IMAGE AND NAME + AGE
        profilePicture.image = UIImage(named: "profile_placeholder")
        nameAgeLabel.text = currentUser.username + ", \(abs(currentUser.dateOfBirth.interval(ofComponent: .year, fromDate: Date())))"
        
        //USER NO EDIT
        interestTextField.text = currentUser.interest != "" ? currentUser.interest : "#YOURINTEREST"
        //USER EDIT
        addInterestTextField.text = currentUser.interest
        //USER EDIT MORE INFO
        aboutInterestTextField.text = currentUser.aboutInterest != "" ? currentUser.aboutInterest : "about your interests..."
        //birthdayLabel
        genderTextField.text = currentUser.isFemale ? "female" : "male"
        interestedInTextField.text = currentUser.interestedIn
        cityTextField.text = currentUser.city
        countryTextField.text = currentUser.country
        workTextField.text = currentUser.currentJob
        
        //TODO: set user image in the app after upload
        //storing the porfImg in the view image
        profilePicture.image = currentUser.profImg
        
        
    }//end uploading current user info
    
    
    
    
    //MARK: - EdditingMode
    
    private func updateEdditnMode(){
        
    //profilePicture.isUserInteractionEnabled = edittingMode
    nameAgeLabel.isUserInteractionEnabled = edittingMode
    interestTextField.isUserInteractionEnabled = false
    addInterestTextField.isUserInteractionEnabled = edittingMode
    aboutInterestTextField.isUserInteractionEnabled = edittingMode
    //birthdayLabel.isUserInteractionEnabled = edittingMode
    genderTextField.isUserInteractionEnabled = edittingMode
    interestedInTextField.isUserInteractionEnabled = edittingMode
    cityTextField.isUserInteractionEnabled = edittingMode
    countryTextField.isUserInteractionEnabled = edittingMode
    workTextField.isUserInteractionEnabled = edittingMode
        
        
    }//end edditn mode
    
    //MARK: - Hellpers
    
    private func showKeyboard(){
        self.addInterestTextField.becomeFirstResponder()
    }//func to SHOW keyboard
    
    private func hideKeyboard(){
        self.view.endEditing(false)
    }//func to HIDE keyboard
    
    //MARK: - Storage Work for FileStorage
    //Upload Image Profile Uploads the profImg and then provides the link to that image
    private func uploadProfImg(_ image: UIImage, completion: @escaping (_ profImgLink: String?)-> Void){
        
        ProgressHUD.show()
        //adressing (creting) directory profile_images and stroing the image as the UID
        let fileDirectory = "profile_images/_"+FirebaseUser.currentId()+".jpg"
        //accessing the upload function completion returns PROFILE LINK
        FilesStorage.uploadImage(image, directory: fileDirectory) { (profImgLink) in
            //dismiss the spinner after image is uploaded
            ProgressHUD.dismiss()
            //TODO: - First save file locally this will beggin the download when app is opened instead of when images bulled up
            //SAVING file locally user file directory
            FilesStorage.saveImageLocally(imageData: image.jpegData(compressionQuality: 0.8)! as NSData, fileName: FirebaseUser.currentId())
            
            //passing the profImgLink to the completion in uploadProfImg asan
            completion(profImgLink)
            
        }
        
    }//end upload profile image
    
    //used for uploading multiple images for user
    private func uploadImages(images: [UIImage?]){
        
        ProgressHUD.show()//showiing progress to the user
        
        //TODO: - Upload Images Function (for the array):
        
        
    }//end uploadImages
    
    
    //MARK: - Media Gallery
    //accessing the galery which
    private func useGalleryProf(forProfImg: Bool){
        //setting fprofile image to methods passing
        uploadProfImage = forProfImg
        //intilizing gallery
        self.mediaGallery = GalleryController()
        //delegate view set as the gallery object HERE
        self.mediaGallery.delegate = self
        //this sets the provided tabs of the gallery to be only image and camera omminting the video
        Config.tabsToShow = [.imageTab, .cameraTab]//.imageTab is omited
        //limit of 6 pics
        //Config.Camera.imageLimit = forProfImg ? 1 : 6
        //initial tab is the camera tab bc we want to encorage user to take a selfie
        Config.initialTab = .cameraTab
        
        self.present(mediaGallery, animated: true, completion: nil)
        
    }//end useGallery
    
    private func useGalleryInterest(forProfImg: Bool){
        //setting fprofile image to methods passing
        uploadProfImage = forProfImg
        //intilizing gallery
        self.mediaGallery = GalleryController()
        //delegate view set as the gallery object HERE
        self.mediaGallery.delegate = self
        //this sets the provided tabs of the gallery to be only image and camera omminting the video
        Config.tabsToShow = [.imageTab, .cameraTab]
        //limit of 6 pics
        Config.Camera.imageLimit = forProfImg ? 1 : 6
        //initial tab is the camera tab bc we want to encorage user to take a selfie
        Config.initialTab = .cameraTab
        
        self.present(mediaGallery, animated: true, completion: nil)
        
    }//end useGallery
    
    
    
    
    
    
    //MARK: - Alert Controller
    //MEDIA BUTTON this is function for the media button adding upload enterance for the images
    private func showMediaOptions(){
        
        let alertCotroller = UIAlertController(title: "add pictures", message: "add a selfie & photos of your interests", preferredStyle: .actionSheet)
        //first button
        alertCotroller.addAction(UIAlertAction(title: "add a picture of yourself", style: .default, handler: { (alert) in
            //print("bring up media gallery for PROFILE IMAGE")
            self.useGalleryProf(forProfImg: true)
            
        }))
        //pictures of your interest
        alertCotroller.addAction(UIAlertAction(title: "add a pictures for your interests", style: .default, handler: { (alert) in
            //print("bring up media gallery for INTEREST IMAGES")
            self.useGalleryInterest(forProfImg: false)
            
        }))
        //canel portion
        alertCotroller.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil
        ))
        
        self.present(alertCotroller, animated: true, completion: nil)
        
    }
    
    //SETTINGS BUTTON
    private func showEdditOptions(){
        
        let alertCotroller = UIAlertController(title: "edit account", message: "manage your accunt here", preferredStyle: .actionSheet)
        //first button
        alertCotroller.addAction(UIAlertAction(title: "change email", style: .default, handler: { (alert) in
            print("hello")
        }))
        //pictures of your interest
        alertCotroller.addAction(UIAlertAction(title: "profile name", style: .default, handler: { (alert) in
            print("hello ooo")
        }))
        //pictures of your interest
        alertCotroller.addAction(UIAlertAction(title: "username", style: .default, handler: { (alert) in
            print("hello ooo")
        }))
        //pictures of your interest
        alertCotroller.addAction(UIAlertAction(title: "logout", style: .destructive, handler: { (alert) in
            print("hello ooo")
        }))
        //canel portion
        alertCotroller.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil
        ))
        
        self.present(alertCotroller, animated: true, completion: nil)
        
    }
    
    
    
}//end class ProfileTableViewController



/******
 This is an Extension of the Profile Controller for the Dellegate
 */
extension ProfileTableViewController: GalleryControllerDelegate{
    
    //uses an image object [image]
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        //if image count is grater then zero user has selceted one
        if images.count > 0{
            //in case of specifically uploading profile image:
            if uploadProfImage{
                //get first image change to UI image
                images.first!.resolve { (icon) in
                    //UIimage is an optional, checking if it is NOT nil if yes
                    if icon != nil{
                        self.edittingMode = true//start eddting mode to show save button
                        self.showSaveBUtton()//
                        //set the actual image view to icon
                        self.profilePicture.image = icon
                        //setgloba variable to icon
                        self.imageProfile = icon
                    }else{
                        ProgressHUD.showError("no image selected")
                    }
                }//end images.first!.resolve
                
            }else{
                //print("multiple images were selected")
                //this sesction is for when user selects multiple images
                Image.resolve(images: images) { (resolvedImages) in
                    
                    self.uploadImages(images: resolvedImages)
                    
                    
                }//end images resolve
                
            }
            
        }
        
        //dismmis the galerry if none selceted
        controller.dismiss(animated: true, completion: nil)
        
    }//end IMAGE galleryController
    
    //NOT utilized
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    //NOT utilized
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    //NOT utilized
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
}
