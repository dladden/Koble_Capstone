//
//  FirebaseUser.swift
//  Koble
//
//  Created by Denys Ladden on 4/11/22.
//

import Foundation
import Firebase
import UIKit
import AudioToolbox


//Equitable checks if one user equals to another.
//This is done so we know when a user has returened
//to the app or new user has joined the app.
class FirebaseUser: Equatable{
    
    //comparing two clases two users if they are diffrent
    static func == (lhs: FirebaseUser, rhs: FirebaseUser) -> Bool {
        lhs.objectId == rhs.objectId
        
        
    }//end bool
    
    let registartionDate = Date()//date user registered on the app
    
    let objectId: String//object id is constant for every user
    var username: String
    var email: String
    var dateOfBirth: Date
    var isFemale: Bool
    var city: String
    var profImg: UIImage?//prof image is optional so that it can be modified (defaults to nill)
    var interest: String
    var currentJob: String
    var country: String
    var interestedIn: String//the gender user is looking to connect with
    var profImgLink: String//used to store the link of image in firebase
    var aboutInterest: String
    
    //array to store the already liked profile of the user to eliminate repeats
    var likedIdArray: [String]?
    //array for other images
    var imageLinks: [String]?
    //this will be used to send push notifications to the user
    var pushId: String?
    
    //DICTIONARY to store the user data localy before adding it to database
    //Private so it is accesible only to this class (ORDER IS IMPORTANT)
    private var userDic: NSDictionary{
        return NSDictionary(objects: [
                
                    self.registartionDate,
                
                    self.objectId,
                    self.username,
                    self.email,
                    self.dateOfBirth,
                    self.isFemale,
                    self.city,
                    //self.profImg,
                    self.interest,
                    self.currentJob,
                    self.country,
                    self.interestedIn,
                    self.profImgLink,
                    self.aboutInterest,
                    //arays
                    self.likedIdArray ?? [],
                    self.imageLinks ?? [],
                    self.pushId ?? ""
        ],
                            forKeys: [
                    
                    kCURRENTUSER as NSCopying,
                                
                    kOBJECTID as NSCopying,
                    kUSERNAME as NSCopying,
                    kEMAIL as NSCopying,
                    kDATEOFBIRTH as NSCopying,
                    kISFEMALE as NSCopying,
                    kCITY as NSCopying,
                    kINTEREST as NSCopying,
                    kCURRENTJOB as NSCopying,
                    kCOUNTRY as NSCopying,
                    kINTERESTEDIN as NSCopying,
                    kPROFILEIMGLINK as NSCopying,
                    kABOUTINTEREST as NSCopying,
                    
                    kLIKEDARRAY as NSCopying,
                    kIMAGELINKS as NSCopying,
                    kPUSHID as NSCopying,
        ])
        
    }//end USER DICTIONARY
    
    //MARK: - Inits
    //this where user will be intialize so that every user can use it
    
    //INITIALIZER for user Object (like JAVA CONSTRUCTOR)
    init(_objectId: String, _username: String, _email: String, _city: String, _dateOfBirth: Date, _isFemale: Bool, _profImgLink: String = ""){
        
        //setting initalization
        //self.objectId = objectId
        objectId = _objectId
        username = _username
        email = _email
        profImgLink = _profImgLink
        city = _city
        country = ""
        isFemale = _isFemale
        dateOfBirth = _dateOfBirth
        interest = ""
        currentJob = ""
        interestedIn = ""
        aboutInterest = ""
        //initialized arrays
        likedIdArray = []
        imageLinks = []
        
    }//end initializer
    
