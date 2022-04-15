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
                    
                    kLIKEDARRAY as NSCopying,
                    kIMAGELINKS as NSCopying,
                    kPUSHID as NSCopying,
        ])
        
    }//end USER DICTIONARY
    
    //MARK: - Inits
    //this where user will be intialize so that every user can use it
    
    //initializer for user Object (like JAVA CONSTRUCTOR)
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
        //initialized arrays
        likedIdArray = []
        imageLinks = []
        
    }//end initializer
    
    //MARK: - Loggin User
    //this function has a callback for
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVarified: Bool) -> Void ){
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            //checking if there are any errors if error is nill user has been logged in
            if error == nil{
        
                //if email of the user is varified
                if authDataResult!.user.isEmailVerified{
                    //if user is alredy verified find them if not add them to databe
                    
                    //check to see if user is in firebase
                    
                        completion(error, true)
                }else{
                    print("Email not verified")
                    completion(error, false)
                }
                
            }else{
                //if there is error we have error
                completion(error, false)
                
            }
            
            
        }
        
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
                    authData!.user.sendEmailVerification { error in
                            
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
    
    func saveUSerLoc(){
        
        //setting the keys from Contraints calss to the objects of NSDictionary userDic
        userDefault.setValue(self.userDic as! [String : Any], forKey: kCURRENTUSER)
        
        userDefault.synchronize()//saves the user in the userDefault
        
    }//end saveUserLocally
    
    
}//end eqyuitable
