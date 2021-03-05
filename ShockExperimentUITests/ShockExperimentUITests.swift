//
//  ShockExperimentUITests.swift
//  ShockExperimentUITests
//
//  Created by Adil Hussain on 26/02/2021.
//

import XCTest
import Shock

class ShockExperimentUITests: XCTestCase {
    
    private var application: XCUIApplication!
    private var mockServer: MockServer!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        application = XCUIApplication()
        application.launchArguments = ["-mockServer"]
        
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
        application.launch()
        
        // Then.
        XCTAssertTrue(application.staticTexts["Failed getting characters."].waitForExistence(timeout: 1))
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
        application.launch()
        
        // Then.
        XCTAssertTrue(application.staticTexts["Failed getting characters."].waitForExistence(timeout: 1))
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
        application.launch()
        
        // Then.
        XCTAssertTrue(application.staticTexts["Got 0 characters."].waitForExistence(timeout: 1))
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
        application.launch()
        
        // Then.
        XCTAssertTrue(application.staticTexts["Got \(count) characters."].waitForExistence(timeout: 1))
    }
}
