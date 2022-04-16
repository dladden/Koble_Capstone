//
//  FIrebaseListener.swift
//  Koble
//
//  Created by Denys Ladden on 4/15/22.
//

import Foundation
import Firebase
/*
 Firebase Listener will fetch / save / update data to Firebase
 */
class FirebaseListener{
    //Creating a Singleton Class: only one instance of a FirebaseListener class is instantiated (accesed by calling shared)
    static let shared = FirebaseListener()
    //initializes shared
    private init(){}
    
    
    //MARK: - FirebaseUser
    //Checking if user with specific ID exists in database if it exists we need to
    //download it and store it localy
    func downloadCurrentUserFirebase(userId: String, email: String){
        //document from firebase: snapshot
        FirebaseReference(.User).document(userId).getDocument { snapshot, error in
            //chacking if snapshot is available else stop
            guard let snapshot = snapshot else { return }
            //if document exists
            if snapshot.exists{
                //user exist and been logged in (there is user alredy created)
                //instatntiating user which passes the snapshot data to the _Dictionary
                let user = FirebaseUser(_dictionary: snapshot.data() as! NSDictionary)
                
                //grabing the lastest version of the user so that when a user returns they have latest indormation
                //function that saves user localy
                user.saveUSerLoc()
                
            }else{
                //user doesnt exist this will be first login
                //Check if the user is already in user defaults under the current user key, if yes
                if let user = userDefault.object(forKey: kCURRENTUSER){
                    //then create user dictionary again and save it to Firebase
                    FirebaseUser(_dictionary: user as! NSDictionary).saveUserToFirestore()
                }//
                
            }
            
        }//end FirebaseReference
        
    }//end Download
    
    
    
}//end FirebaseListener Class


