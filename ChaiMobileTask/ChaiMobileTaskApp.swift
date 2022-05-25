//
//  ChaiMobileTaskApp.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 23/05/22.
//

import SwiftUI

@main
struct ChaiMobileTaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppComponent.shared.viewModel)
        }
    }
}
