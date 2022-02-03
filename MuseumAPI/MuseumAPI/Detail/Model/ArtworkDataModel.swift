//
//  ArtworkDataModel.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import Foundation

/*
 {
 "objectID": 53408,
 "isHighlight": false,
 "accessionNumber": "2015.300.213",
 "accessionYear": "2015",
 "isPublicDomain": true,
 "primaryImage": "https://images.metmuseum.org/CRDImages/as/original/DP-12232-273.jpg",
 "primaryImageSmall": "https://images.metmuseum.org/CRDImages/as/web-large/DP-12232-273.jpg",
 "additionalImages": [
 "https://images.metmuseum.org/CRDImages/as/original/DP-12232-272.jpg"
 ],
 "constituents": [
 {
 "constituentID": 11829,
 "role": "Artist",
 "name": "Itō Jakuchū",
 "constituentULAN_URL": "http://vocab.getty.edu/page/ulan/500118864",
 "constituentWikidata_URL": "https://www.wikidata.org/wiki/Q1240575",
 "gender": ""
 }
 ],
 "department": "Asian Art",
 "objectName": "Hanging scroll",
 "title": "White Plum Blossoms and Moon",
 "culture": "Japan",
 "period": "Edo period (1615–1868)",
 "dynasty": "",
 "reign": "",
 "portfolio": "",
 "artistRole": "Artist",
 "artistPrefix": "",
 "artistDisplayName": "Itō Jakuchū",
 "artistDisplayBio": "Japanese, 1716–1800",
 "artistSuffix": "",
 "artistAlphaSort": "Itō Jakuchū",
 "artistNationality": "",
 "artistBeginDate": "1716",
 "artistEndDate": "1800",
 "artistGender": "",
 "artistWikidata_URL": "https://www.wikidata.org/wiki/Q1240575",
 "artistULAN_URL": "http://vocab.getty.edu/page/ulan/500118864",
 "objectDate": "1755",
 "objectBeginDate": 1755,
 "objectEndDate": 1755,
 "medium": "Hanging scroll; ink and color on silk",
 "dimensions": "Image: 55 3/8 × 31 1/4 in. (140.7 × 79.4 cm)\r\nOverall with mounting: 8 ft. 5 15/16 in. × 38 7/16 in. (259 × 97.6 cm) \r\nOverall with knobs: 8 ft. 5 15/16 in. × 41 1/8 in. (259 × 104.5 cm)",
 "measurements": [
 {
 "elementName": "Image",
 "elementDescription": null,
 "elementMeasurements": {
 "Height": 140.7,
 "Width": 79.4
 }
 },
 {
 "elementName": "Overall with knobs",
 "elementDescription": null,
 "elementMeasurements": {
 "Height": 259,
 "Width": 104.5
 }
 },
 {
 "elementName": "Overall with mounting",
 "elementDescription": null,
 "elementMeasurements": {
 "Height": 259,
 "Width": 97.6
 }
 }
 ],
 "creditLine": "Mary Griggs Burke Collection, Gift of the Mary and Jackson Burke Foundation, 2015",
 "geographyType": "",
 "city": "",
 "state": "",
 "county": "",
 "country": "",
 "region": "",
 "subregion": "",
 "locale": "",
 "locus": "",
 "excavation": "",
 "river": "",
 "classification": "Paintings",
 "rightsAndReproduction": "",
 "linkResource": "",
 "metadataDate": "2022-01-11T04:42:13.55Z",
 "repository": "Metropolitan Museum of Art, New York, NY",
 "objectURL": "https://www.metmuseum.org/art/collection/search/53408",
 "tags": [
 {
 "term": "Flowers",
 "AAT_URL": "http://vocab.getty.edu/page/aat/300132399",
 "Wikidata_URL": "https://www.wikidata.org/wiki/Q506"
 },
 {
 "term": "Trees",
 "AAT_URL": "http://vocab.getty.edu/page/aat/300132410",
 "Wikidata_URL": "https://www.wikidata.org/wiki/Q10884"
 }
 ],
 "objectWikidata_URL": "https://www.wikidata.org/wiki/Q78759658",
 "isTimelineWork": false,
 "GalleryNumber": ""
 }*/

