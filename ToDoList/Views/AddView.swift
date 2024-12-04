//
//  AddView.swift
//  ToDoList
//
//  Created by Shashwat Panda on 04/12/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel: ListViewModel
    @State var text:String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var textFieldBColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField("task title ..", text: $text)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(textFieldBColor))
                    .cornerRadius(10)
                    .padding(.vertical)
                Button{
                    saveButtonPressed()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40)
                        Text("Save")
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Add New Task ✏️")
        .alert("You have enough tasks on your plate", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                dismiss.callAsFunction()
            }
        }
    }
    
    func saveButtonPressed() {
        if listViewModel.ifItemsFull() {
            showAlert.toggle()
        } else {
            listViewModel.addItem(title: text)
            dismiss.callAsFunction()
        }
    }
}

#Preview {
    NavigationStack{
        AddView()
    }
    .environmentObject(ListViewModel())
}
