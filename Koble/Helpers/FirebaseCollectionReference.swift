//
//  FirebaseCollectionReference.swift
//  Koble
//
//  Created by Denys Ladden on 4/15/22.
//

import Foundation
import FirebaseFirestore

/*
 Collections which will be used:
 Telling Firebase which folder we need to access collection
 */
enum FirebaseCollectionReference: String{
    
    case User
    
}//end FirebaseCollectionReference


/*
 This a Firebase Provided class is a refrence to specific collection in firebase database
 */
func FirebaseReference(_ collectionReference: FirebaseCollectionReference) -> CollectionReference{
    
    //returns root directory to the Firebase. Passing user raw value
    return Firestore.firestore().collection(collectionReference.rawValue)
    
}//end FirebaseReference
