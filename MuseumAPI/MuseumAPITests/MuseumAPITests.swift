//
//  MuseumAPITests.swift
//  MuseumAPITests
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import XCTest
import Combine

@testable import MuseumAPI

class MuseumAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    var subscriptions = Set<AnyCancellable>()

    func testGettingArtworkIdsSuccessWithMockData() {
        let result = Result<ArtworkListDataModel, NetworkError>.success(ArtworkListDataModel.mockData())
        let viewModel = ArtworkViewModel(service: APIMockServiceArtworkList(result: result, resultWithDetails: Result<ArtworkDataModel, NetworkError>.failure(.noInternetConnection)))
        let promise = expectation(description: "Getting Artwork Ids are not there")

        viewModel.getArtworkIDs(for: "MockData")
        viewModel.$artworks.sink { artworks in
            if artworks.count > 0 {
                print("artworks.count: \(artworks.count)")
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 60)
    }

    func testNotGettingArtworkIdsSuccessMockData() {
        let result = Result<ArtworkListDataModel, NetworkError>.success(ArtworkListDataModel.mockDataNil())
        let viewModel = ArtworkViewModel(service: APIMockServiceArtworkList(result: result, resultWithDetails: Result<ArtworkDataModel, NetworkError>.failure(NetworkError.searchArtworkListEmpty("SumeetMourya"))))

        let promise = expectation(description: "Getting Artwork Ids are there.")

        viewModel.getArtworkIDs(for: "SumeetMourya")
        viewModel.$artworks.sink { value in
            if value.count == 0 {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        wait(for: [promise], timeout: 300)
    }
    
}
