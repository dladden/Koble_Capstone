//
//  FirebaseUser.swift
//  Koble
//
//  Created by Denys Ladden on 4/11/22.
//

import Foundation
import Firebase

//Equitable checks if one user equals to another.
//This is done so we know when a user has returened
//to the app or new user has joined the app.
class FirebaseUser: Equatable{
    
    //comparing two clases two users if they are diffrent
    static func == (lhs: FirebaseUser, rhs: FirebaseUser) -> Bool {
        lhs.objectId == rhs.objectId
        
        
    }//end bool
    
    let objectId: String = ""
    
    class func registerUserWith(userName: String, email: String, dateOfBirth: Date, isFemale: Bool, city: String, password: String, completion: @escaping(_ error: Error?) -> Void){
        //print("register user") <- testing to see if user is registring
    
        print("regiter", Date())
        
        //function provided by firebase
                Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
                    
                    print("finsihed with error ", error)
                    print(Date())
                    completion(error)
                    //if there is no error the signup was sucessful
                  
        
                    
                }//end Auth.auth
        
    }//end registerUserWith
    
    
    
}//end eqyuitable
