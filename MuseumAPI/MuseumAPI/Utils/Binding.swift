//
//  Binding.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 20/01/2022.
//

import SwiftUI

extension Binding {
   
    ///Using this extension for the handle any changes and perform the operation accordingly.
    ///- Returns: A string containing a date formatted as RFC-822
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
