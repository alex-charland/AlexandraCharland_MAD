//
//  NutritionInfo.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import Foundation
struct RecipeData : Codable {
    var recipe : String
    var ingredients : [String]
    var nutrition : Nutrition
    init(newName : String, allIngredients : [String]){
        recipe = newName
        ingredients = allIngredients
        nutrition = Nutrition()
    }
}

struct Nutrition : Codable{
    var serving_size : Double
    var serving_size_unit : String
    var calories : Double
    var total_fat : Double
    var saturated_fat : Double
    var trans_fat : Double
    var cholesterol : Double
    var sodium : Double
    var total_carbohydrates : Double
    var dietary_fiber : Double
    var sugar : Double
    var protein : Double
    var vitamin_a : Double
    var calcium : Double
    init(){
        serving_size = 0.0
        serving_size_unit = ""
        calories = 0.0
        total_fat = 0.0 //g
        saturated_fat = 0.0 //g
        trans_fat = 0.0 //g
        cholesterol = 0.0 //mg
        sodium = 0.0 //mg
        total_carbohydrates = 0.0 //g
        dietary_fiber = 0.0 //g
        sugar = 0.0 //g
        protein = 0.0 //g
        vitamin_a = 0//%
        calcium = 0//%
    }
}

struct Ingredient : Codable{
    var name : String
    var nutrition : Nutrition
    init(newName: String){
        name = newName
        nutrition = Nutrition()
    }
}

struct IngredientData : Codable {
    var category : String
    var ingredients : [Ingredient]
    init(newCateg: String){
        category = newCateg
        ingredients = [Ingredient]()
    }
}

