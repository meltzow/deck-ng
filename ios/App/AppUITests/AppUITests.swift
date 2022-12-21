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
        snapshot("00LoginScreen")
        let urlTextField = webViewsQuery.textFields["url"]
        urlTextField.typeText("https://my.next.cloud")
        snapshot("01LoginScreen")

        urlTextField.typeText("http://192.168.178.25:8080")
        webViewsQuery.buttons["Anmeldung"].tap()

        snapshot("02BoardOverviewScreen")

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
