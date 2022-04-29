//
//  FileStorage.swift
//  Koble
//
//  Created by Denys Ladden on 4/24/22.
//
//  Class which handles all the uploads and downloads

import Foundation
import FirebaseStorage

//MARK: - Var

//global variable for root access to the firebase storage
let storage = Storage.storage()

class FilesStorage{
    //calss function which goos through Storage directories which are FILE based to show where to upload
    //it uses a callback completion with the link (optional since we might not recive anythign back)
    //and finaly it does not return anything
    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping (_ documentLink: String?)-> Void){
        //taks variable which will do the uploading
        
        
        //Establishing a link to the folder which we will use to store images
        //FIREBASE PROVIDES a url link when file was store to access it the child path directory
        let storageRef = storage.reference(forURL: KFILEREFERENCE).child(directory)
        //converting to jpeg to save it (80% quiality)
        let imageData = image.jpegData(compressionQuality: 0.8)
        var task: StorageUploadTask!
        //stores the data
        task = storageRef.putData(imageData!, metadata: nil, completion: { (metaData, error) in
            
            //task listens continuosly to see if the task is requested
            //removes all obserevers once the task is done
            task.removeAllObservers()
            
            //checking for errros
            if error != nil{
                print("error uploading image", error!.localizedDescription)
                return//
            }//edn if
            
            //if no error get the download url from firebase copmletion
            storageRef.downloadURL { (url, Error) in
                //checking if url has vlue
                guard let downloadURL = url else{
                    completion(nil)
                    return
                }
                //if url has vlue call for completion
                completion(downloadURL.absoluteString)
                print("image uploaded to ", downloadURL.absoluteString)
            }//end storage
            
        })//end task
        
    }//end storage
    /*
     Data and NSData are types used to interact with raw binary data.
     They’re commonly used to hold raw data more complex than single strings,
     integers, bools, and so on. Image in this instance!!
     */
    class func saveImageLocally(imageData: NSData, fileName: String){
        
        
        
        
        
    }//end sabe img loc
    
    
}//end class FilesStorage



