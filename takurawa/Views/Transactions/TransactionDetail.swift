//
//  TransactionDetail.swift
//  takurawa
//
//  Created by Angus Quigley on 01/11/2025.
//

import SwiftUI

//-- transaction detail view after enrichement

//-- At the moment, this is only blocked out. I am waiting to get a genie api key to process the transaction data and display it in a better, easier to understand fashion.
//-- This could be a card view, that could be clicked and moved to a true detail view? Unsure if this is the path I will take yet...

struct TransactionDetail: View {
    
    @State var transaction: Transaction
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.merchant?.name ?? transaction.description)
            }
            .font(.system(size: 20, weight: .semibold, design: .default))
            HStack {
                Text(transaction.category?.name ?? "No Transaction Description")
            }
            .font(.system(size: 14, weight: .regular, design: .default))
            HStack {
                Text({
                    let iso = ISO8601DateFormatter()
                    iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                    
                    let out = DateFormatter()
                    out.dateFormat = "MMMM d, yyyy"
                    out.locale = Locale(identifier: "en_US_POSIX")
                    
                    return iso.date(from: transaction.date).map { out.string(from: $0) } ?? "Invalid date"
                }())
            }
            .font(.system(size: 14, weight: .regular, design: .default))
            .padding(.bottom, 5)
            HStack {
                Text(transaction.amount.formatted(.currency(code: "NZD")))
            }
            .font(.system(size: 14, weight: .bold, design: .default))
        }
    }
}

// id: String, date: String, description: String, amount: Decimal, balance: Decimal, type: String, merchant: Merchant?, category: tCategory?
//var tr = Transaction(id: "1", date: "2021-01-01", description: "test", amount: 100, balance: 100, type: "test", merchant: nil, category: nil)
//

//-- Preview does not work as the date format in the example var is incorrect :O

//#Preview {
//    TransactionDetail(transaction: tr)
//}
