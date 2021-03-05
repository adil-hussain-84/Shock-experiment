//
//  ShockExperimentUITests.swift
//  ShockExperimentUITests
//
//  Created by Adil Hussain on 26/02/2021.
//

import XCTest
import Shock

class ShockExperimentUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var mockServer: MockServer!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["-mockServer"]
        
        mockServer = MockServer(port: 6789, bundle: Bundle(for: type(of: self)))
        mockServer.shouldSendNotFoundForMissingRoutes = true
        mockServer.start()
    }
    
    override func tearDown() {
        super.tearDown()
        mockServer.stop()
    }
    
    func test_app_launch_when_no_route_is_setup() {
        // When.
        app.launch()
        
        // Then.
        XCTAssertTrue(app.staticTexts["Failed getting characters."].waitForExistence(timeout: 1))
    }
    
    func test_app_launch_when_simple_route_is_setup_to_return_bad_request_status_code() {
        // Given.
        let route: MockHTTPRoute = .simple(
            method: .get,
            urlPath: "people",
            code: 400,
            filename: nil
        )
        
        mockServer.setup(route: route)
        
        // When.
        app.launch()
        
        // Then.
        XCTAssertTrue(app.staticTexts["Failed getting characters."].waitForExistence(timeout: 1))
    }
    
    func test_app_launch_when_simple_route_is_setup_to_return_ok_status_code() {
        // Given.
        let route: MockHTTPRoute = .simple(
            method: .get,
            urlPath: "people",
            code: 200,
            filename: "simple-response.json"
        )
        
        mockServer.setup(route: route)
        
        // When.
        app.launch()
        
        // Then.
        XCTAssertTrue(app.staticTexts["Got 0 characters."].waitForExistence(timeout: 1))
    }
    
    func test_app_launch_when_template_route_is_setup_to_return_ok_status_code() {
        // Given.
        let count = Int.random(in: 1...100)
        
        let route: MockHTTPRoute = .template(
            method: .get,
            urlPath: "people",
            code: 200,
            filename: "template-response.json",
            templateInfo: ["count": count]
        )
        
        mockServer.setup(route: route)
        
        // When.
        app.launch()
        
        // Then.
        XCTAssertTrue(app.staticTexts["Got \(count) characters."].waitForExistence(timeout: 1))
    }
    
    func test_app_launch_when_route_is_setup_to_timeout() {
        // Given.
        let route: MockHTTPRoute = .timeout(
            method: .get,
            urlPath: "people",
            timeoutInSeconds: 1
        )
        
        mockServer.setup(route: route)
        
        // When.
        app.launch()
        
        // Then.
        XCTAssertTrue(app.staticTexts["Failed getting characters."].waitForExistence(timeout: 3))
    }
}
