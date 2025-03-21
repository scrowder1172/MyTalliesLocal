//
// File: UpdateNamedTallyIntent.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import AppIntents
import SwiftData
import WidgetKit

struct UpdateNamedTallyIntent: AppIntent {
    static var title: LocalizedStringResource = "Update named Tally"
    static var description: IntentDescription? = IntentDescription("Select the tally to increment")
    
    @Parameter(title: "Tally")
    
    var nameEntity: TallyEntity?
    
    func perform() async throws -> some ProvidesDialog & ShowsSnippetView {
        let entity: TallyEntity
        var newValue: Int = 0
        var tallyName: String = ""
        if let nameEntity {
            let update = await updateTally(name: nameEntity.id)
            entity = nameEntity
            newValue = update
            tallyName = entity.id
        } else {
            let unNamedEntity = try await $nameEntity.requestDisambiguation(among: suggestedEntities(), dialog: IntentDialog("Select a tally to update"))
            let update = await updateTally(name: unNamedEntity.id)
            entity = unNamedEntity
            tallyName = unNamedEntity.id
            newValue = update
        }
        WidgetCenter.shared.reloadAllTimelines()
        return .result(dialog: "Updated \(tallyName) to \(newValue)", view: TallyUpdatedView(tallyName: tallyName, newValue: newValue))
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
            return tally.value
        }
        
        return 0
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
}
