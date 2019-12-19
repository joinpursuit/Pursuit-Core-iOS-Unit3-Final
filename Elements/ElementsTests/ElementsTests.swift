//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by Cameron Rivera on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import Elements

class ElementsTests: XCTestCase {

    let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
    let postEndpointURL = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
    // Tests NetworkHelper
    func testPerformDataTask(){
        // Arrange
        guard let url = URL(string: elementEndpointURL) else{
            XCTFail("Could not create URL")
            return
        }
        let request = URLRequest(url: url)
        let exp = expectation(description: "Some Data is returned")
        
        // Act
        NetworkHelper.shared.performDataTask(request) { result in
            switch result{
            case .failure(let netError):
                XCTFail("\(netError)")
            case .success(let data):
                // Assert
                exp.fulfill()
                XCTAssertNotNil(data, "No data was returned.")
            }
        }
        wait(for: [exp], timeout: 5.0)
        
    }
    // Tests getElements from the ElementAPI structure
    func testGetElements(){
        // Arrange
        var elements = [Element]()
        let exp = expectation(description: "Get 100 Elements")
        let expectedCount = 100
        
        // Act
        
        ElementAPI.getElements { result in
            switch result{
            case .failure(let netError):
                XCTFail("\(netError)")
            case .success(let elementArr):
                elements =  elementArr
                // Assert
                exp.fulfill()
                XCTAssertEqual(elements.count, expectedCount, "\(elements.count) is not equal to \(expectedCount)")
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
    
    func testDecoding(){
        // Arrange
        var elements = [Element]()
        let exp = expectation(description: "Get Hyrdrogen")
        let expectedName = "Hydrogen"
        
        // Act
        
        ElementAPI.getElements { result in
            switch result{
            case .failure(let netError):
                XCTFail("\(netError)")
            case .success(let elementArr):
                elements = elementArr
                // Assert
                exp.fulfill()
                guard let firstElementName = elements.first?.name else{
                    XCTFail("Could not obtain first element in array of elements")
                    return
                }
                XCTAssertEqual(firstElementName, expectedName, "\(firstElementName) is not equal to \(expectedName)")
        }
        }
        wait(for: [exp], timeout: 5.0)
    }
}