struct ArtworkDataModel: Codable {
    
    /// the message, only will having the String data when API response for and error
    let message: String?
    let objectID: Int?
    let isHighlight: Bool?
    let accessionNumber, accessionYear: String?
    let isPublicDomain: Bool?
    let primaryImage, primaryImageSmall: String?
    let additionalImages: [String]?
    let constituents: [Constituent]?
    let department, objectName, title, culture: String?
    let period, dynasty, reign, portfolio: String?
    let artistRole, artistPrefix, artistDisplayName, artistDisplayBio: String?
    let artistSuffix, artistAlphaSort, artistNationality, artistBeginDate: String?
    let artistEndDate, artistGender: String?
    let artistWikidataURL: String?
    let artistULANURL: String?
    let objectDate: String?
    let objectBeginDate, objectEndDate: Int?
    let medium, dimensions: String?
    let measurements: [Measurement]?
    let creditLine, geographyType, city, state: String?
    let county, country, region, subregion: String?
    let locale, locus, excavation, river: String?
    let classification, rightsAndReproduction, linkResource, metadataDate: String?
    let repository: String?
    let objectURL: String?
    let tags: [Tag]?
    let objectWikidataURL: String?
    let isTimelineWork: Bool?
    let galleryNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case message, objectID, isHighlight, accessionNumber, accessionYear, isPublicDomain, primaryImage, primaryImageSmall, additionalImages, constituents, department, objectName, title, culture, period, dynasty, reign, portfolio, artistRole, artistPrefix, artistDisplayName, artistDisplayBio, artistSuffix, artistAlphaSort, artistNationality, artistBeginDate, artistEndDate, artistGender
        case artistWikidataURL = "artistWikidata_URL"
        case artistULANURL = "artistULAN_URL"
        case objectDate, objectBeginDate, objectEndDate, medium, dimensions, measurements, creditLine, geographyType, city, state, county, country, region, subregion, locale, locus, excavation, river, classification, rightsAndReproduction, linkResource, metadataDate, repository, objectURL, tags
        case objectWikidataURL = "objectWikidata_URL"
        case isTimelineWork
        case galleryNumber = "GalleryNumber"
    }
}

extension ArtworkDataModel {
    
