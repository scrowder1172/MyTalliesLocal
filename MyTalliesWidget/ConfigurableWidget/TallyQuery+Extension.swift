//
// File: TallyQuery+Extension.swift
// Project: MyTalliesLocal
// 
// Created by SCOTT CROWDER on 3/19/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import Foundation

extension TallyQuery {
    func defaultResult() async -> TallyEntity? {
        try? await suggestedEntities().first
    }
}
