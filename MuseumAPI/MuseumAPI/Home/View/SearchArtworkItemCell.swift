//
//  SearchArtworkItemCell.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import SwiftUI
import Combine
import MapKit

struct SearchArtworkItemCell: View {
    
    @StateObject var viewModel: ArtworkCellViewModel

    /// Initializes a new SearchArtworkItemCell with the type of View of the List
    /// - Parameters:
    ///     - data: The object of the Artwork,
    ///
    /// - Returns: object of SearchArtworkItemCell
    init (data: Artwork) {
        _viewModel = StateObject(wrappedValue: ArtworkCellViewModel(service: APIService(network: Network(networkReachability: NetworkReachability())), artworkValue: data))
    }
    
    var body: some View {
        HStack(spacing: 10) {
            getImage
            Divider()
                .padding(.vertical, 10)
            setDetailText
        }
        .onAppear(perform: {
            if viewModel.artworkData.apiStatus != .completed {
                viewModel.artworkData.apiStatus = .inProgress
                viewModel.getArtworkDetails()
            }
        })
        .padding(.leading, 10)
    }
    
    // MARK: - UI Methods

    /// This view responsive to create and show either Image or loading or placeholder image
    /// which will be according to the api status enum type value
    @ViewBuilder
    private var getImage: some View {
        
        switch viewModel.artworkData.apiStatus {
        case .notStarted, .failed:
            Image(systemName: "person.crop.artframe")
                .font(Font.system(size: 20))
                .foregroundColor(.accentColor)
                .frame(width: 60, height: 60, alignment: .center)

        case .completed:
            if let artwork = viewModel.artworkData.artwork,
               let smallImageURL = artwork.smallImageURL {
                ShowImage(imageURL: smallImageURL, imageWidth: 60, fixedWidth: true)
            } else {
                Image(systemName: "person.crop.artframe")
                    .font(Font.system(size: 20))
                    .foregroundColor(.accentColor)
                    .frame(width: 60, height: 60, alignment: .center)
            }
            
        default:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .frame(width: 60, height: 60, alignment: .center)
        }
    }

    /// This view responsive to create and show either Artwork ID or Artwork Details
    /// which will be according to the api status enum type value
    @ViewBuilder
    private var setDetailText: some View {
        switch viewModel.artworkData.apiStatus {
        case .notStarted, .inProgress:
            Text("\(viewModel.artworkData.objectID)")
                .fontWeight(.light)
                .font(.body)

        case .completed:
            if let artwork = viewModel.artworkData.artwork {

                VStack (alignment: .leading, spacing: 5) {
                    if let title = artwork.title,
                        title.count > 0 {
                        Text(title)
                            .fontWeight(.regular)
                            .font(.subheadline)
                    }
                    
                    if let artistDisplayName = artwork.artistDisplayName,
                       artistDisplayName.count > 0 {
                        Text(artistDisplayName)
                            .fontWeight(.light)
                            .font(.caption)
                    }
                }
                .padding(.vertical, 10)
            } else {
                Text("\(viewModel.artworkData.objectID)")
                    .fontWeight(.light)
                    .font(.body)
            }
            
        case .failed:
            VStack (alignment: .leading, spacing: 5) {
                Text("\(viewModel.artworkData.objectID)")
                    .fontWeight(.light)
                    .font(.body)
                
                Text("Data download failed")
                    .fontWeight(.light)
                    .font(.caption)
            }
            .padding(.vertical, 10)
        }
    }

}

struct SearchArtworkItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchArtworkItemCell(data: Artwork.mockData2())
    }
}
