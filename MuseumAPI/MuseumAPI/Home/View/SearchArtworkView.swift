//
//  SearchArtworkView.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import SwiftUI
import Combine

struct SearchArtworkView: View {
    
    /// The height of the Search bar, using or create the search bar and the manage to show the List just below the Searchbar with using the padding
    private let heightOfSearhcBar: CGFloat = 50
    
    /// The viewmodel which will take care of API call and data update in the View
    @ObservedObject var viewModel: ArtworkViewModel = ArtworkViewModel(service: APIService(network: Network(networkReachability: NetworkReachability())))
 
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                
                ZStack(alignment: .top) {
                    
                    if viewModel.showingLoading {
                        //Show the Loading view
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    } else if viewModel.error != nil {
                        //Show the Error view
                        ErrorView(errorValue: $viewModel.error) {
                            viewModel.refreshSearch()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    } else {
                        //Show the List view of Artwork IDs
                        listView
                    }
                    
                    //This is Violate the YAGNI principle, but this would be the excellent api which is very useful just with 3-4 line we can get SearchBar
                    //But our requirment is not demanding either to use it's features or the wave it is implemented.
                    /*
                     .searchable(text: $viewModel.searchText,
                     placement: .navigationBarDrawer(displayMode: .always),
                     prompt: "Search Artwork")
                     */
                    
                    
                    Searchbar(text: $viewModel.searchText,
                              placeHolderText: "Search Artwork",
                              showDoneButton: true) { viewModel.clearText() }
                              .frame(height: heightOfSearhcBar)
                }
            }
            .navigationBarTitle(Text("Artworks"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
    }
    
    // MARK: - UI Methods

    /// This view responsive to create and show List of the Artwork ID first and
    /// then on the item/cell appear call the API for getting Artwork detailed data.
    @ViewBuilder
    private var listView: some View {
        ArtworkListView(
            viewModel: viewModel,
            refreshContent: {
                viewModel.refreshSearch()
            })
            .padding(.top, heightOfSearhcBar)
            .simultaneousGesture(
                DragGesture().onChanged({ _ in
                    UIApplication.shared.endEditing()
                }))
    }
    
}

struct SearchArtworkView_Previews: PreviewProvider {
    static var previews: some View {
        SearchArtworkView()
    }
}
