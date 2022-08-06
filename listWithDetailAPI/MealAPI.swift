//
//  MealAPI.swift
//  listWithDetailAPI
//
//  Created by Jeremy Gerald Prawira on 06/08/22.
//

import Foundation

final class MealAPI {
    
    static let shared = MealAPI()
    
    func fetchListMeal(onCompletion: @escaping([Meal]) -> ()) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard let data = data else {
                print("Data was nil")
                return
            }
            
            guard let mealList = try? JSONDecoder().decode(MealList.self, from: data) else {
                print("Could not decode the JSON")
                return
            }
            
            print(mealList.meal)
            onCompletion(mealList.meal)
        }
        
        task.resume()
    }
}

struct MealList : Codable {
    let meal: [Meal]
}

struct Meal: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}
