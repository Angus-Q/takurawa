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
    }
    
    let id: String
    let date: String
    let description: String
    let amount: Decimal
    let balance: Decimal
    let type: String
}
