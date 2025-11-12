//
//  Settings.swift
//  takurawa
//
//  Created by Angus Quigley on 05/11/2025.
//

import SwiftData //-- App storage should be explored more by me!

@Model
class SettingsData {
    
    var darkMode: Bool
    var newBudgetOnDay: Int
    
    init(darkMode: Bool = false, newBudgetOnDay: Int = 1) {
        self.darkMode = darkMode
        self.newBudgetOnDay = newBudgetOnDay
    }
    
}
