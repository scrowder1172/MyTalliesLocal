//
// File: ConfigurableUpdateIntent.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import AppIntents
import SwiftData
import WidgetKit

struct ConfigurableUpdateIntent: AppIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("Update first tally")
    static var description: IntentDescription? = IntentDescription("Tap the tally once to increment")
    
    @Parameter(title: "Tally")
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init() {
    }
    
    func perform() async throws -> some IntentResult {
        let update = await updateTally(name: name)
        return .result(value: update)
    }
    
    @MainActor
    func updateTally(name: String) -> Int {
        let container = try! ModelContainer(for: Tally.self)
        let predicate = #Predicate<Tally> { $0.name == name }
        let descriptor = FetchDescriptor<Tally>(predicate: predicate)
        let foundTallies = try? container.mainContext.fetch(descriptor)
        if let tally = foundTallies?.first {
            tally.increase()
            try? container.mainContext.save()
            WidgetCenter.shared.reloadAllTimelines()
            return tally.value
        }
        
        return 0
    }
}
