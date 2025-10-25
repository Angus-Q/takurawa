//
//  DashboardView.swift
//  takurawa
//
//  Created by Angus Quigley on 25/10/2025.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var APICallSuccessResult: String = ""
    
    //-- What is the purpose of @State
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
            HStack {
                Button("Refresh Account Data") {
                    Task {
                        do {
                            try await refreshAccountData(USER_TOKEN: USER_TOKEN, APP_TOKEN: APP_TOKEN)
                                APICallSuccessResult = "Refresh completed successfully!"
                        } catch {
                            APICallSuccessResult = "Error refreshing data: \(error)"
//                            print(APICallSuccessResult)
                        }
                    }
                }
                Button("Fetch Account Data") {
                    Task {
                        do {
                            Accounts = try await fetchAccountData(USER_TOKEN: USER_TOKEN, APP_TOKEN: APP_TOKEN)
                                APICallSuccessResult = "Fetch completed successfully!"
                        } catch {
                            print("Error getting data: \(error)")
                            APICallSuccessResult = "Error refreshing data: \(error)"
//                            print(APICallSuccessResult)
                        }
                    }
                }
            }
            Text(APICallSuccessResult)
            Spacer()
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
