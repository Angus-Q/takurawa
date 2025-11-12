//
//  Transaction.swift
//  takurawa
//
//  Created by Angus Quigley on 01/11/2025.
//

import Foundation

struct Transaction: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case date
        case description
        case amount
        case balance
        case type
        case merchant
        case category
    }
    
    let id: String
    let date: String
    let description: String
    let amount: Decimal
    let balance: Decimal
    let type: String
    let merchant: Merchant?
    let category: tCategory?
    
    init(
         id: String,
         date: String,
         description: String,
         amount: Decimal,
         balance: Decimal,
         type: String,
         merchant: Merchant?,
         category: tCategory?,) {
        
        self.id = id
        self.date = date
        self.description = description
        self.amount = amount
        self.balance = balance
        self.type = type
        self.merchant = merchant
        self.category = category
        
    }
}

struct Cursor: Decodable {
    let next: String?
    
    init(next: String?) {
        self.next = next
    }
}

struct Merchant: Decodable {
    let name: String
    let website: String?
    
    init(name: String, website: String) {
        self.name = name
        self.website = website
    }
    
}

//-- Should this become just category?
struct tCategory: Decodable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
}