    /// Generate the list of the detail items which will gotin to render in the list in Detail View
    /// - Returns: Array of the ArtworkDetailListItem which will help us to render these data in every good List
    func getListOfDetails() -> [ArtworkDetailListItem] {
        var list: [ArtworkDetailListItem] = [ArtworkDetailListItem]()
        
        list.append(ArtworkDetailListItem(title: "", type: .image(self.primaryImageURL)))

        //Adding the Title of the Artwork
        if let artworkTitle = self.title,
           artworkTitle.count > 0 {
            list.append(ArtworkDetailListItem(title: "Title", type: .text(artworkTitle)))
        }
        
        //Adding the Access Numebr of the Artwork
        if let artworkAccessionNumber = self.accessionNumber,
           artworkAccessionNumber.count > 0 {
            list.append(ArtworkDetailListItem(title: "Accession Number", type: .text(artworkAccessionNumber)))
        }

        //Adding the Department of the Artwork
        if let artworkDepartment = self.department,
           artworkDepartment.count > 0 {
            list.append(ArtworkDetailListItem(title: "Department", type: .text(artworkDepartment)))
        }
        
        //Adding the ObjectName of the Artwork
        if let artworkObjectName = self.objectName,
           artworkObjectName.count > 0 {
            list.append(ArtworkDetailListItem(title: "Type of Artwork", type: .text(artworkObjectName)))
        }
        
        //Adding the Culture of the Artwork
        if let artworkCulture = self.culture,
           artworkCulture.count > 0 {
            list.append(ArtworkDetailListItem(title: "Culture", type: .text(artworkCulture)))
        }
        
        //Adding the Artist Name and Bio of the Artwork
        if let artworkArtistDisplayName = self.artistDisplayName,
           artworkArtistDisplayName.count > 0 {
            var artistNameBio = artworkArtistDisplayName
            if let artistDisplayBioValue = self.artistDisplayBio,
               artistDisplayBioValue.count > 0 {
                artistNameBio += "(\(artistDisplayBioValue))"
            }
            list.append(ArtworkDetailListItem(title: "Artist", type: .text(artistNameBio)))
        }
        
        //Adding the Object Date of the Artwork
        if let artworkObjectDate = self.objectDate,
           artworkObjectDate.count > 0 {
            list.append(ArtworkDetailListItem(title: "Date", type: .text(artworkObjectDate)))
        }
        
        //Adding the Medium Object
        if let artworkMedium = self.medium,
           artworkMedium.count > 0 {
            list.append(ArtworkDetailListItem(title: "Medium", type: .text(artworkMedium)))
        }
        
        //Adding creditLine of the Artwork
        if let artworkCreditLine = self.creditLine,
           artworkCreditLine.count > 0 {
            list.append(ArtworkDetailListItem(title: "Credit Line", type: .text(artworkCreditLine)))
        }

        //Adding Dimensions/Measurments of the Art
        if let artworkDimensions = self.dimensions,
           artworkDimensions.count > 0 {
            list.append(ArtworkDetailListItem(title: "Dimensions", type: .text(artworkDimensions)))
        }
        if let artMeasurementsValues = self.measurements,
           artMeasurementsValues.count > 0 {
            
            var measurements: [ArtworkDetailListItem] = [ArtworkDetailListItem]()
            
            for valueOf in artMeasurementsValues {
                
                if let name = valueOf.elementName {
                    var dimensions: [ArtworkDetailListItem] = [ArtworkDetailListItem]()
                    
                    if let elementMeasurements = valueOf.elementMeasurements {
                        
                        if let diameter = elementMeasurements.diameter {
                            dimensions.append(ArtworkDetailListItem(title: "Diameter", type: .text("\(diameter)")))
                        }
                        if let height = elementMeasurements.height {
                            dimensions.append(ArtworkDetailListItem(title: "Height", type: .text("\(height)")))
                        }
                        if let width = elementMeasurements.width {
                            dimensions.append(ArtworkDetailListItem(title: "Width", type: .text("\(width)")))
                        }
                        if let length = elementMeasurements.length {
                            dimensions.append(ArtworkDetailListItem(title: "Length", type: .text("\(length)")))
                        }
                        if let thickness = elementMeasurements.thickness {
                            dimensions.append(ArtworkDetailListItem(title: "Thickness", type: .text("\(thickness)")))
                        }
                        if let weight = elementMeasurements.weight {
                            dimensions.append(ArtworkDetailListItem(title: "Weight", type: .text("\(weight)")))
                        }
                    }
                    measurements.append(ArtworkDetailListItem(title: name, type: .text(nil), items: dimensions))
                }
                
            }
            
            list.append(ArtworkDetailListItem(title: "Measurements", type: .text(nil), items: measurements))
        }
        
        //Adding a Wikipedia link of the Artwork if exists in the data of the response
        if let wikipediaURL = self.artistWikidataURL {
            list.append(ArtworkDetailListItem(title: "Wikipedia", type: .link(wikipediaURL)))
        }
        
        return list
    }
    
}

extension ArtworkDataModel {
        
