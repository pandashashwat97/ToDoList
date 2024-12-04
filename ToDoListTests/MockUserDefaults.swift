//
//  MockUserDefaults.swift
//  ToDoListTests
//
//  Created by Shashwat Panda on 04/12/24.
//

import Foundation

class MockUserDefaults: UserDefaults {
    private var storage = [String: Any]()

    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }

    override func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }

    // This method simulates clearing the storage
    func clearStorage() {
        storage.removeAll()
    }
}


