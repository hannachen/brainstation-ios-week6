//
//  DetailsViewController.swift
//  Week6 Homework
//
//  Created by Hanna Chen on 2/26/17.
//  Copyright © 2017 Rethink Canada. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, Updatable {
    // Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var detailsTextView: UITextView!
    
    // Properties
    var profile: Person?
    var updateDelegate: Updatable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // onLoad(?) Animation
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.detailsTextView.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailsTextView.alpha = 0
        
        if let profile = self.profile {
            self.title = profile.name
            self.nameLabel.text = profile.name
            self.detailsTextView.text = profile.details
            if let photo = profile.photo {
                photoImageView.image = photo
            }
        } else {
            print("Nothing was passed.")
        }
    }
    
    func update(person: Person) {
        print("Update person in Detail view")
        self.profile = person
        self.nameLabel.text = person.name
        self.detailsTextView.text = person.details
        
        // Unwrap multiple things, goes in order as defined
        if let delegate = self.updateDelegate {
            delegate.update(person: person)
        }
        
        // Go back to the previous screen on save
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let editVC = segue.destination as? EditViewController {
            editVC.profile = self.profile
            editVC.updateDelegate = self // Pass itself in as event handler/callback, can be a different thing
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
