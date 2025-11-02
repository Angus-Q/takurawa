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
    
    @State private var selectedTransaction: String? = nil
    
    let dateFormatter = ISO8601DateFormatter()
    
    //-- Payment Filter 1
    private var filter1: [String] = ["CREDIT CARD", "EFTPOS", "STANDING ORDER", "PAYMENT"]

    var totalExpenditure: Decimal {
        filteredAccountTransactions.reduce(0) { $0 + $1.amount }
    }
    
    var transactionToDetail: Transaction? {
        return AllAccountTransactions.first { $0.id == selectedTransaction }
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
        HStack {
            Table(AllAccountTransactions, selection: $selectedTransaction) {
                //-- Date
                TableColumn("Date") { transaction in
                    Text({
                        let iso = ISO8601DateFormatter()
                        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                        let out = DateFormatter()
                        out.dateFormat = "MMMM d, yyyy"
                        out.locale = Locale(identifier: "en_US_POSIX")

                        return iso.date(from: transaction.date).map { out.string(from: $0) } ?? "Invalid date"
                    }())
                }
                
                TableColumn("Transaction") {transaction in
                    Text(
                        transaction.description,
                    )
                    .textSelection(.enabled)
                }
                TableColumn("Withdrawls") { transaction in
                    Text({
                        if transaction.amount.formatted() <= "0.00" {
                            return transaction.amount.formatted(.currency(code: "NZD"))
                        } else {
                            return ""
                        }
                    }())
                }
                TableColumn("Deposits") { transaction in
                    Text({
                        if transaction.amount.formatted() >= "0.00" {
                            return transaction.amount.formatted(.currency(code: "NZD"))
                        } else {
                            return ""
                        }
                    }())
                }
                TableColumn("Balance") { transaction in
                    Text(transaction.balance.formatted(.currency(code: "NZD")))
                }
                TableColumn("Marked") { transaction in
                    Toggle("", isOn: $checkBox)
                        .toggleStyle(.checkbox)
                }
            }
            
            
            //-- Problem here, no @State variable...
            if (transactionToDetail != nil) {
                TransactionDetail(transaction: transactionToDetail!)
            } else {
                Text("No transaction selected")
            }
        }
        HStack {
            Text("Total expenditure for the selected period: \(totalExpenditure)")
            Spacer()
            Text("Selected period starts from \(startDate.formatted(date: .long, time: .omitted)) and ends at \(endDate.formatted(date: .long, time: .omitted))")
        }
    }
}
