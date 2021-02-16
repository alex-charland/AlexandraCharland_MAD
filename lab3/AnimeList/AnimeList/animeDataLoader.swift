//
//  animeDataLoader.swift
//  AnimeList
//
//  Created by Alexandra Charland on 2/14/21.
//

import Foundation
class animeDataLoader{
    var animeData = [AnimeData]()
    func loadAnimeData(file : String){
        if let path = Bundle.main.url(forResource: file, withExtension: "plist"){
            let decoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: path)
                animeData = try decoder.decode([AnimeData].self, from: data)
            }
            catch{
                print("Could not load the data")
            }
        }
    }
    
    func getGenres() -> [String]{
        var genres = [String]()
        for genre in animeData{
            genres.append(genre.genre)
        }
        return genres
    }
    func getTitles(index: Int) -> [String]{
        return animeData[index].titles
    }
    func addTitle(index: Int, newTitle: String, titleIndex: Int){
        animeData[index].titles.insert(newTitle, at: titleIndex)
    }
    func deleteTitle(index: Int, titleIndex: Int){
        animeData[index].titles.remove(at: titleIndex)
    }
}
