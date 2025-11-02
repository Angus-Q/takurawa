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
        HStack {
            Text(transaction.description)
                .font(.title)
                .fontWeight(.bold)
            Text(transaction.amount.description)
            Text(transaction.amount.formatted(.currency(code: "NZD")))
        }
    }
}

