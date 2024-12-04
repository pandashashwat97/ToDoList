//
//  ListView.swift
//  ToDoList
//
//  Created by Shashwat Panda on 04/12/24.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listVieWModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listVieWModel.items.isEmpty {
                Text("No Tasks Available")
            } else {
                List {
                    ForEach(listVieWModel.items) { item in
                        ListRowView(title: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listVieWModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listVieWModel.deleteItem)
                    .onMove(perform: listVieWModel.moveItem)
                }
            }
        }
        .navigationTitle("Tasks 🎯")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink("Add") {
                    AddView()
                }
                .foregroundStyle(Color.red)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListView()
    }
    .environmentObject(ListViewModel())
}

