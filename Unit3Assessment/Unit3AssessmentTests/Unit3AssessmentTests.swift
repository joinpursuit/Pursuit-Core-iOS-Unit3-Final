//
//  Unit3AssessmentTests.swift
//  Unit3AssessmentTests
//
//  Created by Ahad Islam on 12/12/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import XCTest
@testable import Unit3Assessment

class Unit3AssessmentTests: XCTestCase {

    func testGetJSON() {
        let endpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        let name = "Hydrogen"
        let exp = XCTestExpectation(description: "JSON decoded successfully")
        var elements = [Element]()
        
        GenericCoderService.manager.getJSON(objectType: [Element].self, with: endpointURL) { result in
            switch result {
            case .failure(let error):
                print("Error occured getting JSON \(error)")
            case .success(let elementsFromAPI):
                elements = elementsFromAPI
                XCTAssertEqual(elements[0].name, name)
                XCTAssertEqual(elements[98].elementNumberInString, "099", "Was expecting something lol.")
                XCTAssertEqual(elements[9].elementNumberInString, "010")
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 20.0)
    }
    
    func testStupidNumber() {
        let string1 = "000"
        let number = 0
        let string2 = "00\(number)"
        
        XCTAssertEqual(string1, string2)
        
        let string3 = "001"
        let number2 = 1
        let string4 = "00\(number2)"
        
        XCTAssertEqual(string3, string4)
    }
    
    func testFavoriteJSON() {
        let getURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        let id = "Carbon"
        let exp = XCTestExpectation(description: "JSON decoded successfully")
        var favorites = [Favorite]()
        
        GenericCoderService.manager.getJSON(objectType: [Favorite].self, with: getURL) { (result) in
            switch result {
            case .failure(let error):
                XCTFail("Error occured getting JSON: \(error)")
            case .success(let favoritesFromAPI):
                favorites = favoritesFromAPI
                XCTAssertEqual(id, favorites[0].name, "it all went wrong")
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 20.0)
    }
    
    func testPostJSON() {
//        let postURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
//        let favorite = Favorite(favoritedBy: "ahad", elementName: "Hydrogen", elementSymbol: "H")
//        let exp = XCTestExpectation(description: "Successfully encoded project")
//        GenericCoderService.manager.postJSON(object: favorite, with: postURL) { (result) in
//            switch result {
//            case .failure(let error):
//                print("Error occured during encoding: \(error)")
//            case .success:
//                exp.fulfill()
//            }
//        }
//
//        wait(for: [exp], timeout: 20)
    }
    
    func testReduce() {
        let stupidArray = [1,2,3,5,6]
        let highestNum = 6
        let stupidArrayHighestNumber = stupidArray.reduce(Int.min, { $0 > $1 ? $0 : $1 } )
        
        XCTAssertEqual(highestNum, stupidArrayHighestNumber)
    }
    
    func testAnActualPostJSON() {
//        let postURL = "https://5df40792f9e7ae0014801788.mockapi.io/api/v1/favorites"
//        let favorite = Favorite(favoritedBy: "Ahad", elementName: "Hydrogen", elementSymbol: "H")
//        let exp = XCTestExpectation(description: "Successfully posted project.")
//        GenericCoderService.manager.postJSON(object: favorite, with: postURL) { (result) in
//            switch result {
//            case .failure(let error):
//                debugPrint(error)
//            case .success:
//                exp.fulfill()
//            }
//        }
//
//        wait(for: [exp], timeout: 20)
    }
    
    func testDeleteJSON() {
        let deleteURL = "https://5df40792f9e7ae0014801788.mockapi.io/api/v1/favorites/1"
        let exp = XCTestExpectation(description: "Succesffuly deleted project")
        GenericCoderService.manager.deleteJSON(with: deleteURL) { (result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success:
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 20)
    }
    
    func testActualGetJSON() {
        let getURL = "https://5df40792f9e7ae0014801788.mockapi.io/api/v1/favorites"
        let userID = 1
        let exp = XCTestExpectation(description: "Succesfully got project.")
        var favorites = [Favorite]()
        GenericCoderService.manager.getJSON(objectType: [Favorite].self, with: getURL) { (result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let favoritesFromAPI):
                favorites = favoritesFromAPI
                print(favorites.count)
                print(favorites[0].id)
                XCTAssertNotNil(favorites[0].id, "REAL Assertion that i should be doing.")
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 20)

    }
    
    func testStupidString() {
        let endURL = "https://5df40792f9e7ae0014801788.mockapi.io/api/v1/favorites"
        let expURL = "https://5df40792f9e7ae0014801788.mockapi.io/api/v1/favorites/1"
        let dumbURL = endURL + "/1"
        XCTAssertEqual(expURL, dumbURL)
    }
    
    func testEqualUrls() {
        let otherURL = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        let endURL = "https://5df40792f9e7ae0014801788.mockapi.io/api/v1/favorites"
        
        XCTAssertEqual(otherURL, endURL)
    }
    
    func testNewPostJSON() {
//        let newURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
//        let favorite = Favorite(favoritedBy: "Ahad", elementName: "Carbon", elementSymbol: "C")
//        let exp = XCTestExpectation(description: "Succesfully posted object.")
//        GenericCoderService.manager.postJSON(object: favorite, with: newURL) { result in
//            switch result {
//            case .failure(let error):
//                XCTFail("\(error)")
//            case .success:
//                exp.fulfill()
//            }
//        }
//        wait(for: [exp], timeout: 20)
    }
    
    func testNewDeleteJSON() {
        let newURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites/13"
        let exp = XCTestExpectation(description: "Succesfully deleted object.")
        GenericCoderService.manager.deleteJSON(with: newURL) { result in
            switch result {
            case .failure(let error):
                XCTFail("\(error)")
            case .success:
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 20)
    }
    
    func testAnotherElementJSON() {
        let newNEWURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements_remaining"
        var elements = [Element]()
        let exp = XCTestExpectation(description: "Succesfully decoded object.")
        GenericCoderService.manager.getJSON(objectType: [Element].self, with: newNEWURL) { (result) in
            switch result {
            case .failure(let error):
                XCTFail("\(error)")
            case .success(let elementsFromAPI):
                elements = elementsFromAPI
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 5)
    }
}
