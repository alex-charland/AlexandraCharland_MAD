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
}

struct Ingredient : Codable{
    var name : String
    var nutrition : Nutrition
}

struct IngredientData : Codable {
    var category : String
    var ingredients : [Ingredient]
}