    /// Create the Image URL, first we check the string url is present or not,
    /// If present then create URL with string Encoded form, so that we can support the every type of url string
    /// whihc is having any type charaters(e.g. .+).
    /// This property is going to use for showing the Image in the Detail View
    var primaryImageURL: URL? {
        guard let primaryImageURL = self.primaryImage,
              let encodedImageURLString = primaryImageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedImageURL = URL(string: encodedImageURLString) else {
                  return nil
              }
        return encodedImageURL
    }

    /// Create the Image URL, first we check the string url is present or not,
    /// If present then create URL with string Encoded form, so that we can support the every type of url string
    /// whihc is having any type charaters(e.g. .+).
    /// This property is going to use for showing the Image in th List View, within Search View
    var smallImageURL: URL? {
        guard let primaryImageURL = self.primaryImageSmall,
              let encodedImageURLString = primaryImageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedImageURL = URL(string: encodedImageURLString) else {
                  return nil
              }
        return encodedImageURL
    }

}

extension ArtworkDataModel {
    
    static func mockDataOnlyID() -> ArtworkDataModel {
        return ArtworkDataModel(message: nil, objectID: 1000, isHighlight: nil, accessionNumber: nil, accessionYear: nil, isPublicDomain: nil, primaryImage: nil, primaryImageSmall: nil, additionalImages: nil, constituents: nil, department: nil, objectName: nil, title: nil, culture: nil, period: nil, dynasty: nil, reign: nil, portfolio: nil, artistRole: nil, artistPrefix: nil, artistDisplayName: nil, artistDisplayBio: nil, artistSuffix: nil, artistAlphaSort: nil, artistNationality: nil, artistBeginDate: nil, artistEndDate: nil, artistGender: nil, artistWikidataURL: nil, artistULANURL: nil, objectDate: nil, objectBeginDate: nil, objectEndDate: nil, medium: nil, dimensions: nil, measurements: nil, creditLine: nil, geographyType: nil, city: nil, state: nil, county: nil, country: nil, region: nil, subregion: nil, locale: nil, locus: nil, excavation: nil, river: nil, classification: nil, rightsAndReproduction: nil, linkResource: nil, metadataDate: nil, repository: nil, objectURL: nil, tags: nil, objectWikidataURL: nil, isTimelineWork: nil, galleryNumber: nil)
    }
    
}

/// This is the Type of the List Item which will help us render the Artwork deatiled data over
enum ListItemType {
    /// Show the data type is of Image and it will having the optional URL type value
    case image(URL?)
    
    /// Show the data type is of Text and it will having the optional String type value
    case text(String?)

    /// Show the data type is of link and it will having the optional STring type value
    case link(String?)
}

struct ArtworkDetailListItem: Identifiable {
    let id = UUID()
    let title: String
    var type: ListItemType
    var items: [ArtworkDetailListItem]?
    
    static func mockData1() -> ArtworkDetailListItem {
        return ArtworkDetailListItem(title: "Title", type: .text(nil))
    }
}


// MARK: - Constituent
struct Constituent: Codable {
    let constituentID: Int?
    let role, name: String?
    let constituentULANURL: String?
    let constituentWikidataURL: String?
    let gender: String?
    
    enum CodingKeys: String, CodingKey {
        case constituentID, role, name
        case constituentULANURL = "constituentULAN_URL"
        case constituentWikidataURL = "constituentWikidata_URL"
        case gender
    }
}

// MARK: - Measurement
struct Measurement: Codable {
    let elementName: String?
    let elementMeasurements: ElementMeasurements?
}

// MARK: - ElementMeasurements
struct ElementMeasurements: Codable {
    let height, width, diameter, length, thickness, weight: Double?
    
    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case width = "Width"
        case diameter = "Diameter"
        case length = "Length"
        case thickness = "Thickness"
        case weight = "Weight"
    }
}

// MARK: - Tag
struct Tag: Codable {
    let term: String?
    let aatURL: String?
    let wikidataURL: String?
    
    enum CodingKeys: String, CodingKey {
        case term
        case aatURL = "AAT_URL"
        case wikidataURL = "Wikidata_URL"
    }
}
