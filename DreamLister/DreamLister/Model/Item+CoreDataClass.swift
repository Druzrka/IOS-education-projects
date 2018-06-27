//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Захар on 21.12.17.
//  Copyright © 2017 Захар. All rights reserved.
//
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
