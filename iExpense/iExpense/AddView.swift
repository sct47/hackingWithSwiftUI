//
//  AddView.swift
//  iExpense
//
//  Created by Scott Murray on 23/3/21.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var valid = true
    @State private var showingAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                    .foregroundColor(valid ? .black : .red)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    self.valid = true
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.valid = false
                    self.showingAlert = true
                }
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Error"), message: Text("Amount must be a number"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
