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
    var serving_size : String
    var calories : String
    var total_fat : String
    var saturated_fat : String
    var trans_fat : String
    var cholesterol : String
    var sodium : String
    var total_carbohydrates : String
    var dietary_fiber : String
    var sugar : String
    var protein : String
    var vitamin_a : String
    var calcium : String
    init(){
        serving_size = "1"
        calories = "120"
        total_fat = "9.0 g"
        saturated_fat = "4.5 g"
        trans_fat = "0.9 g"
        cholesterol = "7.8 mg"
        sodium = "163.9 mg"
        total_carbohydrates = "23 g"
        dietary_fiber = "0.4 g"
        sugar = "14.8 g"
        protein = "2 g"
        vitamin_a = "2%"
        calcium = "0%"
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
}
