//
//  ListRowView.swift
//  ToDoList
//
//  Created by Shashwat Panda on 04/12/24.
//

import SwiftUI

struct ListRowView: View {
    
    let title: ItemModel
    var body: some View {
        HStack {
            Image(systemName: title.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(title.isCompleted ? Color.green : Color.red)
            Text(title.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
    ListRowView(title: ItemModel(title: "This is the first title", isCompleted: false))
}
