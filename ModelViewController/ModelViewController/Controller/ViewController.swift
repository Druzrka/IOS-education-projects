//
//  ViewController.swift
//  ModelViewController
//
//  Created by Захар on 24.09.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var constaint: NSLayoutConstraint!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var firstNameField: UITextField!
    
    let person = Person(firstName: "Zakhar", lastName: "Azatyan")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.text = person.fullName
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 10) {
            self.constaint.constant = 100
            self.view.layoutIfNeeded()
        }
        
        if let name = firstNameField.text {
            person.firstName = name
            fullNameLabel.text = person.fullName
        }
    }
}



