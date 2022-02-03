//
//  Searchbar.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import SwiftUI

struct Searchbar: View {
   
    /// The text, this will be the binding object so that we have the sync the text in the ViewModel also.
    @Binding var text: String
    
    /// The placeHolderText, will the text which will be visible as the placeholder of the Search Bar
    @State var placeHolderText: String
    
    /// The showDoneButton, will be visible side by the Searchbar. If we want to show the Done button, then we can Show it with this property, but the action on this right now just to dismiss the keyboard if we want to change we can
    @State var showDoneButton: Bool = false

    @State private var isEditing: Bool = false

    /// We implement this function closure because we want to clear the text and list as well, which ViewModel method will do, but we want to clear list and the text immediately as the user provide action on this button. Because in ViewModel we are calling the method which will do the same task, but with 1 second delay and this delay is debounce for not to call api on every character insert or delete.
    var clearText: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment.bottom) {
                HStack {
                    TextField(placeHolderText, text: $text)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                
                                
                                if isEditing, self.text.count > 0 {
                                    Button(action: {
                                        self.clearText()
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            self.isEditing = true
                        }
                        .frame(height: 50)
                    
                    if isEditing, showDoneButton {
                        Button(action: {
                            self.isEditing = false
                            // Dismiss the keyboard
                            UIApplication.shared.endEditing()
                        }) {
                            Text("Done")
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                    }
                }
                Divider()
            }
        }
    }
}
