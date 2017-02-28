//
//  Person.swift
//  Week6 Homework
//
//  Created by Hanna Chen on 2/26/17.
//  Copyright © 2017 Rethink Canada. All rights reserved.
//

import Foundation
import UIKit

class Person {
    
    var id: String
    var name: String
    var details: String?
    var photo: UIImage?
    
    init(id: String, name: String) {
        self.name = name
        self.id = id
    }
    
    func setDetails(details: String) {
        self.details = details
    }
    
    func setPhoto(photoName: String) {
        let profileImage = UIImage(named: photoName)
        if let photo = profileImage {
            self.photo = photo
        }
    }
    
    func setPhoto(photo: UIImage) {
        self.photo = photo
    }
    
    func setupThumbnail(container: UIImageView, x: Int = 50, y: Int = 50, size: Int = 500) {
        
        if let profilePhoto = self.photo {
            
            let contextImage: UIImage = UIImage(cgImage: profilePhoto.cgImage!)
            
            // Calculate position as percentage
            let contextSize: CGSize = contextImage.size
            let cgX: CGFloat = CGFloat(x)
            let cgY: CGFloat = CGFloat(y)
            let posX: CGFloat = (contextSize.width/100)*cgX
            let posY: CGFloat = (contextSize.height/100)*cgY
            
            // Set crop square size
            let cgwidth: CGFloat = CGFloat(size)
            let cgheight: CGFloat = CGFloat(size)
            
            let rect: CGRect = CGRect(x: posX-cgwidth/2, y: posY-cgheight/2, width: cgwidth, height: cgheight)
            let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
            
            print("scale: \(profilePhoto.scale)")
            
            let profileImage: UIImage = UIImage(cgImage: imageRef, scale: profilePhoto.scale, orientation: profilePhoto.imageOrientation)
            container.image = profileImage
        }
        
        // Apply circular mask to container
        container.layer.borderWidth = 0
        container.layer.masksToBounds = false
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.cornerRadius = container.frame.height/2
        container.clipsToBounds = true
        container.contentMode = .scaleAspectFit
    }
}
