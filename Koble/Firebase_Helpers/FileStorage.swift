//
//  FileStorage.swift
//  Koble
//
//  Created by Denys Ladden on 4/24/22.
//
//  Class which handles all the uploads and downloads

import Foundation
import FirebaseStorage
import UIKit

//MARK: - Var

//global variable for root access to the firebase storage
let storage = Storage.storage()

class FilesStorage{
    /*
    calss function which goos through Storage directories which are FILE based to show where to upload
    it uses a callback completion with the link (optional since we might not recive anythign back)
    and finaly it does not return anything
     */
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
        
    }//end upload image
    
    /*
    Function for uploading the array of images for INTERESTS (S)
     */
    class func uploadInterests(_ images: [UIImage?], completion: @escaping (_ imageLinks: [String]?)-> Void){
        //links variable array (everytime image is uploaded it is stored in this array)
        var imageLinksArray : [String] = []
        //counter for the images to tell how many images were selected
        var imageUploadCount = 0
        //name of the image sufix for classification if needed
        var nameSuffix = 0
        
        for image in images{
            //creating the file directory
            let fileDirectory = "interest_images/" + FirebaseUser.currentId() + "/" + "\(nameSuffix)" + ".jpg"
        
            uploadImage(image!, directory: fileDirectory) { (imageLink) in
                
                if imageLink != nil{
                    imageLinksArray.append(imageLink!)
                    imageUploadCount += 1
                    //all images are puploaded
                    if imageUploadCount == images.count{
                        completion(imageLinksArray)
                    }
                    
                }//end if
            }//end  uploadImage
            
            nameSuffix += 1
        }
        
        
    }//end storage
    
    
    
    
    
    /*
     RETURNS UIImage
     Function for downloading the image from the firebase it pases the URl has a completion
     (The profImgLink URL is a very long string all that is needed from it is the UID this function
     extracts it)
     */
    class func downloadImage(imageUrl: String, completion: @escaping (_ image: UIImage?) -> Void){
        
        //print("URL IS ", imageUrl)
        //EXTRACTING THE STRING: spliting the string into two section by "_" and end it by last object or the rest of the string
        //then splitting it by the "?" and taking the beggining portion with the .first, then separating it by the ".
        let imageFileName = ((imageUrl.components(separatedBy: "_").last!).components(separatedBy: "?").first)!.components(separatedBy: ".").first!
        //print(imageFileName)
        //if the file exist localy
        if fileExistsAt(path: imageFileName){
           
            //print("Local file is present")
            //create UIimage if there is local file if it does exist completion pass the contents of the file:
            //which should be the image
            if let contentsOfFile = UIImage(contentsOfFile: fileDirectoryAccess(filename: imageFileName)){
                completion(contentsOfFile)
            }else{
                //else no image was generated return the UIimage as profImg which contains the placeholder image
                print("Could not generate image from local image")
                completion(nil)//UIImage(named: "profImg")
            }//end contentsOfFile
        }else{
            //print("downloading")
            //downlaod the image by checking if the link is a string if its empty
            if imageUrl != ""{
                let documentURL = URL(string: imageUrl)
                let downloadQueue = DispatchQueue(label: "downloadQueue")
                downloadQueue.async {
                    //creates NSData from URL
                    let data = NSData(contentsOf: documentURL!)
                    //making sure coverision was succesful
                    if data != nil{
                        //image to return
                        let imageToReturn = UIImage(data: data! as Data)
                        //saving it locallyprofileImage
                        FilesStorage.saveImageLocally(imageData: data!, fileName: imageFileName)
                        completion(imageToReturn)
                    }else{
                        print("no image in database")
                        completion(nil)
                    }
                }
            }else{
                //else provide the ui image
                completion(nil)//lUIImage(named: "profImg")
            }
        }
        
        
    }//end download image
    
    
    class func downloadIneterests(imageUrls: [String], completion: @escaping (_ images: [UIImage?]) -> Void){
        
        //images in arrat download and returned
        var imageArray: [UIImage] = []
        
        var downloadCounter = 0
        
        for link in imageUrls{
            
            let url = NSURL(string: link)
            
            let downloadQueue = DispatchQueue(label: "downloadQueue")
            downloadQueue.async {
                
                downloadCounter += 1
                
                //creates NSData from URL
                let data = NSData(contentsOf: url! as URL)
                //making sure coverision was succesful
                if data != nil{
                    
                    imageArray.append(UIImage(data: data! as Data)!)
                    
                    if downloadCounter == imageArray.count{
                     
                        completion(imageArray)
                        
                    }
                    
                }else{
                    print("no image in database")
                    completion(imageArray)
                }
            }
    
        }
        
    }//end download Ineterests
    
    
    
    
    
    /*
     Data and NSData are types used to interact with raw binary data.
     They’re commonly used to hold raw data more complex than single strings,
     integers, bools, and so on. Image in this instance!!
     */
    class func saveImageLocally(imageData: NSData, fileName: String){
        //docunent variable
        var documentURL = getDocumentsURL()
        //apending path returns URL constructed by appending the given path componrnts to self
        //filename
        documentURL = documentURL.appendingPathComponent(fileName, isDirectory: false)
        //write to document url automically "rewrite" to the same file
        imageData.write(to: documentURL, atomically: true)
        
    }//end sabe img loc
    
}//end class FilesStorage


/*
File Manager
This file manger grants access to the sandbox by returning the URL
 */
func getDocumentsURL() -> URL{
    //urls() returns an array of URLS for the specified common direcotry in a requested domain
    //documentDirectory is just that
    //userDomainMask is user home directory where they install their data
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last//getting last url
    
    return documentURL!
    
}//end getDocumentsUR
//creates a path to the directory
func fileDirectoryAccess(filename: String) -> String{
    //file name to save the local files
    let fileURL = getDocumentsURL().appendingPathComponent(filename)
    //return the path
    return fileURL.path

}//fileDirectoryAcces

//Function whcih checks if file exists in a directory
func fileExistsAt(path: String)-> Bool{
    //commented code below is the same as the code above:
    return FileManager.default.fileExists(atPath: fileDirectoryAccess(filename: path))
//    var doesExist = False
//
//    let filePath = fileDirectoryAccess(filename: path)
//
//    if FileManager.default.fileExists(atPath: filePath){
//        doesExist = true
//    }else{
//        doesExist = false
//    }
//    return doesExist
    
    
    
}

