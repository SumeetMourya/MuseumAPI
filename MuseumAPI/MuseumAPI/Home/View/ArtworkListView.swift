//
//  ArtworkListView.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 21/01/2022.
//

import SwiftUI

struct ArtworkListView: View {

    /// The viewmodel which will take care of API call and data update in the View
    @State var viewModel: ArtworkViewModel
    
    /// The Callback for sending the request for refresh the content of the List
    var refreshContent: () -> Void

    var body: some View {
        List {
            ForEach(viewModel.artworks, id: \.id) { artworkValue in
                NavigationLink(destination: ArtworkDetailView(artworkID: artworkValue.objectID, artworkDetail: artworkValue.artwork)) {
                    SearchArtworkItemCell(data: artworkValue)
                        .id(artworkValue.objectID)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        }
        .listStyle(.plain)
        .refreshable {
            // Allowing user to Pull and Refresh the content of the List
            self.refreshContent()
        }
    }
    
}

struct ArtworkListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkListView(viewModel: ArtworkViewModel(service: APIService(network: Network(networkReachability: NetworkReachability()))), refreshContent: {})
    }
}
