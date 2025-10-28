//
//  BudgetView.swift
//  takurawa
//
//  Created by Angus Quigley on 28/10/2025.
//

import SwiftUI

struct BudgetView: View {
    
    //-- Create a CSV file (w/ a plus button) - maybe store it in another way?
    //-- Add catogories
    //-- Save the file and allow it to be edited too!
    var body: some View {
        HStack() {
            Spacer()
            Button("New Budget") {
                print("New Budget")
            }
            Button("Edit Budget") {
                print("Edit Budget")
            }
        }
        Table(exampleBudgets) {
            TableColumn("Category", value: \.category.name)
            TableColumn("Description", value: \.description)
            TableColumn("Amount", value: \.budgetAsString)
        }
        
    }
    
}
