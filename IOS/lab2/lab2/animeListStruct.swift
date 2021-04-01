//
//  animeListStruct.swift
//  lab2
//
//  Created by Alexandra Charland on 2/3/21.
//

import Foundation
struct AnimeList: Decodable {
    let genre: String
    let titles: [String]
}
