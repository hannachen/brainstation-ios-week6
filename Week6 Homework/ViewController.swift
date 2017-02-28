//
//  ViewController.swift
//  Week6 Homework
//
//  Created by Hanna Chen on 2/26/17.
//  Copyright © 2017 Rethink Canada. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Updatable {
    
    // Outlets
    @IBOutlet var profileViews: [UIView]!
    
    // Properties
    var profiles: [String: Person] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BestBuds"
        
        self.setupProfiles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController {

            if let button = sender as? UIButton,
               let profileID = button.accessibilityIdentifier as String! {
                detailsViewController.profile = self.profiles[profileID]
                detailsViewController.updateDelegate = self // Pass itself in as event handler/callback, can be a different thing
            }
        }
    }
    
    func update(person: Person) {
        print("Update person Index")
        print(person)
        if let profileId = person.id as String?,
           let profile = self.profiles[profileId] as Person? {
            self.profiles[profileId] = person
        }
    }
    
    func setupProfiles() {
        
        if let asset = NSDataAsset(name: "ProfileJSON") {
            
            let data = asset.data
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSArray {
                
                var index = 0;
                for field in json as [AnyObject] {
                    
                    if let id = field["id"] as? String,
                       let name = field["name"] as? String {
                        
                        let newProfile: Person = Person(id: id, name: name)
                        
                        if let details = field["details"] as? String {
                            newProfile.setDetails(details: details)
                        }
                        if let photo = field["photo"] as? String {
                            newProfile.setPhoto(photoName: photo)
                        }
                        
                        // Go through profile subviews
                        let profileView = profileViews[index]
                        var imageView: UIImageView?
                        
                        for element in profileView.subviews {
                            print(element)
                            if element.isKind(of: UIImageView.self) {
                                imageView = element as? UIImageView
                            }
                            if element.isKind(of: UIButton.self) {
                                element.accessibilityIdentifier = newProfile.id
                            }
                        }
                        
                        if let thumbnailContainer = imageView as UIImageView? {
                            
                            if let thumbnail = field["thumbnail"] as AnyObject? {
                                if let x = thumbnail["x"] as? NSNumber,
                                    let y = thumbnail["y"] as? NSNumber,
                                    let size = thumbnail["size"] as? NSNumber {
                                    
                                    newProfile.setupThumbnail(container: thumbnailContainer, x: x.intValue, y: y.intValue, size: size.intValue)
                                } else {
                                   newProfile.setupThumbnail(container: thumbnailContainer)
                                }
                            }
                        }
                        profiles[newProfile.id] = newProfile
                    }
                    index += 1
                }
            }
        }
    }
}

