//
//  APIMockService.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 23/01/2022.
//

import Foundation

struct APIMockServiceDArtworketails: NetworkArtworkDetailsProtocol {
    
    /// The result is the type of Result and having the value of the specific test with mock data
    var result: Result<ArtworkDataModel, NetworkError>
    func getArtwork(_ artwokrID: Int, completion: @escaping ((Result<ArtworkDataModel, NetworkError>)) -> Void) {
        completion(result)
    }

}

struct APIMockServiceArtworkList: NetworkArtworkListProtocol {
   
    /// The result is the type of `Result<ArtworkListDataModel, NetworkError>` and having the value of the specific test with mock data for List Item of the Artwork
    var result: Result<ArtworkListDataModel, NetworkError>
    
    /// The resultWithDetails is the type of `Result<ArtworkDataModel, NetworkError>` and having the value of the specific test with mock data for ArtworkDetail
    var resultWithDetails: Result<ArtworkDataModel, NetworkError>
    
    func getArtworkIDs(_ artworkName: String, completion: @escaping ((Result<ArtworkListDataModel, NetworkError>)) -> Void) {
        completion(result)
    }

    func getArtwork(_ artwokrID: Int, completion: @escaping ((Result<ArtworkDataModel, NetworkError>)) -> Void) {
        completion(resultWithDetails)
    }
    
}
