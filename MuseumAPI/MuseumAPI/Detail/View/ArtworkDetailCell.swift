//
//  ArtworkDetailCell.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 21/01/2022.
//

import SwiftUI

struct ArtworkDetailCell: View {
    
    /// The ArtworkDetailListItem for the Artwork Details which is formed from `ArtworkDataModel`
    let data: ArtworkDetailListItem
    
    /// The CGFloat for tell view to make the Image width
    let imageWidth: CGFloat
    
    var body: some View {
        
        switch data.type {
        case .text(let value):
            textRow(title: data.title, value: value)
            
        case .image(let imageURL):
            ShowImage(imageURL: imageURL, imageWidth: imageWidth)
            
        case .link(let value):
            linkView(title: data.title, url: value)
        }
        
    }
    
    // MARK: - UI Methods

    /// This view responsive to create and show Text Details within the List Items
    ///  - Parameters:
    ///     - title: The String of the Title/Heading
    ///     - value: The Optional String of the subheading
    @ViewBuilder
    private func textRow(title: String, value: String?) -> some View {
        HStack(alignment: .center, spacing: 5, content: {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
            Spacer()
            Text(value ?? "")
                .multilineTextAlignment(.trailing)
                .font(.subheadline)
        })
    }
    
    /// This view responsive to create and show Link of the Wikipedia in the List Items
    ///  - Parameters:
    ///     - title: The String of the Title/Heading
    ///     - value: The Optional String for making the Link with markdown attribute string
    @ViewBuilder
    private func linkView(title: String, url: String?) -> some View {
        HStack(alignment: .center, spacing: 5, content: {
            Text(data.title)
                .fontWeight(.medium)
                .font(.body)
            Spacer()
            if let wikiurl = url, wikiurl.count > 0 {
                let wikiurlValue: String = "[Click here](\(wikiurl))"
                Text(wikiurlValue.markdownToAttributed())
                    .font(.body)
            } else {
                Text("No link available")
                    .multilineTextAlignment(.trailing)
                    .font(.body)
            }
        })
    }
    
}

struct ArtworkDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkDetailCell(data: ArtworkDetailListItem.mockData1(), imageWidth: 300)
    }
}
