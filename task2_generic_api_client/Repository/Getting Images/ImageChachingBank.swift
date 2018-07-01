//
//  ImageStore.swift
//  bnrg_ios_homepwner
//
//  Created by Roman Brazhnikov on 29.05.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit
/// In-memory cache and filesystem cache for downloaded images
class ImageCachingBank {
    private let cache = NSCache<NSString, UIImage>()
    
    //
    //  Singleton
    //
    
    private static var instance: ImageCachingBank?
    
    public static func getInstance() -> ImageCachingBank {
        if instance == nil {
            instance = ImageCachingBank()
        }
        return instance!
    }
    
    private init() {}
    // // // // // //
    
    
    /// Adds image with given key to the cache and file system
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
        
        // creating file URL
        let url = imageURL(forKey: key)
        
        // saving as JPEG
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    /// Return image buy its key
    func image(forKey key: String) -> UIImage? {
        // from cache
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        // from filesystem
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    /// Delete image from the cache and file system
    func deleteImage(forKey key: String){
        // from cache
        cache.removeObject(forKey: key as NSString)
        
        // from filesystem
        let url = imageURL(forKey: key)
        do {
           try FileManager.default.removeItem(at: url)
        }catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
        
    }
    
    /// Builds URL for saving image in the file system
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
}
