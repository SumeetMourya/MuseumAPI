//
//  ArtworkListDataModel.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import Foundation
import Combine

/// Status for managing the State of API request calling, and its value help to manage the UI of the View accordingly
enum ApiCallingStatus {
    /// when API is call is not start; The Default Value
    case notStarted
    /// When API request has been stared
    case inProgress
    /// When the API request is completed
    case completed
    /// When the API request has been failed
    case failed
}

struct ArtworkListDataModel: Codable {
    /// The Array of Int which is having the Artwork ID
    let objectIDs: [Int]?

    /// The Int of provide the total number of Artwork ID got in the API response
    let total: Int?
    
    enum CodingKeys: String, CodingKey  {
        case objectIDs, total
    }
    
    // MARK: Create the MOCK data for testing
    static func mockData() -> ArtworkListDataModel {
        let arrayOfArtworkIDs = [1000, 2000, 3000]
        return ArtworkListDataModel(objectIDs: arrayOfArtworkIDs, total: arrayOfArtworkIDs.count)
    }

    static func mockDataNil() -> ArtworkListDataModel {
        return ArtworkListDataModel(objectIDs: nil, total: nil)
    }
    
}

class Artwork: Identifiable, ObservableObject {

    /// the ArtworkDataModel which is having the Artwork Detail data
    @Published var artwork: ArtworkDataModel?
    
    /// the ApiCallingStatus which is holding the API request state
    @Published var apiStatus: ApiCallingStatus
    
    /// the Int use for the ObjectID of the Artwork
    var objectID: Int
    
    /// id is use for the confirming the Identifiable Protocol
    var id: String {
        return "\(objectID)"
    }
    
    init(objectID: Int, artwork: ArtworkDataModel? = nil, apiStatus: ApiCallingStatus = .notStarted) {
        self.objectID = objectID
        self.artwork = artwork
        self.apiStatus = apiStatus
    }
    
    // MARK: Create the MOCK data for testing
    static func mockData1() -> Artwork {
        return Artwork(objectID: 100000)
    }
    
    static func mockData2() -> Artwork {
        return Artwork(objectID: 200000)
    }
    
    static func mockData3() -> Artwork {
        return Artwork(objectID: 300000)
    }
    
}

