//
//  ShockExperimentUITests.swift
//  ShockExperimentUITests
//
//  Created by Adil Hussain on 26/02/2021.
//

import XCTest
import Shock

class ShockExperimentUITests: XCTestCase {
    
    private var mockServer: MockServer!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        mockServer = MockServer(port: 6789, bundle: Bundle(for: type(of: self)))
        mockServer.shouldSendNotFoundForMissingRoutes = true
        mockServer.start()
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.stop()
    }
    
    func test_getting_characters_fails_when_route_is_not_setup() {
        let application = XCUIApplication()
        application.launchArguments = ["-mockServer"]
        application.launch()
        
        XCTAssertTrue(application.staticTexts["Failed getting characters."].waitForExistence(timeout: 1))
    }
    
    func test_getting_characters_succeeds_when_simple_route_is_setup() {
        let route: MockHTTPRoute = .simple(
            method: .get,
            urlPath: "people",
            code: 200,
            filename: "simple-response.json"
        )
        
        mockServer.setup(route: route)
        
        let application = XCUIApplication()
        application.launchArguments = ["-mockServer"]
        application.launch()
        
        XCTAssertTrue(application.staticTexts["Got 0 characters."].waitForExistence(timeout: 1))
    }
    
    func test_getting_characters_succeeds_when_template_route_is_setup() {
        let route: MockHTTPRoute = .template(
            method: .get,
            urlPath: "people",
            code: 200,
            filename: "template-response.json",
            templateInfo: ["count": 2]
        )
        
        mockServer.setup(route: route)
        
        let application = XCUIApplication()
        application.launchArguments = ["-mockServer"]
        application.launch()
        
        XCTAssertTrue(application.staticTexts["Got 2 characters."].waitForExistence(timeout: 1))
    }
}
