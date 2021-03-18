//
//  IngredientDataLoader.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import Foundation
class IngredientDataLoader{
    var ingredientData = [IngredientData]()
    
    func loadData(filename: String){
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                ingredientData = try plistdecoder.decode([IngredientData].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    
    func getCategories() -> [String]{
        var categories = [String]()
        for categ in ingredientData{
            categories.append(categ.category)
        }
        return categories
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
//
//    func deleteIngredient(index:Int, currIndex: Int){
//        ingredientData[index].ingredients.remove(at: currIndex)
//    }
}
