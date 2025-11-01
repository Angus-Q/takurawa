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
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Transaction Name")
                        .font(.headline)
                }
                .padding(.top, 5)
                Text("Transaction Description")
                    .padding(.bottom, 10)
                HStack {
                    Label("Phome", systemImage: "phone")
                    Text("+64 27 123 456")
                }
                .padding(.bottom, 5)
            }
            Spacer()
            //        .frame(width: 300)
        }
        .border(Color.gray)
        .padding(5)
    }
}

#Preview() {
    TransactionDetail()
}
