//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by Yuliia Engman on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest
@testable import Elements

class ElementsTests: XCTestCase {
    
    func testModel() {
    let dataFromJSON = """
[
    {
        "id": "1",
        "category": "metalloid",
        "melt": 2349,
        "boil": 4200,
        "period": 2,
        "symbol": "B",
        "discovered_by": "Joseph Louis Gay-Lussac",
        "molar_heat": 11.087,
        "phase": "Solid",
        "source": "https://en.wikipedia.org/wiki/Boron",
        "summary": "Boron is a metalloid chemical element with symbol B and atomic number 5. Produced entirely by cosmic ray spallation and supernovae and not by stellar nucleosynthesis, it is a low-abundance element in both the Solar system and the Earth's crust. Boron is concentrated on Earth by the water-solubility of its more common naturally occurring compounds, the borate minerals.",
        "favoritedBy": "Pascal",
        "number": 5,
        "appearance": "black-brown",
        "density": 2.08,
        "atomic_mass": 10.81,
        "name": "Boron"
    },
    {
        "id": "2",
        "category": "alkali metal",
        "melt": 370.944,
        "boil": 1156.09,
        "period": 3,
        "symbol": "Na",
        "discovered_by": "Humphry Davy",
        "molar_heat": 28.23,
        "phase": "Solid",
        "source": "https://en.wikipedia.org/wiki/Sodium",
        "summary": "Sodium /ˈsoʊdiəm/ is a chemical element with symbol Na (from Ancient Greek Νάτριο) and atomic number 11. It is a soft, silver-white, highly reactive metal. In the Periodic table it is in column 1 (alkali metals), and shares with the other six elements in that column that it has a single electron in its outer shell, which it readily donates, creating a positively charged atom - a cation.",
        "favoritedBy": "Edison",
        "number": 11,
        "appearance": "silvery white metallic",
        "density": 0.968,
        "atomic_mass": 22.989769282,
        "name": "Sodium"
    }
]
""".data(using: .utf8)!
        
        let expectedEelementsCount = 2
        
        //act
        let searchResults = try! JSONDecoder().decode([Element].self, from: dataFromJSON)
        //let elements = searchResults
        
        //assert
        XCTAssertEqual(searchResults.count, expectedEelementsCount)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
