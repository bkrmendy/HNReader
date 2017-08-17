//
//  HNReaderTests.swift
//  HNReaderTests
//
//  Created by Bertalan Kormendy on 2017. 08. 13..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//

import XCTest
@testable import HNReader

class HNReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPost() {
        let post = HNPost(json: 8863)
        print("\(post)")
    }
    
    func testComment(){
        let comment = HNComment(item: 2921983)
        print("\(comment)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
