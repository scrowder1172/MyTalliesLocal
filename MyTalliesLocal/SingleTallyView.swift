//
// File: SingleTallyView.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/18/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 

import SwiftData
import SwiftUI
import WidgetKit

struct SingleTallyView: View {
    let size: Double
    @Bindable var tally: Tally
    @Environment(\.modelContext) private var context
    var body: some View {
        Text("\(tally.value)")
            .font(.system(size: size, weight: .heavy, design: .rounded))
            .monospaced()
            .contentTransition(.numericText())
            .minimumScaleFactor(0.5)
            .padding()
            .frame(width: size * 1.5, height: size * 1.5)
            .background(RoundedRectangle(cornerRadius: 20).fill(.clear).stroke(.primary, lineWidth: 5))
            .onTapGesture {
                withAnimation {
                    tally.increase()
                    try? context.save()
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
            .onTapGesture(count: 2) {
                withAnimation {
                    tally.decrease()
                    try? context.save()
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
    }
}

#Preview {
    @Previewable @State var tally = Tally(name: "Alpha")
    SingleTallyView(size: 100, tally: tally)
}
