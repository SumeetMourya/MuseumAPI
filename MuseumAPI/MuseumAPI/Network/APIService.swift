//
//  APIService.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import Foundation

class APIService {
    
    /// The baseURL, is the domain of the path
    private let baseURL = "https://collectionapi.metmuseum.org/"
    
    /// The apiPath, is the path component of the API path
    private let apiPath = "public/collection/v1/"
    
    private let networkReachability: NetworkReachability = NetworkReachability()
    
    private let networkObject: Network
    
    init(network: Network) {
        networkObject = network
    }
    
}

extension APIService: NetworkArtworkDetailsProtocol {
   
    /// This Method gets call for getting the `ArtworkDataModel` in the callback for the given Artwork ID
    ///
    ///  - Parameter artwokrID: The Int for the ID of the any artwork for which we want to get the Details
    ///
    ///  - Precondition: `networkReachability.checkConnection()` there should be internet connectivity, then will go further in the method otherwise it will return the callback with `.failure(.noInternetConnection)`
    ///
    ///  - Precondition: generated `url` from the String should be complete `URL`. Otherwise, return the callback with `.failure(.invalidURL)`
    func getArtwork(_ artworkID: Int, completion: @escaping ((Result<ArtworkDataModel, NetworkError>)) -> Void) {

        guard let url = URL(string: self.baseURL.appending(self.apiPath).appending("objects/\(artworkID)")) else {
            return completion(.failure(.invalidURL))
        }

        self.networkObject.requestData(url.absoluteString, of: ArtworkDataModel.self) { (response) in
            switch response {
            case .success(let value):
                if let message = value.message {
                    completion(.failure(NetworkError.apiCallError(message)))
                    return
                }
                completion(.success(value))
                
            case .failure(let error):
                switch error {
                case let decodingError as DecodingError:
                    completion(.failure(.parsing(decodingError)))
                case let apiError as NetworkError:
                    completion(.failure(apiError))
                default:
                    completion(.failure(NetworkError.unknown))
                }
            }
        }
    }
    
}

extension APIService: NetworkArtworkListProtocol {

    /// This Method gets call for getting the array of the Artwork IDs and the given name/string
    ///
    ///  - Parameter artwokrID: The Int for the ID of the any artwork for which we want to get the Details
    ///
    ///  - Precondition: `networkReachability.checkConnection()` there should be internet connectivity, then will go further in the method otherwise it will return the callback with `.failure(.noInternetConnection)`
    ///
    ///  - Precondition: `artworkName` should not be an empty string, otherwise return the callback with `.failure(.artworkNameEmpty)`
    ///
    ///  - Precondition: `addingPercentEncoding` when we convert the string encoding is should be a value, otherwise it will return the callback with `.failure(.invalidURL)`
    ///
    ///  - Precondition: generated `url` from the String should be complete `URL`. Otherwise, return the callback with `.failure(.invalidURL)`
    func getArtworkIDs(_ artworkName: String, completion: @escaping ((Result<ArtworkListDataModel, NetworkError>)) -> Void) {
        guard !artworkName.isEmpty else {
            return completion(.failure(.artworkNameEmpty))
        }
        
        guard let encodedArtworkName = artworkName.trimmingCharacters(in: .whitespaces).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return completion(.failure(.invalidURL))
        }
        
        let urlString = self.baseURL.appending(self.apiPath).appending("search?q=\(encodedArtworkName)")
        guard let url = URL(string: urlString) else {
            return completion(.failure(.invalidURL))
        }
        
        self.networkObject.requestData(url.absoluteString, of: ArtworkListDataModel.self) { (response) in
            switch response {
            case .success(let value):
                if value.objectIDs == nil {
                    completion(.failure(NetworkError.searchArtworkListEmpty(artworkName)))
                }
                completion(.success(value))
            case .failure(let error):
                switch error {
                case let decodingError as DecodingError:
                    completion(.failure(.parsing(decodingError)))
                case let apiError as NetworkError:
                    completion(.failure(apiError))
                default:
                    completion(.failure(NetworkError.unknown))
                }
            }
        }
    }
    
}
