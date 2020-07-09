//
//  User.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/8/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import Foundation

//Class to determine the users current state such as if its on the menu or the # of hits
class User {
    
    var firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch"){
        didSet { UserDefaults.standard.set(self.firstLaunch, forKey: "firstLaunch") }
    }
    
    var hits = UserDefaults.standard.integer(forKey: "hits"){
        didSet { UserDefaults.standard.set(self.hits, forKey: "hits") }
    }
    
    var isMenu = UserDefaults.standard.bool(forKey: "hits"){
        didSet { UserDefaults.standard.set(self.hits, forKey: "hits") }
    }
    
    init(){
        isMenu = true
    }
}
