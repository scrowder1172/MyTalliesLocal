//
// File: Tally.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/18/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import Foundation
import SwiftData

@Model
class Tally {
    var name: String
    var value: Int
    
    init(name: String, value: Int = 0) {
        self.name = name
        self.value = value
    }
    
    func increase() {
        value += 1
    }
    
    func decrease() {
        if value > 0 {
            value -= 1
        }
    }
    
    func reset() {
        value = 0
    }
    
    static var mockTallies: [Tally] {
        [
            Tally(name: "Alpha"),
            Tally(name: "Beta", value: 10)
        ]
    }
}
