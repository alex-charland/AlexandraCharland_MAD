//
//  RecipeDataLoader.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import Foundation
class RecipeDataLoader{
    var recipeData = [RecipeData]()
    
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
                recipeData = try decoder.decode([RecipeData].self, from: data)
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
                recipeData = try decoder.decode([RecipeData].self, from: data)
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
            let encodedData = try encoder.encode(recipeData)
            //write encoded data to the file
            try encodedData.write(to: fileURL!)
        } catch {
            print("write error")
        }
    }
    
    func getRecipes() -> [String]{
        var recipes = [String]()
        for recipe in recipeData{
            recipes.append(recipe.recipe)
        }
        return recipes
    }
    
    func getIngredients(index:Int) -> [String] {
        return recipeData[index].ingredients
    }
    
    func getNutrition(index:Int) -> Nutrition{
        return recipeData[index].nutrition
    }
    
    func addRecipe(index:Int, newRecipe:RecipeData){
        recipeData.insert(newRecipe, at: recipeData.endIndex)
        recipeData = recipeData.sorted{$0.recipe < $1.recipe}
    }
    func deleteRecipe(index: Int){
        recipeData.remove(at: index)
    }
    func addIngredient(index:Int, newIngredient:String, newIndex: Int){
        recipeData[index].ingredients.insert(newIngredient, at: newIndex)
    }

    func deleteIngredient(index:Int, currIndex: Int){
        recipeData[index].ingredients.remove(at: currIndex)
    }
}
