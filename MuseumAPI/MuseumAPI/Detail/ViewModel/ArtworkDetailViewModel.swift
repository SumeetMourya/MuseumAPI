//
//  ArtworkDetailViewModel.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 21/01/2022.
//

import Foundation

class ArtworkDetailViewModel: ObservableObject {
    
    /// The artworkDetail will go to the detailed data of the artwork this is optional, and initialized within the Initializer, and we can set from API request's response
    @Published var artworkDetail: ArtworkDataModel?
    
    /// The Error which update is depending on the API calls
    @Published var error: NetworkError? = nil

    /// The Bool this is holding the state of showing the loading
    @Published var showingLoading: Bool = false
    
    /// The NetworkArtworkListProtocol for calling the API request
    private let service: NetworkArtworkDetailsProtocol

    /// The artworkID is Int, which will be the set from the Initializes
    private let artworkID: Int
    
    /// Initializes a new ArtworkViewModel with the type of service
    /// - Parameters:
    ///     - artworkID: The id of the Artwork
    ///     - artworkDetail: The ArtworkDataModel of the Artwork is optional maybe we will get it from the Previous screen which we will going to use for creating the `ArtworkDetailViewModel`
    ///     - service: The object of the Network Service Protocol, which is having default Value `APIService()`
    ///
    /// - Returns: Object of ArtworkDetailViewModel which we will use in ArtworkDetailView
    init(artworkID: Int, artworkDetail: ArtworkDataModel?, service: NetworkArtworkDetailsProtocol) {
        self.service = service
        self.artworkID = artworkID
        self.artworkDetail = artworkDetail
    }
    
    /// In this method we are going to call the api for getting the Detail Of the Artwork
    /// Only when we dont have the data, we put this condition becuse we are also downloading the details data on SearhcView also and pass to this ViewModel to
    /// If we open the detail view before we downloaded data in search view for this Artwork Item,
    /// Then need to downlaod over here, Otherwise there is no need to download the data
    ///  - Precondition: `artworkDetail` is null then the function will execute and send request for getting the ArtworkDetails
    func getArtworkDetails() {
        guard artworkDetail == nil else { return }
        
        showingLoading = true
        removeError()
        
        service.getArtwork(self.artworkID) { (response) in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.showingLoading = false
                switch response {
                case .success(let data):
                    self.artworkDetail = data
                    
                case .failure(let errorValue):
                    self.error = errorValue
                }
            }
        }
    }
    
    ///This method will reshresh the current Artwork data
    ///Here we need to set the `artworkDetail` to nil sotaht we can request to download the new data
    func refreshContent() {
        HapticManager.notification(type: .success)
        artworkDetail = nil
        getArtworkDetails()
    }
 
    // MARK: - Private Methods
    ///This Method remove the Error, if any error set previuous
    ///Because which will remove the ErrorView From VIEW.
    private func removeError() {
        self.error = nil
    }
    

}
