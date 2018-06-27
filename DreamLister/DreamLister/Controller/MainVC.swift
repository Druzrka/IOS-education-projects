//
//  MainVC.swift
//  DreamLister
//
//  Created by Захар on 21.12.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var controller = NSFetchedResultsController<Item>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        
        generateTest()
//        attemptFetch()
        get()
    }
    
    func get() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let items = try context.fetch(fetchRequest)
            print(items)
        } catch {
            print(error)
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {

            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    private func configureCell(cell: ItemCell, indexPath: IndexPath) {
        let item = controller.object(at: indexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHeight: CGFloat = 150
        
        return cellHeight
    }
}

extension MainVC: NSFetchedResultsControllerDelegate {
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            
            try controller.performFetch()
            
        } catch {
            let error = error as NSError
            print(error.debugDescription)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        itemsTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        itemsTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                itemsTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                itemsTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = itemsTableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as IndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                itemsTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                itemsTableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }
    
    func generateTest() {
        
        
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 1800
        item.details = "I can't wait until the September event, I hope they release new MPBs"
        
//        let item2 = Item(context: context)
//        item2.title = "Bose Headphones"
//        item2.price = 300
//        item2.details = "But man, its so nice to be able to blaock out everyone with the noise canceling tech."
//
//        let item3 = Item(context: context)
//        item3.title = "Tesla Model S"
//        item3.price = 110000
//        item3.details = "Oh man this is a beautiful car. And one day, I willl own it"

        ad.saveContext()
    }
}
