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
    @State private var router = Router()
    var body: some Scene {
        WindowGroup {
            TallySelectionView()
                .onOpenURL { url in
                    print(url)
                    guard url.scheme == "mtls", url.host == "tally" else { return }
                    // Route to correct tally
                    router.tallyName = url.lastPathComponent
                }
        }
        .modelContainer(for: Tally.self)
        .environment(router)
    }
}
