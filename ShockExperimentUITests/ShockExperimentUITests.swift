//
//  ShockExperimentUITests.swift
//  ShockExperimentUITests
//
//  Created by Adil Hussain on 26/02/2021.
//

import XCTest

class ShockExperimentUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    func test_getting_characters_fails_when_mock_server_is_not_setup() {
        let application = XCUIApplication()
        application.launchArguments = ["-mockServer"]
        application.launch()
        
        XCTAssertTrue(application.staticTexts["Failed getting characters."].waitForExistence(timeout: 3))
    }
}
