//
//  ChaiMobileTaskUITests.swift
//  ChaiMobileTaskUITests
//
//  Created by Seongwuk Park on 23/05/22.
//

import XCTest

class ChaiMobileTaskUITests: XCTestCase {
    private static let defaultTimeout: TimeInterval = 3
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        deleteMyApp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func deleteMyApp() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        XCUIApplication().terminate()

        let bundleDisplayName = "ChaiMobileTask"

        let icon = springboard.icons[bundleDisplayName]
        if icon.exists {
            icon.press(forDuration: 1)

            let buttonRemoveApp = springboard.buttons["Remove App"]
            if buttonRemoveApp.waitForExistence(timeout: 5) {
                buttonRemoveApp.tap()
            } else {
                XCTFail("Button \"Remove App\" not found")
            }

            let buttonDeleteApp = springboard.alerts.buttons["Delete App"]
            if buttonDeleteApp.waitForExistence(timeout: 5) {
                buttonDeleteApp.tap()
            }
            else {
                XCTFail("Button \"Delete App\" not found")
            }

            let buttonDelete = springboard.alerts.buttons["Delete"]
            if buttonDelete.waitForExistence(timeout: 5) {
                buttonDelete.tap()
            }
            else {
                XCTFail("Button \"Delete\" not found")
            }
        }
    }
    
    func testAddRemoveTask() throws {
        let app = XCUIApplication()
        
        // UI tests must launch the application that they test.
        app.launch()
        
        // TODO: Test the presence of the navigation bar title
        let titleText = app.navigationBars.staticTexts["TO DO"].firstMatch
        XCTAssert(titleText.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
        
        let scrollView = app.scrollViews.element(boundBy: 0)
        let emptyTaskView = scrollView.descendants(matching: .any)["emptyTaskView"].firstMatch
        XCTAssert(emptyTaskView.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
        
        let trailingItem = app.navigationBars.buttons["img_add"].firstMatch
        XCTAssert(trailingItem.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
        trailingItem.tap()
        
        let editButton = app.buttons["ic_edit_48"].firstMatch
        XCTAssert(editButton.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
        editButton.tap()
        
        let textField = app.textFields["NEW TASK"].firstMatch
        XCTAssert(textField.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
        
        let stringVal = textField.value as? String
        if !(stringVal?.isEmpty ?? true) {
            if let textValue = stringVal?.map({ _ in XCUIKeyboardKey.delete.rawValue }).joined(separator: "") {
                textField.typeText(textValue)
            }
        }
        textField.typeText("Task #1" + XCUIKeyboardKey.return.rawValue)
        
        let deleteButton = app.buttons["ic_delete_48"].firstMatch
        XCTAssert(deleteButton.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
        deleteButton.tap()
        
        let okayButton = app.buttons["okayButton"].firstMatch
        XCTAssert(okayButton.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
        okayButton.tap()
        
        XCTAssert(emptyTaskView.waitForExistence(timeout: ChaiMobileTaskUITests.defaultTimeout))
    }
    
    private func wait(timeout: TimeInterval) {
        wait(for: [expectation(description: "Wait for n seconds")], timeout: timeout)
    }
}
