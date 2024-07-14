//
//  DebouncingResponse.swift
//  MultiThreadingAndLocalDB
//
//  Created by Sparsh Chadha on 14/07/24.
//

import Foundation

struct RecipeResponse: Codable {
    let offset: Int
    let number: Int
    let results: [Recipe]
    let totalResults: Int
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
