//
//  MutableCollection+Ext.swift
//  TacoPop
//
//  Created by Захар on 03.02.18.
//  Copyright © 2018 Захар. All rights reserved.
//

import Foundation

extension MutableCollection where Index == Int {
    mutating func shuffle () {
        if count < 2 {
            return
        }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            self.swapAt(i, j)
        }
    }
}
