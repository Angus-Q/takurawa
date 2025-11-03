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
        
        VStack {
            HStack {
                Text("Date")
                    .frame(width: 250)
                Text("Transaction Infomation")
                    .frame(width: 250)
                Text("Amount")
                    .frame(width: 250)
            }
            HStack {
                VStack {
                    Text({
                        //-- Must be a better method compared to copy/paste this from the other view...
                        let iso = ISO8601DateFormatter()
                        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                        
                        let out = DateFormatter()
                        out.dateFormat = "MMMM d, yyyy"
                        out.locale = Locale(identifier: "en_US_POSIX")
                        
                        return iso.date(from: transaction.date).map { out.string(from: $0) } ?? "Invalid date"
                    }())
                        .font(.system(size: 24))
                }
                VStack(alignment: .leading) {
                    Text(transaction.merchant?.name ?? transaction.description)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.trailing, 15)
                    if (transaction.category?.name != nil) {
                        Text(transaction.category!.name)
                            .font(.system(size: 20))
                            .padding(.trailing, 15)
                    }
                    if (transaction.merchant?.website != nil) {
                        Text(transaction.merchant!.website!)
                            .font(.system(size: 20))
                            .padding(.trailing, 15)
                    }
                }
                VStack(alignment: .trailing) {
                    Text(transaction.amount.formatted(.currency(code: "NZD")))
                        .font(.system(size: 24))
                }
            }
        }
        .padding(15)
        .border(.orange)
        .background(Color.white)
    }
}