    //INITIALIZER for FirebaseListener when user is downloaded from firebase we should
    //have access to all values
    init(_dictionary: NSDictionary){
        //DICTIONARY UNWRAPING
        //passing the key thorugh dictionary force unwrapped to String OPTIONAL (?)
        //and if it is not a string (??) then assign a String ("")
        objectId = _dictionary[kOBJECTID] as? String ?? ""
        username = _dictionary[kUSERNAME] as? String ?? ""
        email = _dictionary[kEMAIL] as? String ?? ""
        profImgLink = _dictionary[kPROFILEIMGLINK] as? String ?? ""
        city = _dictionary[kCITY] as? String ?? ""
        country = _dictionary[kCOUNTRY] as? String ?? ""
        isFemale = _dictionary[kISFEMALE] as? Bool ?? true
        interest = _dictionary[kINTEREST] as? String ?? ""
        currentJob = _dictionary[kCURRENTJOB] as? String ?? ""
        interestedIn = _dictionary[kINTERESTEDIN] as? String ?? ""
        aboutInterest = _dictionary[kABOUTINTEREST] as? String ?? ""
        //initialized arrays
        likedIdArray = _dictionary[kINTERESTEDIN] as? [String]
        imageLinks = _dictionary[kINTERESTEDIN] as? [String]
        
        if let date = _dictionary[kDATEOFBIRTH] as? Timestamp {
            //dateValue is a Firebase fucntion which creates a date object from time stamp
            dateOfBirth = date.dateValue()
        }else{
            dateOfBirth = _dictionary[kDATEOFBIRTH] as? Date ?? Date()
        }
        
        /*
         This section acesses the function in FileStorage which creates a file direcory
         where the image is stored locally, if however there is no image it proveds the placeholder image
         */
        let placeholder = "profile_placeholder"
        profImg = UIImage(contentsOfFile: fileDirectoryAccess(filename: self.objectId)) ?? UIImage(named: placeholder)
        
        
    }//end initializer
    
    //MARK: - Returning User Info to Profile
    //getting the user object for the logged in portion
    class func currentId() -> String{
        //returns current ID of the user which is currently logged in
        return Auth.auth().currentUser!.uid
    }//end return current user
    
    class func currentUser() -> FirebaseUser? {
        //checking to see if there is a current user
        if Auth.auth().currentUser != nil{
            //if not nil check to see if there is user in the userDefault in Constants file
            if let userDic = userDefault.object(forKey: kCURRENTUSER){
                //if there is something there return userDic witht he data
                return FirebaseUser(_dictionary: userDic as! NSDictionary)
                
            }
        }
        return nil//return nil with there is no user
    }
    
