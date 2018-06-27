//
//  ViewController.swift
//  Miracle Pills
//
//  Created by Захар on 06.08.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var statePickerButton: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countyTextField: UITextField!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    let states = ["Alaska", "Alabama", "Arkansas", "California", "Maine", "New York"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statePicker.dataSource = self
        self.statePicker.delegate = self
    }
    
    @IBAction func stateButtonPressed(_ sender: UIButton) {
        labelsForPickerIsHidden(isHidden: true)
        statePicker.isHidden = false
    }
    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        
    }
    
    func labelsForPickerIsHidden(isHidden: Bool) {
        countryLabel.isHidden = isHidden
        countyTextField.isHidden =  isHidden
        zipCodeLabel.isHidden = isHidden
        zipCodeTextField.isHidden = isHidden
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statePickerButton.setTitle(states[row], for: UIControlState.normal)
        statePicker.isHidden = true
        labelsForPickerIsHidden(isHidden: false)
    }
}

