//
//  ArtworkCellViewModel.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 01/02/2022.
//

import Foundation
import Combine
import SwiftUI

class ArtworkCellViewModel: ObservableObject {
    
    /// The Array of the Artwork Which having the Artwork ID and then update the Detail object which i
    @Published var artworkData: Artwork
    
    /// The Error which update is depending on the API calls
    @Published var error: NetworkError? = nil

    /// The Bool this is holding the state of showing the loading
    @Published var showingLoading: Bool = false
    
    let dispatchQueue = DispatchQueue(label: "myQueue", qos: .utility)

    /// The AnyCancellable for holding the subscriber to live the object
    private var subscriptions = Set<AnyCancellable>()
    
    /// The NetworkArtworkListProtocol for calling the API request
    private let service: NetworkArtworkListProtocol
    
    /// Initializes a new ArtworkViewModel with the type of service
    /// - Parameters:
    ///     - service: The object of the Network Service Protocol, which is having default Value `APIService()`
    ///
    /// - Returns: object of ArtworkViewModel which we will use in SearchArtworkView
    init(service: NetworkArtworkListProtocol, artworkValue: Artwork) {
        self.service = service
        self.artworkData = artworkValue
    }

    /// This will call for getting the detail of the artwork
    /// Once the request completed then the data will going to set to the specific artwork which send the detail request
    func getArtworkDetails() {

        dispatchQueue.async {
            self.service.getArtwork(self.artworkData.objectID) { (response) in
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    
                    switch response {
                    case .success(let data):
                        guard let objectIDValue = data.objectID else { return }
                        self.artworkData = Artwork(objectID: objectIDValue,
                                                            artwork: data,
                                                            apiStatus: .completed)
                        
                    case .failure:
                        self.artworkData = Artwork(objectID: self.artworkData.objectID, apiStatus: .failed)
                        
                    }
                }
            }
        }

    }
}
