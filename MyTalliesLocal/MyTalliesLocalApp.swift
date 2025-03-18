//
// File: MyTalliesLocalApp.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/18/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 

import SwiftData
import SwiftUI

@main
struct MyTalliesLocalApp: App {
    var body: some Scene {
        WindowGroup {
            TallySelectionView()
        }
        .modelContainer(for: Tally.self)
    }
}
