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
    
    func printComment(comment: HNComment){
        if let deleted = comment.deleted {
            if let kds = comment.children {
                print(kds.count)
            }
        }
        if let chs = comment.children {
            for c in chs {
                printComment(comment: c)
            }
        }
    }
    
    func testComment(){
        let comment = HNComment(item: 15062225)
        printComment(comment: comment)
    }
}
