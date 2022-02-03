//
//  StringExtension.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 22/01/2022.
//

import Foundation

extension String {
    
    /// This will support the Markdown Content, in Text.
    /// What ever the content we want to style with MarkDown.
    ///- Returns: A AttributedString containing a Markdown content
    func markdownToAttributed() -> AttributedString {
        do {
            return try AttributedString(markdown: self) /// convert to AttributedString
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
}
