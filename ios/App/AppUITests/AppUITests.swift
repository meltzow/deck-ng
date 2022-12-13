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
        let webViewsQuery = app.webViews.webViews.webViews
        snapshot("00LoginScreen")
        let urlTextField = webViewsQuery.textFields["url"]
        urlTextField.typeText("https://my.next.cloud")
        snapshot("01LoginScreen")
        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Anmeldung"]/*[[".otherElements[\"Ionic App\"]",".otherElements[\"main\"].buttons[\"Anmeldung\"]",".buttons[\"Anmeldung\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app/*@START_MENU_TOKEN@*/.webViews.webViews.webViews.buttons["Anmelden"]/*[[".otherElements[\"BrowserView?IsPageLoaded=true&WebViewProcessID=2122\"].webViews.webViews.webViews",".otherElements.matching(identifier: \"Nextcloud\")",".otherElements[\"Inhalt\"].buttons[\"Anmelden\"]",".buttons[\"Anmelden\"]",".webViews.webViews.webViews"],[[[-1,4,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0]]@END_MENU_TOKEN@*/.tap()


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
