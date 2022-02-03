//
//  ErrorView.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import SwiftUI

struct ErrorView: View {
    
    /// The errorValue, will to use which error need to show
    @Binding var errorValue: NetworkError?
    
    /// The Callback for sending the request for refresh the content of the List
    var refreshConnection: () -> Void

    var body: some View {
        VStack {
            Image(systemName: buttonIconName())
                .font(Font.system(size: 75))
                .font(Font.title)
            
            Text(getErrorText())
                .fontWeight(.regular)
                .font(Font.system(size: 15))
                .multilineTextAlignment(.center)
            
            addRefreshButton
        }
        .padding(50)
    }
   
    // MARK: - UI Methods

    /// This method is going to generate the TEXT which will go to visible in the view and describe the error to the user
    /// - Returns: String the description of the Error
    private func getErrorText() -> String {
        return errorValue?.errorDescriptionValue ?? ""
    }
    
    /// This method is going to generate the name of the image which will go to visible in the view
    /// - Returns: String the name of the system image
    private func buttonIconName() -> String {
        switch errorValue {
        case .noInternetConnection:
            return "wifi.exclamationmark"
        default:
            return "xmark.octagon"
        }
    }
    
    /// This view responsive to create and show either Image and Text of the error
    /// This will be according to the `NetworkError`
    @ViewBuilder
    private var addRefreshButton: some View {
        switch errorValue {
        case .noInternetConnection:
            Button(action: {
                self.refreshConnection()
            }, label: {
                Text("Try again")
            })
                .padding(.vertical, 10)
            
        case .searchArtworkListEmpty:
            EmptyView()
            
        default:
            EmptyView()
        }
    }
    
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorValue: .constant(NetworkError.invalidURL)) { }
    }
}
