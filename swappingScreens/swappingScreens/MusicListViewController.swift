//
//  MusicListViewController.swift
//  swappingScreens
//
//  Created by Захар on 24.08.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class MusicListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.brown
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
