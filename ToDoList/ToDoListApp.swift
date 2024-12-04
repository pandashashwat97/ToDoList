//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Shashwat Panda on 04/12/24.
//

import SwiftUI
import Firebase

@main
struct ToDoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView()
            }
            .environmentObject(listViewModel)
        }
    }
}
