//
//  animeDataLoader.swift
//  AniDetail
//
//  Created by Alexandra Charland on 2/27/21.
//

import Foundation
class DataLoader{
    var animeData = [AnimeData]()
    
    func loadData(fileName: String){
        if let path = Bundle.main.url(forResource: fileName, withExtension: "plist"){
            //creates a property list decoder object
            let decoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: path)
                //decodes the property list
                animeData = try decoder.decode([AnimeData].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    
    func getAnime() -> [String]{
        var allAnime = [String]()
        for anime in animeData{
            allAnime.append(anime.title)
        }
        return allAnime
    }
    
    func getURL(index:Int) -> String {
        return animeData[index].url
    }
}
