//
// File: TallyUpdatedView.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

struct TallyUpdatedView: View {
    let tallyName: String
    let newValue: Int
    var body: some View {
        HStack {
            Text("\(newValue)")
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3))
            Text("\(tallyName) has been updated")
        }
        .font(.largeTitle)
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TallyUpdatedView(tallyName: "Beta", newValue: 2)
}
