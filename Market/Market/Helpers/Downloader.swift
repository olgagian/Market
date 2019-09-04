//
//  Downloader.swift
//  Market
//
//  Created by ioannis giannakidis on 29/08/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()

func uploadImages(images: [UIImage?], itemId: String, completion: @escaping (_ imageLinks: [String]) -> Void) {
    
    if Reachabilty.HasConnection() {
        
        var uploadedImagesCount = 0
        var imageLinkArray: [String] = []
        var nameSuffix = 0
        
        for image in images {
            
            let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.5)
            saveImageInFireBase(imageData: imageData!, filename: fileName) { (imageLink) in
                if imageLink != nil {
                    imageLinkArray.append(imageLink!)
                    uploadedImagesCount += 1
                    if uploadedImagesCount == images.count {
                        completion(imageLinkArray)
                    }
                }
            }
            nameSuffix += 1
            
        }
        
    } else {
        print("No Internet Connection")
    }
}
func saveImageInFireBase(imageData:Data, filename: String, completion: @escaping(_ imageLink: String?) -> Void) {
        var task: StorageUploadTask!
        let storageref =  storage.reference(forURL: kFILEREFERENCE).child(filename)
        task = storageref.putData(imageData, metadata: nil, completion: { (metadata, error) in
            
            task.removeAllObservers()
            if error != nil {
                print("Error uploading image",error?.localizedDescription)
                completion(nil)
                return
            }
            storageref.downloadURL { (url, error) in
                guard let downloadUrl = url else {
                     completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
            }
        })
    }
func downloadImages(imageUrls:[String], completion: @escaping (_ images: [UIImage?])->Void ) {
    var imageArray: [UIImage] = []
    var downloadCounter = 0
    for link in imageUrls {
        let url = NSURL(string: link)
        let downloadQueue = DispatchQueue(label:"imageDownloadQueue")
        downloadQueue.async {
            downloadCounter += 1
            let data = NSData(contentsOf: url! as URL)
            if data != nil {
                imageArray.append(UIImage(data: data! as Data)!)
                if downloadCounter == imageArray.count {
                    DispatchQueue.main.async {
                        completion(imageArray)
                    }
                }
            }else {
                print("couldn't download image")
                completion(imageArray)
            }
            
        }
    }
}
