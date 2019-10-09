//
//  CakeListSwiftTests.swift
//  CakeListSwiftTests
//
//  Created by Henry Tsang on 08/10/2019.
//  Copyright © 2019 Henry Tsang. All rights reserved.
//

import XCTest
@testable import CakeListSwift

class CakeListSwiftTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Test Data for Cake model
    func testData() -> Cake {
        let cake = Cake(title: "title", desc: "desc", imageURL: "imageURL")
        return cake
    }
    //Tests a cake has the correct fields at the first index
    func testCakeIndex() {
        let testViewModel = CakeListViewModel()
        let cake = testData()
        testViewModel.cakes.append(cake)
        
        let cakeTest = testViewModel.cakeAtIndex(index: 0)
        XCTAssertEqual(cakeTest.title, "title");
        XCTAssertEqual(cakeTest.desc, "desc");
        XCTAssertEqual(cakeTest.imageURL, "imageURL");
    }
    //Tests image caching and the cached image
    func testImageCache() {
        let testViewModel = CakeListViewModel()
        let cake = testData()
        
        let testImage = UIImage.init(named: "imageNotFound")!
        testViewModel.cacheCakeImage(image: testImage, cake: cake)
        
        let cachedImage = testViewModel.cakeImageCache(cake: cake)
        XCTAssertEqual(testImage, cachedImage)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
