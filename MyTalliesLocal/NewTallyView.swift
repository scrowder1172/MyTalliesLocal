//
// File: NewTallyView.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/18/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 

import SwiftData
import SwiftUI
import WidgetKit

struct NewTallyView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query var tallies: [Tally]
    @Binding var selectedTally: Tally?
    @State private var name: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                Button("Add") {
                    let newTally = Tally(name: name)
                    context.insert(newTally)
                    try? context.save()
                    WidgetCenter.shared.reloadAllTimelines()
                    selectedTally = newTally
                    MyTalliesShortcuts.updateAppShortcutParameters()
                    dismiss()
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty || tallies.map{$0.name}.contains(name))
                Spacer()
            }
            .padding()
            .navigationTitle("New Tally")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
    }
}

#Preview {
    NewTallyView(selectedTally: .constant(nil))
}
