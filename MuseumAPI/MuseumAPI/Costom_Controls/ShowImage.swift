//
//  Image.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 22/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowImage: View {
    
    /// The imageURL has an optional url type value, and will go to use for getting the image and show in the view
    @State var imageURL: URL?
    
    /// The imageWidth will store the width of the image in the view
    @State var imageWidth: CGFloat
    
    /// The fixedWidth has bool value and it will use for fixed the image width if it is true, otherwise it will adopt the width according to the Parent View, and the default value is `false`
    @State var fixedWidth: Bool = false

    var body: some View {
        primaryImageWithSDWebImageSwiftUI(imageURL, imageWidth: imageWidth)
    }
    
    // MARK: - UI Methods

    ///  This view responsive to create and show Image with the Apple AsyncImage API
    /// - Parameters:
    ///     - imageURL: URL type data which is optional because may be url in the data is nil
    ///     - imageWidth: the width of the image which we need show
    ///
    /// - Returns: Object of View of the Image image data
    @ViewBuilder
    private func primaryImage(_ imageURL: URL?, imageWidth: CGFloat) -> some View {

        if let encodedImageURL = imageURL {
            AsyncImage(url: encodedImageURL, transaction: .init(animation: .spring())) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .transition(.scale(scale: 0.01, anchor: .center))
                        .cornerRadius(10)
                        .padding(.vertical, 5)
                    
                case .failure(let error):
                    Text(error.localizedDescription)
                        .foregroundColor(.accentColor)
                        .frame(width: imageWidth, height: imageWidth)
                    
                case .empty:
                    ProgressView()
                        .frame(width: imageWidth, height: imageWidth / 2)
                    
                @unknown default:
                    Text("Image is not able to load here.")
                        .foregroundColor(.accentColor)
                        .frame(width: imageWidth)
                        .padding(40)
                }
            }
        } else {
            Text("Image url is not valid")
                .foregroundColor(.accentColor)
                .frame(width: imageWidth)
                .padding(40)
        }
    }

    ///  This view responsive to create and show Image with the SDWebImageSwiftUI, this is third party API
    /// - Parameters:
    ///     - imageURL: URL type data which is optional because may be url in the data is nil
    ///     - imageWidth: the width of the image which we need show
    ///
    /// - Returns: Object of View of the Image image data
    @ViewBuilder
    private func primaryImageWithSDWebImageSwiftUI(_ imageURL: URL?, imageWidth: CGFloat) -> some View {
        if let encodedImageURL = imageURL {
            if fixedWidth {
                WebImage(url: encodedImageURL)
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageWidth)
                    .cornerRadius(10)
                    .padding(.vertical, 10)

            } else {
                WebImage(url: encodedImageURL)
                    .resizable()
                    .indicator(.activity)
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding(.vertical, 5)
            }
        } else {
            Text("Image url is not valid")
                .foregroundColor(.accentColor)
                .frame(width: imageWidth)
                .padding(40)
        }
    }

}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        ShowImage(imageURL: URL(string: "https://images.metmuseum.org/CRDImages/ad/original/97955.jpg")!, imageWidth: 200, fixedWidth: true)
            .frame(width: 350.0, height: 100.0)
    }
}
