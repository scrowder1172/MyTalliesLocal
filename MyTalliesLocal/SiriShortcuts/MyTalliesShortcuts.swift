//
// File: MyTalliesShortcuts.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import AppIntents

struct MyTalliesShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
//        AppShortcut(
//            intent: UpdateTallyIntent(),
//            phrases: [
//                "Update \(.applicationName)"
//            ],
//            shortTitle: "Update first tally",
//            systemImageName: "1.circle.fill"
//        )
        AppShortcut(
            intent: UpdateNamedTallyIntent(),
            phrases: [
                "Update \(.applicationName)",
                "Update \(\.$nameEntity) with \(.applicationName)"
            ],
            shortTitle: "Update selected tally",
            systemImageName: "plus.circle.fill"
        )
    }
}
