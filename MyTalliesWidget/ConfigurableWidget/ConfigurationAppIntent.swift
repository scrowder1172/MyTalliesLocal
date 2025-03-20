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

