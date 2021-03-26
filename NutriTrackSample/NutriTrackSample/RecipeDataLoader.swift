//
//  RecipeDataLoader.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import Foundation
class RecipeDataLoader{
    var recipeData = [RecipeData]()
    
    func loadData(filename: String){
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                recipeData = try plistdecoder.decode([RecipeData].self, from: data)
                
            } catch {
                // handle error
                print(error)
            }
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
    
    func addIngredient(index:Int, newIngredient:String, newIndex: Int){
        recipeData[index].ingredients.insert(newIngredient, at: newIndex)
    }

    func deleteIngredient(index:Int, currIndex: Int){
        recipeData[index].ingredients.remove(at: currIndex)
    }
}
