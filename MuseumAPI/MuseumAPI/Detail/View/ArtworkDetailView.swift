//
//  ArtworkDetailView.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import SwiftUI

struct ArtworkDetailView: View {
    
    /// The viewModel will be use fot the further opriont and Initialized within the Initializes
    @StateObject var viewModel: ArtworkDetailViewModel
    
    /// The artworkID is Int, which will be the set from the Initializes
    private var artworkID: Int
    
    /// Initializes a new ArtworkDetailView with the artwork Id and its details parts and specifications.
    ///  - Parameters:
    ///     - artworkID: The id of the Artwork
    ///     - artworkDetail: The ArtworkDataModel of the Artwork is optional maybe we will get it from the Previous screen which we will going to use for creating the `ArtworkDetailViewModel`
    ///     
    /// - Returns: View/Screen object of ArtworkDetailView
    init(artworkID: Int, artworkDetail: ArtworkDataModel? = nil) {
        self.artworkID = artworkID
        _viewModel = StateObject(wrappedValue: ArtworkDetailViewModel(artworkID: artworkID, artworkDetail: artworkDetail, service: APIService(network: Network(networkReachability: NetworkReachability()))))
    }
    
    var body: some View {

        GeometryReader { geometry in
            ZStack(alignment: .top) {
                
                if viewModel.showingLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                } else if viewModel.error != nil {
                    ErrorView(errorValue: $viewModel.error, refreshConnection: {
                        viewModel.refreshContent()
                    })
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    
                } else {
                    list(geometry.size.width - 80)
                }
            }
            .onAppear {
                viewModel.getArtworkDetails()
            }
            .navigationTitle(navigationBarTitle)
        }
    }
    
    @ViewBuilder
    private func list(_ imageWidth: CGFloat) -> some View {
        if let artworkDetail = viewModel.artworkDetail {
            List(artworkDetail.getListOfDetails(), children: \.items) { row in
                ArtworkDetailCell(data: row, imageWidth: imageWidth)
            }
            .refreshable {
                viewModel.refreshContent()
            }
        }
    }
    
}

private extension ArtworkDetailView {
    var navigationBarTitle: String {
        if let artworkDetail = viewModel.artworkDetail,
           let title = artworkDetail.title {
            return title
        } else {
            return "\(artworkID)"
        }
    }
        
}


struct ArtworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkDetailView(artworkID: 53408)
    }
}
