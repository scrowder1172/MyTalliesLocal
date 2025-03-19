//
// File: Router.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import Foundation

@Observable
class Router {
    var tallyName: String?
    init(tallyName: String? = nil) {
        self.tallyName = tallyName
    }
}
