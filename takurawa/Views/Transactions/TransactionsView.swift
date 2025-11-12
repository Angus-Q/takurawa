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
    
    @State var checkBox: Bool = false
    @State var text1: String = ""
    
    let dateFormatter = ISO8601DateFormatter()
    
    //-- Payment Filter 1
    private var filter1: [String] = ["CREDIT CARD", "EFTPOS", "STANDING ORDER", "PAYMENT"]

    @State private var selectedTransactionIDFromTable: String? = nil
    
    var transactionInFocus: Transaction? {

        return nil
//        return AllAccountTransactions.first { $0.id == selectedTransactionIDFromTable }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
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
                    Button("Fetch Transactions") {
                        Task {
                            do {
                                AllAccountTransactions = try await fetchTransactionData(USER_TOKEN: Secrets.USER_TOKEN, APP_TOKEN: Secrets.APP_TOKEN, START_DATE: startDate, END_DATE: endDate)
                            } catch {
                                print("Error getting data: \(error)")
                            }
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
            
            VStack(alignment: .leading) {
                Divider()
            }
            HStack {
                //-- _ made it a <State>String, but idk what this is.
                if (selectedTransactionIDFromTable != nil) {
                    //-- Force Unwrap and pass the data to the subview!
                    //-- There must be a better way to create this, but maybe this will allow multiple selection? If thats something worthwhile...
                    ForEach(AllAccountTransactions) { t in
                        if t.id == selectedTransactionIDFromTable {
                            TransactionDetail(transaction: t)
                        }
                    }
                } else {
                    Text("Select a row from the table to view more details.")
                }
                Spacer()
            }
            Divider()
            VStack(alignment: .leading) {
                Table(AllAccountTransactions, selection: $selectedTransactionIDFromTable) {
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

                    TableColumn("Transaction") { transaction in
                        Text(
                            transaction.merchant?.name ?? transaction.description,
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
                .tableStyle(.bordered)
                //            //-- Problem here, no @State variable...
                //            if (transactionToDetail != nil) {
                //                TransactionDetail(transaction: transactionToDetail!)
                //            } else {
                //                Text("No transaction selected")
                //            }
            }
            HStack {
                Spacer()
                Text("Selected period starts from \(startDate.formatted(date: .long, time: .omitted)) and ends at \(endDate.formatted(date: .long, time: .omitted))")
            }
        }
    }
}
