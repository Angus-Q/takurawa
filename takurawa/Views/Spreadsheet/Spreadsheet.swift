//
//  Spreadsheet.swift
//  takurawa
//
//  Created by Angus Quigley on 30/10/2025.
//

import SwiftUI

//-- The spreadsheet view will be a custom view to act in a similar fashion numbers, excel or google sheets. The user will interact with each grid item, which is a custom view used to handle data the user may enter into their budget.

//-- A single click should highlight the view
//-- A second click on the highlighted view will allow the data to be edited
//-- The interface should feel more natural than the TableView
//-- More infomation can be found in the docs here:
//-- https://developer.apple.com/documentation/swiftui/griditem/
//-- https://developer.apple.com/documentation/swiftui/lazyvgrid
//-- A lazyverticalgrid is best as items can be added vertically but the width of the cols is fixed. A few problems I do see, large category names or numbers might cause an overflow. SwiftUI might not be the best method either, but I can test it, and if it doesn't work then look into other methods (UIKit?)

struct Spreadsheet: View {
    
    let cols = [
        GridItem(.fixed(90), spacing: 5),
        GridItem(.fixed(90), spacing: 5),
        GridItem(.fixed(90), spacing: 5),
        GridItem(.fixed(90), spacing: 5)
    ]

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: cols, spacing: 4) {
                ForEach(0...10, id: \.self) { _ in
                    Color.red.frame(width: 90)
                    Color.green.frame(width: 90)
                    Color.blue.frame(width: 90)
                    Color.yellow.frame(width: 90)
                }
            }
        }
        .padding(2)
    }
}

#Preview {
    Spreadsheet()
}
