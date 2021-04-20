//
//  Food.swift
//  lab5
//
//  Created by Alexandra Charland on 3/9/21.
//

import Foundation
struct FoodDetail: Decodable{
    let item_name: String
    let brand_name: String
    let nf_calories: Double?
    let nf_total_fat: Double?
    let nf_saturated_fat: Double?
    let nf_cholesterol: Double?
    let nf_sodium: Double?
    let nf_dietary_fiber: Double?
    let nf_sugars: Double?
    let nf_protein: Double?
//    let nf_trans_fatty_acid: Double
    let nf_total_carbohydrate: Double?
//    let nf_calcium_dv: Double
    let nf_serving_size_qty: Double?
//    let nf_vitamin_a_dv: Double
    let nf_serving_size_unit: String?
}
struct Food: Decodable {
    let _index: String
    let _score: Double
    var fields: FoodDetail
}

struct FoodData: Decodable {
    var total_hits: Int
    var max_score: Double
    var hits = [Food]()
    init(totHits : Int, maxS : Double){
        total_hits = totHits
        max_score = maxS
    }
}
