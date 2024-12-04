//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Shashwat Panda on 04/12/24.
//

import XCTest
@testable import ToDoList

class ListViewModelTests: XCTestCase {

    var viewModel: ListViewModel!
    var mockUserDefaults: MockUserDefaults!

    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaults()
        viewModel = ListViewModel(userDefaults: mockUserDefaults)
    }

    override func tearDown() {
        mockUserDefaults.clearStorage()
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Initialization and Data Retrieval
    func testInitialization_loadsSavedItems() {
        // Arrange
        let savedItems = [ItemModel(title: "Test Item", isCompleted: false)]
        let data = try? JSONEncoder().encode(savedItems)
        mockUserDefaults.set(data, forKey: viewModel.itemsKey)
        
        // Act
        viewModel = ListViewModel(userDefaults: mockUserDefaults)

        // Assert
        XCTAssertEqual(viewModel.items.count, 1)
        XCTAssertEqual(viewModel.items.first?.title, "Test Item")
    }

    // MARK: - Adding Items
    func testAddItem_addsItemToList() {
        // Act
        viewModel.addItem(title: "New Item")

        // Assert
        XCTAssertEqual(viewModel.items.count, 1)
        XCTAssertEqual(viewModel.items.first?.title, "New Item")
    }

    func testAddItem_doesNotAddIfFull() {
        // Arrange
        for i in 1...10 {
            viewModel.addItem(title: "Item \(i)")
        }
        
        // Act
        viewModel.addItem(title: "Extra Item")

        // Assert
        XCTAssertEqual(viewModel.items.count, 10)  // It should not exceed 10 items
    }

    // MARK: - Deleting Items
    func testDeleteItem_removesItemFromList() {
        // Arrange
        viewModel.addItem(title: "Item to Remove")
        
        // Act
        viewModel.deleteItem(indexSet: IndexSet(integer: 0))

        // Assert
        XCTAssertEqual(viewModel.items.count, 0)
    }

    // MARK: - Moving Items
    func testMoveItem_movesItemToNewIndex() {
        // Arrange
        viewModel.addItem(title: "Item 1")
        viewModel.addItem(title: "Item 2")
        
        // Act
        viewModel.moveItem(from: IndexSet(integer: 1), to: 0)

        // Assert
        XCTAssertEqual(viewModel.items[0].title, "Item 2")
        XCTAssertEqual(viewModel.items[1].title, "Item 1")
    }

    // MARK: - Updating Items
//    func testUpdateItem_updatesCompletionStatus() {
//        // Arrange
//        let item = ItemModel(title: "Item", isCompleted: false)
//        viewModel.addItem(title: item.title)
//
//        // Act
//        viewModel.updateItem(item: item.updateCompetion())
//
//        // Assert
//        XCTAssertTrue(viewModel.items.first?.isCompleted ?? false)
//    }

    // MARK: - Saving Items
    func testSaveItems_savesItemsToUserDefaults() {
        // Act
        viewModel.addItem(title: "Item to Save")

        // Assert
        let savedData = mockUserDefaults.data(forKey: viewModel.itemsKey)
        XCTAssertNotNil(savedData)
    }

    // MARK: - Checking Full List
    func testIfItemsFull_returnsTrueWhenListIsFull() {
        // Arrange
        for i in 1...10 {
            viewModel.addItem(title: "Item \(i)")
        }

        // Act
        let result = viewModel.ifItemsFull()

        // Assert
        XCTAssertTrue(result)
    }

    func testIfItemsFull_returnsFalseWhenListIsNotFull() {
        // Arrange
        for i in 1...5 {
            viewModel.addItem(title: "Item \(i)")
        }

        // Act
        let result = viewModel.ifItemsFull()

        // Assert
        XCTAssertFalse(result)
    }
}

