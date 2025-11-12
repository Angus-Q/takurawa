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
    @State private var CustomAppToken: String = ""
    @State private var CustomUserToken: String = ""
    @State private var Accounts: [Account] = []
    @State private var enabkleEnvVarTokens: Bool = false
    
    private var APP_TOKEN: String {
        if enabkleEnvVarTokens {
            //-- Requires the user to have a secrets file in their project, if this doesn't exist there will be an error. I'll fix this later on!
            return Secrets.APP_TOKEN
        } else { return CustomAppToken }
    }
    
    private var USER_TOKEN: String {
        if enabkleEnvVarTokens {
            return Secrets.USER_TOKEN
        } else { return CustomUserToken }
    }
    
    var body: some View {
        VStack {
            
            Toggle(isOn: $enabkleEnvVarTokens) {
                Text("Use env var tokens")
            }
            SecureField(
                "App Token",
                text: $CustomAppToken
            )
            .disabled(enabkleEnvVarTokens)
            SecureField(
                "User Token",
                text: $CustomUserToken
            )
            .disabled(enabkleEnvVarTokens)
            HStack {
                Button("Refresh Account Data") {
                    print("Hello world!!!!!")
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
