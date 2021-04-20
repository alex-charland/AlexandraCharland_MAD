//
//  IngredientDataLoader.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import Foundation
class IngredientDataLoader{
    var ingredientData = [IngredientData]()
    
    func dataFileURL(_ filename:String) -> URL? {
        let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        var url : URL?
        url = urls.first?.appendingPathComponent(filename)
        return url
    }
    func loadInitialData(file : String){
        if let path = Bundle.main.url(forResource: file, withExtension: "plist"){
            let decoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: path)
                ingredientData = try decoder.decode([IngredientData].self, from: data)
            }
            catch{
                print("Could not load the data")
            }
        }
    }
    
    func loadData(file : String)->Bool{
        let fileURL = dataFileURL(file)
        if FileManager.default.fileExists(atPath: (fileURL?.path)!){
            let url = fileURL!
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                ingredientData = try decoder.decode([IngredientData].self, from: data)
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
            let encodedData = try encoder.encode(ingredientData)
            //write encoded data to the file
            try encodedData.write(to: fileURL!)
        } catch {
            print("write error")
        }
    }
    
    func getCategories() -> [String]{
        var categories = [String]()
        for categ in ingredientData{
            print("Categ",categ)
            categories.append(categ.category)
        }
        return categories
    }
    
    func addCategory(newCateg: String){
        let newCategory = IngredientData(newCateg: newCateg)
        ingredientData.append(newCategory)
    }
    func deleteCategory(index: Int){
        ingredientData.remove(at: index)
    }
    func getIngredients(index:Int) -> [Ingredient] {
        return ingredientData[index].ingredients
    }
    
    func addIngredient(categ:Int, newIngredient:Ingredient, newIndex:Int){
        ingredientData[categ].ingredients.insert(newIngredient, at: newIndex)
        print("New ingredient added")
        for i in ingredientData[categ].ingredients{
            print(i)
        }
    }
    
    func deleteIngredient(categ:Int, index: Int){
        ingredientData[categ].ingredients.remove(at: index)
    }
//
//    func deleteIngredient(index:Int, currIndex: Int){
//        ingredientData[index].ingredients.remove(at: currIndex)
//    }
}
