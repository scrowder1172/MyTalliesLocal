//
// File: FirstTallyWidget.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 

import SwiftData
import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    var container: ModelContainer = {
        try! ModelContainer(for: Tally.self)
    }()
    
    func placeholder(in context: Context) -> FirstTallyEntry {
        FirstTallyEntry(date: Date(), tallies: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (FirstTallyEntry) -> ()) {
        let currentDate = Date.now
        Task {
            let allTallies = try await getTallies()
            let entry = FirstTallyEntry(date: currentDate, tallies: allTallies)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        
        Task {
            let allTallies = try await getTallies()
            let entry = FirstTallyEntry(date: currentDate, tallies: allTallies)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    @MainActor
    func getTallies() throws -> [Tally] {
        let sort = [SortDescriptor(\Tally.name)]
        let descriptor = FetchDescriptor<Tally>(sortBy: sort)
        let allTallies = try? container.mainContext.fetch(descriptor)
        return allTallies ?? []
    }
}

struct FirstTallyEntry: TimelineEntry {
    let date: Date
    let tallies: [Tally]
}

struct FirstTallyEntryWidgetView : View {
    var entry: Provider.Entry

    var body: some View {
        if entry.tallies.isEmpty {
            ContentUnavailableView("No Tallies Yet", systemImage: "plus.circle.fill")
        } else {
            VStack{
                Button(intent: UpdateTallyIntent()){
                    SingleTallyView(size: 60, tally: entry.tallies.first!)
                }
                .buttonStyle(.plain)
                Text(entry.tallies.first!.name)
            }
        }
    }
}

struct FirstTallyWidget: Widget {
    let kind: String = "FirstTallyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FirstTallyEntryWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("First Tally")
        .description("The value of the First Tally.")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    FirstTallyWidget()
} timeline: {
    FirstTallyEntry(date: .now, tallies: [])
}
