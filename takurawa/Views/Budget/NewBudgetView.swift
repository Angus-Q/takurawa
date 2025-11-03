//
//  NewBudgetView.swift
//  takurawa
//
//  Created by Angus Quigley on 30/10/2025.
//

import SwiftUI

struct NewBudgetView: View {
    
    @State private var categoryIncome: String = ""
    @State private var income: String = ""
    
    @State private var expenseCategory: String = ""
    @State private var expense: String = ""
    
    //-- Are there other varibales that can be used with SwiftUI? Interesting 'read-the-docs' project...
    var body: some View {
        HStack {
            Text("Income")
                .font(.headline)
            Spacer()
        }
        
        HStack {
            
            Picker(selection: .constant(1), label: Text("Category")) {
                Text("Salary / Wages").tag(1)
                Text("Dividends").tag(2)
            }

            TextField("category2", text: $categoryIncome)
            TextField("budget", text: $income)
            
        }
        
        HStack {
            Text("Expenses")
                .font(.headline)
            Spacer()
        }
        
        HStack {
            
            Picker(selection: .constant(1), label: Text("Category")) {
                Text("Entertainment").tag(1)
                Text("Home").tag(2)
                Text("Medical").tag(3)
                Text("Travel").tag(4)
            }

            TextField("category2", text: $expenseCategory)
            TextField("budget", text: $expense)
            
        }
        
    }
    
}
