//
//  AppUITests.swift
//  AppUITests
//
//  Created by user on 12/13/22.
//
import XCTest

final class AppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        let webViewsQuery = app.webViews

        let menuButton = webViewsQuery.buttons["menu"]
        menuButton.waitForExistence(timeout: 30)
        menuButton.tap()
        if (webViewsQuery.buttons["log out Abmeldung"].exists) {
            webViewsQuery.buttons["log out Abmeldung"].tap()
        } else {
            webViewsQuery.staticTexts["Anmeldung"].tap()
        }

        let urlTextField = webViewsQuery.textFields["https://xxx.xxx.xx"]
        
        urlTextField.clearText()
        snapshot("00LoginScreen")

        urlTextField.typeText("https://my.next.cloud")
        snapshot("01LoginScreen")

        urlTextField.clearText()
        urlTextField.typeText("http://192.168.178.25:8080")
        let loginBtn = webViewsQuery.buttons["login"]
        loginBtn.tap()

        let kanban = webViewsQuery.staticTexts["kanban"]
        let existence = kanban.waitForExistence(timeout: 30)
        XCTAssertTrue(existence)

        snapshot("02BoardOverviewScreen")

        kanban.tap()

        snapshot("03BoardDetailsScreen")

        let todo = webViewsQuery.buttons["todo"]
        let existence2 = todo.waitForExistence(timeout: 30)
        XCTAssertTrue(existence2)

        snapshot("04BoardDetailsScreen")

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//     func testLaunchPerformance() throws {
//         if #available(iOS 13.0, *) {
//             // This measures how long it takes to launch your application.
//             measure(metrics: [XCTApplicationLaunchMetric()]) {
//                 XCUIApplication().launch()
//             }
//         }
//     }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        // workaround for apple bug
        if let placeholderString = self.placeholderValue, placeholderString == stringValue {
            return
        }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}
