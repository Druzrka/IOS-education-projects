//
//  Person.swift
//  ModelViewController
//
//  Created by Захар on 24.09.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import Foundation

class Person {
    
    private var _firstName: String!
    private var _lastName: String!
    
    var firstName: String {
        get {
            return _firstName
        } set {
            _firstName = newValue
        }
    }
    
    var lastName: String {
        return _lastName
    }
    
    init(firstName: String, lastName: String) {
        _firstName = firstName
        _lastName = lastName
    }
    
    var fullName: String {
        return "\(_firstName) \(_lastName)"
    }
}
