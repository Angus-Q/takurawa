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
    
    @State private var bCategory: String = ""
    
    var body: some View {
        HStack() {
            Spacer()
            Button("New Budget") {
                print("New Budget")
            }
            Button("Edit Budget") {
                print("Edit Budget")
            }
            Button("Export Budget Data as CSV") {
                print("Export Budget Data as CSV")
            }
        }
        Table(exampleBudgets) {
//            TableColumn("Category", value: \.category.name)
            TableColumn("Category") { budget in
                TextField(
                    "Category",
                    text: $bCategory
                )
            }
            TableColumn("Description", value: \.description)
            TableColumn("Amount", value: \.budgetAsString)
        }
        NewBudgetView()
    }
    
}
