//
//  APIArtworkProtocol.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import Foundation

protocol NetworkArtworkDetailsProtocol {
    
    /// This Method gets call for getting the `ArtworkDataModel` in the callback for the given Artwork ID
    ///
    ///  - Parameter artwokrID: The Int for the ID of the any artwork for which we want to get the Details
    func getArtwork(_ artwokrID: Int, completion: @escaping ((Result<ArtworkDataModel, NetworkError>)) -> Void)
}
 
protocol NetworkArtworkListProtocol: NetworkArtworkDetailsProtocol {

    /// This Method gets call for getting the array of the Artwork IDs and the given name/string
    ///
    ///  - Parameter artwokrID: The Int for the ID of the any artwork for which we want to get the Details
    func getArtworkIDs(_ artworkName: String, completion: @escaping ((Result<ArtworkListDataModel, NetworkError>)) -> Void)
}

