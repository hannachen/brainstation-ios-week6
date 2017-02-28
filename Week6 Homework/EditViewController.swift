//
//  EditViewController.swift
//  Week6 Homework
//
//  Created by Hanna Chen on 2/26/17.
//  Copyright © 2017 Rethink Canada. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var detailsTextView: UITextView!
    
    // Properties
    var profile: Person?
    var updateDelegate: Updatable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let profile = self.profile {
            self.nameTextField.text = profile.name
            self.detailsTextView.text = profile.details
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func savePressed(_ sender: UIButton) {
        // Unwrap multiple things, goes in order as defined
        if let delegate = self.updateDelegate,
           let name = self.nameTextField.text,
           let details = self.detailsTextView.text,
           let profile = self.profile as Person? {
            let person: Person = Person(id: profile.id, name: name)
            person.setDetails(details: details)
            
            // Update new person object with old photo
            if let photo = profile.photo as UIImage? {
                person.setPhoto(photo: photo)
            }
            delegate.update(person: person)
        }
    }
    
    // UITextFieldDelegate
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
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
