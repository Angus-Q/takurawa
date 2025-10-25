//
//  DashboardView.swift
//  takurawa
//
//  Created by Angus Quigley on 25/10/2025.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var APP_TOKEN: String = ""
    @State private var USER_TOKEN: String = ""
    @State private var Accounts: [Account] = []
    
    var body: some View {
        VStack {
            SecureField(
                "App Token",
                text: $APP_TOKEN
            )
            SecureField(
                "User Token",
                text: $USER_TOKEN
            )
            Button("Fetch Account Data") {
                Task {
                    do {
                        Accounts = try await fetchAccountData(USER_TOKEN: USER_TOKEN, APP_TOKEN: APP_TOKEN)
                    } catch {
                        print("Error getting data: \(error)")
                    }
                }
            }
            HStack {
                ForEach(Accounts) { account in
                    AccountSummaryCardView(accountName: account.name, balanceAvailable: account.balance.available)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
