//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Shashwat Panda on 04/12/24.
//

import Foundation
import FirebaseAuth

// CRUD FUNCTIONS

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    @Published var invalidAuth: String?
    
    let itemsKey: String = "Items_List"
    var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        getItems()
    }
    
    func getItems() {
        guard 
            let data = userDefaults.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        if !ifItemsFull() {
            items.append(newItem)
        }
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompetion()
        }
    }
    
    func ifItemsFull() -> Bool{
        if items.count >= 10 {
            return true
        }
        return false
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            userDefaults.set(encodedData, forKey: itemsKey)
        }
    }
    
    func login(userName: String, password: String, completion: @escaping (Bool) -> Void ) {
        Auth.auth().signIn(withEmail: userName, password: password) { (result, error) in
            if error != nil {
                self.invalidAuth = error?.localizedDescription ?? ""
            } else {
                print("Successesfully Signed-in")
                completion(true)
            }
            completion(false)
        }
    }
    
    func register(userName: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: userName, password: password) { (result, error) in
            if error != nil {
                self.invalidAuth = error?.localizedDescription ?? ""
            } else {
                print("Successesfully Registered")
                completion(true)
            }
            completion(false)
        }
    }
}
