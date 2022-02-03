//
//  NetwerokAPI.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 01/02/2022.
//

import Foundation
import Alamofire

/// This is the type of the Error, which we can get at the different stage of API call
enum NetworkError: Error {
    /// The invalidURL, let us the given url is invalid
    case invalidURL
    
    /// The badResponse, let us know the badResponse with the specific status Code
    case badResponse(statusCode: Int)
    
    /// The unknown, let us know that the request in having an unknown error
    case unknown
    
    /// The searchArtworkListEmpty, let us know that search artwork is not found any data with the Specific Name/String
    case searchArtworkListEmpty(String)
    
    /// The noInternetConnection, let us know that user is not connected to any connection
    case noInternetConnection
    
    /// The apiCallError, let us know, while calling the API we got and error with the specific string value
    case apiCallError(String)
    
    /// The artworkNameEmpty, let us know that when we show the user that he/she dint search anything yet
    case artworkNameEmpty
    
    /// The artworkObjectIdIsEmpty, let us know that the id of the Artwork is empty. In the rare case, but might be possible
    case artworkObjectIdIsEmpty
    
    /// The DecodingError, let us know, while calling the API we got and error for related to the Decoding with the specific Error value
    case parsing(DecodingError?)
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescriptionValue: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .badResponse(statusCode: let statusCode):
            return "Sorry, something went wrong and error code is \(statusCode)"
        case .unknown:
            return "Unknown error occured, Please try later on"
        case .searchArtworkListEmpty(let artworkName):
            return "Could not find any artwork with \"\(artworkName)\"."
        case .noInternetConnection:
            return "You are not connected to internet."
        case .apiCallError(let error):
            return "Sorry, something went wrong and with error: \(error)"
        case .artworkNameEmpty:
            return "Artwork name is not provided yet."
        case .artworkObjectIdIsEmpty:
            return "Artwork Object ID is empty."
        case .parsing:
            return "Sorry, something went wrong."
        }
    }
}


class Network {
    
    /// The networkReachability, is the object of `NetworkReachability` which we will use for checking the Internet connectivity
    private let networkReachability: NetworkReachability
    
    init(networkReachability: NetworkReachability) {
        self.networkReachability = networkReachability
    }

    func requestData<T: Codable>(_ url: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, of: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard networkReachability.checkConnection() else {
            return completion(.failure(NetworkError.noInternetConnection))
        }

        AF.request(
            url,
            method:method,
            parameters: parameters)
            .responseDecodable(of: T.self) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
