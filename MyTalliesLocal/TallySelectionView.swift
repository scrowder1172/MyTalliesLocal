//
// File: TallySelectionView.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/18/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 

import SwiftData
import SwiftUI

struct TallySelectionView: View {
    @Query(sort: \Tally.name) var tallies: [Tally]
    @State private var selectedTally: Tally?
    @Environment(\.modelContext) private var context
    @State private var newTally: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                if tallies.isEmpty {
                    ContentUnavailableView("Create your first tally", image: "mac256")
                } else {
                    Picker("Select your tally", selection: $selectedTally) {
                        Text("Select Tally").tag(nil as Tally?)
                        ForEach(tallies) { tally in
                            Text(tally.name).tag(tally as Tally?)
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    if selectedTally != nil {
                        SingleTallyView(size: 100, tally: selectedTally!)
                        
                        Button {
                            withAnimation {
                                selectedTally?.reset()
                                try? context.save()
                            }
                        } label: {
                            Label("Reset", systemImage: "arrow.counterclockwise")
                        }
                        .font(.title)
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                    }
                    Spacer()
                }
            }
            .navigationTitle("My Tallies")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !tallies.isEmpty {
                        Button {
                            if let selectedTally {
                                context.delete(selectedTally)
                                try? context.save()
                                if !tallies.isEmpty {
                                    self.selectedTally = tallies.first
                                }
                            }
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    Button {
                        newTally = true
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $newTally) {
                NewTallyView(selectedTally: self.$selectedTally)
                    .presentationDetents([.height(250)])
            }
            .onAppear {
                if !tallies.isEmpty {
                    selectedTally = tallies.first
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    TallySelectionView()
}
