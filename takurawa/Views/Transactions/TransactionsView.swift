//
//  TransactionsView.swift
//  takurawa
//
//  Created by Angus Quigley on 29/10/2025.
//

import SwiftUI

struct TransactionsView: View {

    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State var AllAccountTransactions: [Transaction] = []
    @State var filteredAccountTransactions: [Transaction] = []
    
    @State var checkBox: Bool = false
    @State var text1: String = ""
    
    let dateFormatter = ISO8601DateFormatter()
    
    //-- Payment Filter 1
    private var filter1: [String] = ["CREDIT CARD", "EFTPOS", "STANDING ORDER", "PAYMENT"]

    var totalExpenditure: Decimal {
        filteredAccountTransactions.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        Text("Transactions")
        VStack {
            DatePicker(
                "Start Date",
                selection: $startDate,
                displayedComponents: [.date]
            )
            DatePicker(
                "End Date",
                selection: $endDate,
                displayedComponents: [.date]
            )
        }
        Button("Fetch Transactions") {
            Task {
                do {
                    AllAccountTransactions = try await fetchTransactionData(USER_TOKEN: Secrets.USER_TOKEN, APP_TOKEN: Secrets.APP_TOKEN, START_DATE: startDate, END_DATE: endDate)
                    filteredAccountTransactions = []
                    for transaction in AllAccountTransactions {
//                        print(transaction.type)
                        //-- Only less than 0 filter may be required!
                        if (filter1.contains(transaction.type) && transaction.amount < 0) {
                            filteredAccountTransactions.append(transaction)
                        }
                    }
                    
                } catch {
                    print("Error getting data: \(error)")
                }
            }
        }
        Table(filteredAccountTransactions) {
            TableColumn("Description") {transaction in
                Text(
                    transaction.description,
                )
                .textSelection(.enabled)
            }
            TableColumn("Amount") { transaction in
                Text(transaction.amount.formatted(.currency(code: "NZD")))
            }
            TableColumn("Balance") { transaction in
                Text(transaction.balance.formatted(.currency(code: "NZD")))
            }
            TableColumn("Date", value: \.date)
            TableColumn("Type", value: \.type)
            TableColumn("Marked") { transaction in
                Toggle("", isOn: $checkBox)
                    .toggleStyle(.checkbox)
            }
        }
        
        HStack {
            Text("Total expenditure for the selected period: \(totalExpenditure)")
            Spacer()
            Text("Selected period starts from \(startDate.formatted(date: .long, time: .omitted)) and ends at \(endDate.formatted(date: .long, time: .omitted))")
        }
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                //-- Implicitly ignore args for closure
                ForEach(1...10, id: \.self) { _ in
                    TransactionDetail()
                }
            }
        }
    }
}
