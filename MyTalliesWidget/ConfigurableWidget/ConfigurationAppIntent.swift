//
// File: ConfigurationAppIntent.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 



import WidgetKit
import AppIntents
import SwiftData

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Selected Tally" }
    static var description: IntentDescription { "Choose your tally from the list." }

    // An example configurable parameter.
    @Parameter(title: "Select Tally", default: nil)
    var selectedTally: TallyEntity?
}

struct TallyEntity: AppEntity {
    var id: String
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(name: "Selected Tally")
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    static var defaultQuery = TallyQuery()
}

struct TallyQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [TallyEntity] {
        try await suggestedEntities().filter({identifiers.contains($0.id)})
    }
    
    @MainActor
    func suggestedEntities() async throws -> [TallyEntity] {
        let container = try ModelContainer(for: Tally.self)
        let sort = [SortDescriptor(\Tally.name)]
        let descriptor = FetchDescriptor<Tally>(sortBy: sort)
        let allTallies = try? container.mainContext.fetch(descriptor)
        let allEntities = allTallies?.map({tally in
            TallyEntity(id: tally.name)
        })
        return allEntities ?? []
    }
    
    func defaultResult() async -> TallyEntity? {
        try? await suggestedEntities().first
    }
}
