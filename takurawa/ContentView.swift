//
//  ContentView.swift
//  takurawa
//
//  Created by Angus Quigley on 25/10/2025.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var tabSelected: Int = 1
    
    var body: some View {
        
        VStack {
            //-- A better approach to using this TabView is to use a Hashable enum with cases as tab value descriptions
            //-- selection: .constant(n) is good for testing, but as Tab's change, there needs to be a variable monitoring this view
            //-- The binding is required here so that the state variable can be read and written too!
            //-- Why do the tab images not show up??? Huh!!!
            TabView(selection: $tabSelected) {
                
                Tab("Dashboard", systemImage: "square.grid.3x3.square", value: 1) {
                    DashboardView()
                }
                Tab("Budget", systemImage: "creditcard.fill", value: 2) {
                    BudgetView()
                }
                Tab("Transactions", systemImage: "list.bullet.clipboard", value: 3) {
                    TransactionsView()
                }
            }
            .scenePadding()
            .frame(minWidth: 350, minHeight: 250)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
