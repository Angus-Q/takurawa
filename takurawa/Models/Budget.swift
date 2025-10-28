//
//  Budget.swift
//  takurawa
//
//  Created by Angus Quigley on 29/10/2025.
//

import Foundation

struct Budget: Identifiable {
    let id: UUID = UUID()
    var category: Category
    var description: String
    var budget: Decimal
    var actual: Decimal? = nil
    var difference: Decimal? = nil
    //-- There must be a better way to do this formatting (below)
    var budgetAsString: String { budget.formatted() } //-- closure
    
    init (category: Category, description: String, budget: Decimal) {
        self.category = category
        self.description = description
        self.budget = budget
    }
    
}

struct Category: Identifiable {
    let id: UUID = UUID()
    var name: String
    let parentId: UUID?
    
    init (name: String, parentId: UUID? = nil) {
        self.name = name
        self.parentId = parentId
    }
}

//-- Purple vs green colors for the two structs. Is this significant?
//-- Not yet is any parent category been defined or used
let exampleCategories: [Category] = [
    Category(name: "Food"),
    Category(name: "Home"),
    Category(name: "Entertainment"),
    Category(name: "Medical"),
]

//-- I would much rather prefer categories were referenced to as a type.
let exampleBudgets: [Budget] = [
    .init(category: exampleCategories[0], description: "Groceries", budget: 50),
    .init(category: exampleCategories[1], description: "Rent", budget: 750),
    .init(category: exampleCategories[2], description: "Apple TV", budget: 35),
    .init(category: exampleCategories[3], description: "Doctor's visits", budget: 240),
]



