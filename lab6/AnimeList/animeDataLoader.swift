//
//  animeDataLoader.swift
//  AnimeList
//
//  Created by Alexandra Charland on 2/14/21.
//

import Foundation
class animeDataLoader{
    var animeData = [AnimeData]()
    
    func dataFileURL(_ filename:String) -> URL? {
        //returns an array of URLs for the document directory in the user's home directory
        let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        var url : URL?
        //append the file name to the first item in the array which is the document directory
        url = urls.first?.appendingPathComponent(filename)
        return url
    }
    func loadInitialAnimeData(file : String){
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
    func loadAnimeData(file : String)->Bool{
        //url of data file
        let fileURL = dataFileURL(file)
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: (fileURL?.path)!){
            let url = fileURL!
            do {
                //creates a data buffer with the contents of the plist
                let data = try Data(contentsOf: url)
                //create an instance of PropertyListDecoder
                let decoder = PropertyListDecoder()
                //decode the data using the structure of the Favorite class
                animeData = try decoder.decode([AnimeData].self, from: data)
            } catch {
                print("no file")
                }
        }
        else {
            return false
        }
        return true
    }
    func saveData(fileName: String){
        //url of data file
        let fileURL = dataFileURL(fileName)
        do {
            //create an instance of PropertyListEncoder
            let encoder = PropertyListEncoder()
            //set format type to xml
            encoder.outputFormat = .xml
            let encodedData = try encoder.encode(animeData)
            //write encoded data to the file
            try encodedData.write(to: fileURL!)
        } catch {
            print("write error")
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
