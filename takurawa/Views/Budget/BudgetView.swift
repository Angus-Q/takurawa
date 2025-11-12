//
//  BudgetView.swift
//  takurawa
//
//  Created by Angus Quigley on 28/10/2025.
//

import SwiftUI

//-- to replace Category
struct Category2 {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
}

struct BudgetView: View {
    
    //-- Create a CSV file (w/ a plus button) - maybe store it in another way?
    //-- Add catogories
    //-- Save the file and allow it to be edited too!
    
    @State private var bCategory: String = ""
    
    @State private var categories: [Category2] = []
    
    @State private var showPopover: Bool = false
    
    var body: some View {
        HStack() {
            Spacer()
            Button("New Category") {
                print("New category")
                
            }
            
            Button("Show Category Popover") {
                showPopover.toggle()
            }
            .popover(isPresented: $showPopover, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
                VStack {
                    Text("Product Information")
                        .font(.headline)
                    TextField(
                        "Category",
                        text: $bCategory
                    )
                    Button("Submit") {
                        showPopover = false
                        categories.append(Category2(name: bCategory))
                    }
                }
                .padding()
                .frame(width: 200, height: 150) // Optional: set a fixed size for the popover content
            }
            
            Button("Display Categories Added") {
                for i in categories {
                    print("Category: \(i.name)")
                }
            }
            
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
