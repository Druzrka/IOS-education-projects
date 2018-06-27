//
//  ViewController.swift
//  MovingCells
//
//  Created by Захар on 24.01.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cars = ["My car", "Friedn's car", "Mother car"]
    
    var items = [["mers", "lamba"], ["BMW", "Car"], ["ford"]]
    var sections = [false, false, false]
    

    @IBAction func editButtonPressed(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.label.text = items[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section] {
            return 0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view = CarsTableHeader()
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 60)
        view.section = section
        view.carNameButton.titleLabel?.text = cars[section]
        view.addButtonHandler = addButtonHandler
        view.nameButtonHandler = nameButtonHandler
        
        return view
    }
    
    private func configureHeaderView(view: CarsTableHeader, section: Int) {
        
       
    }
    
    private func addButtonHandler(_ section: Int) {
        
    }
    
    private func nameButtonHandler(_ section: Int) {
        sections[section] = !sections[section]
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items[sourceIndexPath.section][sourceIndexPath.row]
        items[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        items[destinationIndexPath.section].insert(item, at: destinationIndexPath.row)
    }
}


