//
//  Account.swift
//  takurawa
//
//  Created by Angus Quigley on 25/10/2025.
//

import Foundation

struct Account: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case type
        case status
        case formatted_account
        case balance
        case meta
    }
    
    let id: String
    let name: String
    let type: String
    let status: String
    let formatted_account: String
    let balance: AccountBalance
    let meta: AccountMeta
}

struct AccountBalance: Decodable {
    let currency: String
    let current: Decimal
    let available: Decimal
    let limit: Decimal?
    let overdrawn: Bool
}

struct AccountMeta: Decodable {
    let holder: String
}
