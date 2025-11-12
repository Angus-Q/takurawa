//
//  takurawaApp.swift
//  takurawa
//
//  Created by Angus Quigley on 25/10/2025.
//

import SwiftUI
import SwiftData

@main
struct takurawaApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}

//struct RootView: View {
//    
//    @Environment(\.modelContext) private var context
//    //-- https://www.youtube.com/watch?v=UbwYMSDmg2I
//    //-- This video uses an array for settings, possibly in case there are multiple environments or new windows? I'm not sure, so I have included only 1
//    @Query private var settings: Settings
//    
//    var body: some View {
//        ContentView()
//            .onAppear(perform: {
//                //-- Check if the application settings already exist
//                //-- if yes, do nothing, if no, init settings to default settings
//                print("Hello, World!")
//                //-- Insert (below) settings into the env so other views can access this!
//            }).environment(settings ?? Settings())
//    }
//    
//}


