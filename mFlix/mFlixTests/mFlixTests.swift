//
//  mFlixTests.swift
//  mFlixTests
//
//  Created by Tanjim Hossain Sifat on 26/6/19.
//  Copyright © 2019 Tanjim Hossain Sifat. All rights reserved.
//

import XCTest
@testable import mFlix

class mFlixTests: XCTestCase {
    
    var databaseHelper : DatabaseHelper!

    override func setUp() {
        databaseHelper = DatabaseHelper()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCountFetch() {
        let movies = databaseHelper.fetch()
        XCTAssertGreaterThan(movies.count, 0, "Movie fetch count is zero")
    }

}
