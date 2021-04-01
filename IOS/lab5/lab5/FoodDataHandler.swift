//
//  FoodDataHandler.swift
//  lab5
//
//  Created by Alexandra Charland on 3/9/21.
//

import Foundation
class FoodDataHandler {
    var foodData = FoodData()
    //property with a closure as its value
    //closure takes an array of Joke as its parameter and Void as its return type
    var onDataUpdate: ((_ data: [Food]) -> Void)?
    
    func loadjson(search: String){
        //based on API documentation
        //
        let headers = [
            "x-rapidapi-key": "d61d908e84mshdef79b45bca7fdep1609acjsn54e479260cdf",
            "x-rapidapi-host": "nutritionix-api.p.rapidapi.com"
        ]
        var allSearchTerms = search.components(separatedBy: " ")
        var urlSearchString = allSearchTerms[0]
        allSearchTerms.remove(at: 0)
        for term in allSearchTerms{//Account for spaces in search term
            urlSearchString = urlSearchString + "%20" + term
        }
        let urlPath = "https://nutritionix-api.p.rapidapi.com/v1_1/search/" + urlSearchString + "?fields=item_name%2Citem_id%2Cbrand_name%2Cnf_calories%2Cnf_total_fat%2Cnf_saturated_fat%2Cnf_cholesterol%2Cnf_sodium%2Cnf_dietary_fiber%2Cnf_sugars%2Cnf_protein"
        
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
            }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print(statusCode)
            guard statusCode == 200
                else {
                    print("file download error")
                    return
                }
            //download successful
            print("download complete")
            //parse json asynchronously
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }
    
    func parsejson(_ data: Data){
        do
        {
            foodData.hits.removeAll()
            let apiData = try JSONDecoder().decode(FoodData.self, from: data)
            for food in apiData.hits
            {
                foodData.hits.append(food)
                print(food)
            }
            print(foodData.hits.count)
            print(foodData.hits[0].fields.item_name)
        }
        catch let jsonErr
        {
            print("json error here")
            print(jsonErr.localizedDescription)
            return
        }
        print("parsejson done")
        //passing the results to the onDataUpdate closure
        onDataUpdate?(foodData.hits)
    }

    func getFood() -> [Food] {
        return foodData.hits
    }

}