    //MARK: - Saving Images
    //This function accesses the downloadImage function and downloads in an image and sets avatar image
    //didSet return bool for success true or false
    func getProfImgFromFirebase(completion: @escaping (_ didSet: Bool) -> Void){
        //profImg is an OPTIONAL
        FilesStorage.downloadImage(imageUrl: self.profImgLink) { (imageProfile) in
            let placeholder = "profile_placeholder"
            //if imageProfile is nil return placeholder
            self.profImg = imageProfile ?? UIImage(named: placeholder)
            //profile image is set
            completion(true)
        }
        
    }
    
    
    //MARK: - Loggin User
    //this function has a callback for
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVarified: Bool) -> Void ){
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            //checking if there are any errors if error is nill user has been logged in
            if error == nil{
        
                //if email of the user is varified
                if authDataResult!.user.isEmailVerified{
                    //if user is alredy verified find them if not add them to databe
                    
        //check to see if user is in firebase---------------------------
                    //singelton instace of the listener
                    FirebaseListener.shared.downloadCurrentUserFirebase(userId: authDataResult!.user.uid, email: email)
                    
                        completion(error, true)
                }else{
                    print("Email not verified")
                    completion(error, false)
                }
                
            }else{
                //if there is error we have error
                completion(error, false)
                
            }
            
            
        }//end auth
        
        
        
    }//end function loginUserWith
    
    
    
    //MARK: - Register Section
    
    class func registerUserWith(userName: String, email: String, dateOfBirth: Date, isFemale: Bool, city: String, password: String, completion: @escaping(_ error: Error?) -> Void){
        //print("register user") <- testing to see if user is registring
    
        //print("regiter", Date())
        
        //function provided by firebase
                Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
                    
                    //print("finished with error ", error)
                    //print(Date())
                    completion(error)
                    //if there is no error the signup was successful
                  
                    if error == nil{
                                          
                    //this is a authentication provide by Firebase
                    //user object is provided by Firebase to send a
                    //verification email
                    authData!.user.sendEmailVerification { (error) in
                            
                        print("auth email verification sent ", error?.localizedDescription)
                            //localized description describes the error
                        }//end authDaata for user vrification email
                        
                        //Here we create a USER OBJECT and acess it witht he firebase UID in the Athentication section of the Console
                        if authData?.user != nil{
                            
                            let user = FirebaseUser(_objectId: authData!.user.uid, _username: userName, _email: email, _city: city, _dateOfBirth: dateOfBirth, _isFemale: isFemale)
                            
                                                //Saving user object localy and in firebae
                            /*We want to placehold the athenticating email for the user just incase its an email
                             they do not use or do not have access to. This is done mainly so that Firebase database
                             is not full of lost emails which were never used to signup to the application
                             
                             To bipass this we will save the
                             */
                            
                            user.saveUSerLoc()
                            
                        }//end authData for user object
                        
                                          
                    }//end if
                    
                    
                }//end Auth.auth
        
    }//end function registerUserWith
    
    //MARK: - Edit User Email
    //This fucntion gets new email and if error throw error
    func updateUserEmail(newEmail: String, completion: @escaping (_ error: Error?) -> Void){
        
        Auth.auth().currentUser?.updateEmail(to: newEmail, completion: { (error) in
            //resetting email
            FirebaseUser.resendVerificationEmail(email: newEmail) { (error) in
                
            }

            completion(error)
        })
        
    }//end updateUserEmail
    
    
    
    
    //MARK: - SENDING LINKS (passord reset)
    //function which takes an email (has a complecion handler for error)
    
    class func resendVerificationEmail(email: String, completion: @escaping (_ error: Error?) -> Void){
        //current user is a Firebase current use which is currently logged in is provided
        //by firebase. reload checks if it exist
        Auth.auth().currentUser?.reload(completion: { (error) in
            //if it does verification email sent to that user
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                //notify complicion in
                completion(error)
                
            })//end email sent
            
        })
        
    }//end resetPasswordFor function
    
    class func resetPasswordFor(email: String, completion: @escaping (_ error: Error?) -> Void){
    
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completion(error)
        }
        
    }//end resetPasswordFor
    
    //MARK: - Logout
    //log out for current user (may 1)
    class func logOutCurrentUser(completion: @escaping(_ error: Error?) -> Void){
        //sign in error could be presented as trows this sign out portion is wrapped
        //to catch the error
        do {
            try Auth.auth().signOut()
            userDefault.removeObject(forKey: kCURRENTUSER)
            userDefault.synchronize()
            //if all goes well provide no error nil
            completion(nil)
        }catch let error as NSError{
            completion(error)
        }
        
        
    }//end LOGOUT
    
    
    
    
    //MARK: - Save User
    
    func saveUSerLoc(){
        
        //setting the keys from Contraints calss to the objects of NSDictionary userDic
        userDefault.setValue(self.userDic as! [String : Any], forKey: kCURRENTUSER)
        
        userDefault.synchronize()//saves the user in the userDefault
        
    }//end saveUserLocally
    
    //saves user to the firestore and used by the downloadCurrentUserFirebase in FirebaseListener class 
    func saveUserToFirestore(){
        //seting document name as self objectId with error debuging view in case things go wrong
        FirebaseReference(.User).document(self.objectId).setData(self.userDic as! [String : Any]){(error) in
            //if there is an error (if not nil there is an error) show it
            if error != nil{
                print(error!.localizedDescription)
            }//end if
            
        }//end FirebaseReference
        
        
        
    }//end saveUserToFirestore
    
}//end eqyuitable



//temporary function
func createUsers(){
    
    let name = ["Chopin", "Ros", "Win", "Arnoldi", "Keanu", "Linus", "Margot01", "Emil", "Samo", "Snookie"]
    
    var imageIndex = 1
    
    var userIndex = 1
    
    var isFemale = true
    
    for i in 0..<9{
        
        let id = UUID().uuidString
        let fileDirectory  = "profile_images/_" + id + ".jpg"
        
        FilesStorage.uploadImage(UIImage(named: "user\(imageIndex)")!, directory: fileDirectory) { (profImgLink) in
            
            let user = FirebaseUser(_objectId: id, _username: name[i], _email: "user\(userIndex)@mail.com", _city: "Louisville", _dateOfBirth: Date(), _isFemale: isFemale, _profImgLink: profImgLink ?? "")
            
            isFemale.toggle()
            userIndex += 1
            user.saveUserToFirestore()
            
        }//end file storage
        
        imageIndex += 1
        if imageIndex == 9{
            imageIndex = 1//assinging one after images runout
        }
            
        
    }//END FOR LOOP
    
}


