//
//  PickerData.swift
//  lab2
//
//  Created by Alexandra Charland on 2/3/21.
//

import Foundation
class PickerData {
    var animeList = [AnimeList]()
    func loadData(filename: String){
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist"){
            let plistdecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                animeList = try plistdecoder.decode([AnimeList].self, from: data)
            }
            catch{
                print("Cannot load data")
            }
        }
    }
    func getGenres() -> [String]{
        var genres = [String]()
        for genre in animeList{
            genres.append(genre.genre)
        }
        return genres
    }
    func getTitles(index: Int) -> [String]{
        return animeList[index].titles
    }
}
