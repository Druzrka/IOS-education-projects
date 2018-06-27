//
//  ViewController.swift
//  ProgressBar
//
//  Created by Захар on 25.09.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressBarView: ProgressBarView!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        progressBarView.progress = CGFloat(slider.value)
    }
}

