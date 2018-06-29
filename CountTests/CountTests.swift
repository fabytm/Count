//
//  CountTests.swift
//  CountTests
//
//  Created by Fabian Butean on 19/10/2017.
//  Copyright © 2017 Fabian Butean. All rights reserved.
//

import XCTest
@testable import Count

class CountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    //MARK: Count Class Tests
    
    //Confirm that the Counter initializer returns a Counter object when passed valid parameters.
    func testCounterInitializationSucceeds() {
        //Counter is at zero
        let zeroCountCounter = Counter.init(name:"Zero", count: 0)
        XCTAssertNotNil(zeroCountCounter)
        
        //High counter value
        let highCountCounter = Counter.init(name:"high", count: 329999)
        XCTAssertNotNil(highCountCounter)
    }
    
    
    //Confirm that the Counter initializer returns nil when passed a negative rating or an empty name.
    func testCounterInitializationFails() {
        //Negative count
        let negativeCountCounter = Counter.init(name:"negative", count: -1)
        XCTAssertNil(negativeCountCounter)
        
        //Empty string
        let emptyStringCounter = Counter.init(name: "", count: 0)
        XCTAssertNil(emptyStringCounter)
        
        //Count too low
        let tooLowCount = Counter.init(name:"tooHigh", count: -200)
        XCTAssertNil(tooLowCount)
        
    }
    
}
