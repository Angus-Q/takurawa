//
//  AccountSummaryCardView.swift
//  takurawa
//
//  Created by Angus Quigley on 25/10/2025.
//

import SwiftUI
import Foundation

struct AccountSummaryCardView: View {
    
    @State var accountName: String
    @State var balanceAvailable: Decimal
    
    var body: some View {
        VStack {
            HStack {
                Text("Account Name")
                    .font(.headline)
                Spacer()
                Text(accountName)
            }
            HStack {
                Text("Balance Available")
                    .font(.headline)
                Spacer()
                Text("$\(balanceAvailable)")
            }
        }
    }
}
