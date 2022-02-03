//
//  ArtworkViewModel.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import Foundation
import Combine

class ArtworkViewModel: ObservableObject {
    
    /// The Array of the Artwork Which having the Artwork ID and then update the Detail object which it
    @Published var artworks: [Artwork] = [Artwork]()
    
    /// The Error which update is depending on the API calls
    @Published var error: NetworkError? = nil

    /// The Bool this is holding the state of showing the loading
    @Published var showingLoading: Bool = false

    /// The String and its subscriber using for calling of the API of getting Artwork IDs
    @Published var searchText = ""
    
    let dispatchQueue = DispatchQueue(label: "myQueue", qos: .background)

    /// The AnyCancellable for holding the subscriber to live the object
    private var subscriptions = Set<AnyCancellable>()
    
    /// The NetworkArtworkListProtocol for calling the API request 
    private let service: NetworkArtworkListProtocol
    
    /// Initializes a new ArtworkViewModel with the type of service
    /// - Parameters:
    ///     - service: The object of the Network Service Protocol, which is having default Value `APIService()`
    ///     
    /// - Returns: object of ArtworkViewModel which we will use in SearchArtworkView
    init(service: NetworkArtworkListProtocol) {
        self.service = service

        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { textValue in
                if let errorfound = self.error, case .artworkNameEmpty = errorfound, textValue.count == 0 { return }
                self.getArtworkIDs(for: textValue)
            } )
            .store(in: &subscriptions)
    }
    
    // MARK: - Private Methods

    /// This will call for getting the Array of the artwork' ID
    ///  - Parameter name: The String for user type and search for artwork
    ///  - Precondition: `name` string count must be greater than 0
    private func getArtWorks(_ name: String) {
        if name.isEmpty {
            error = NetworkError.artworkNameEmpty
            artworks.removeAll()
        } else {
            removeError()
            artworks.removeAll()
            showingLoading = true
            service.getArtworkIDs(name) { (response) in
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    
                    self.showingLoading = false
                    switch response {
                    case .success(let data):
                        if let idsOfArtwork = data.objectIDs {
                            let foundArtwork = idsOfArtwork.map({ (artworkIDValue) in
                                return Artwork(objectID: artworkIDValue)
                            })
                            self.artworks = foundArtwork.sorted { $0.objectID < $1.objectID }//foundArtwork
                        }
                        
                    case .failure(let errorValue):
                        self.error = errorValue
                    }
                }
            }
        }
    }
    
    ///This Method remove the Error, if any error set previuous
    ///Because which will remove the ErrorView From VIEW.
    private func removeError() {
        self.error = nil
    }
    
    // MARK: - Public Methods
    
    /// This method will clear the text of the Search bar view,
    /// Set the error to Artwotk Name empty
    /// Also remove all the element from List
    func clearText() {
        error = NetworkError.artworkNameEmpty
        searchText = ""
        artworks.removeAll()
    }
    
    /// This method will reshresh the current list
    func refreshSearch() {
        HapticManager.notification(type: .success)
        artworks.removeAll()
        getArtWorks(searchText)
    }
    
    /// This method will call for getting the Artwork for the given name
    ///  - Parameter name: The string for which api will going to call
    func getArtworkIDs(for name: String) {
        self.getArtWorks(name)
    }
    
}
