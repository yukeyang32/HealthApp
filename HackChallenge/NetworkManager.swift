//
//  NetworkManager.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//
import Foundation
import Alamofire

class NetworkManager {
    private static let host = "https://healtheat.herokuapp.com"
    
    static func getActivities(completion: @escaping ([Activity]) -> Void) {
        let endpoint = "\(host)/api/activities/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let activitesData = try? jsonDecoder.decode(ActivityDataResponse.self, from: data) {
                    let activities = activitesData.data
                    completion(activities)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createFood(name:String, cal: Int, unit:String, completion: @escaping(NewFood)-> Void) {
        let endpoint = "\(host)/api/foods/"
        let params:[String:Any] = [
            "name":name,
            "calories_per_unit":cal,
            "unit":unit
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    try jsonDecoder.decode(NewFoodResponse.self, from: data)
                }
                catch {
                    print("\(error) causess failure")
                }
                if let foodData = try? jsonDecoder.decode(NewFoodResponse.self, from: data) {
                    let newFood = foodData.data
                    completion(newFood)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getFoodByName(foodName: String, completion: @escaping (Food) -> Void) {
        let endpoint = "\(host)/api/foods/\(foodName)/"
        AF.request(endpoint, method: .get, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    try jsonDecoder.decode(FoodDataResponse.self, from: data)
                } catch {
                    print("\(error) causes failure")
                }
                if let foodData = try? jsonDecoder.decode(FoodDataResponse.self, from: data) {
                    let food = foodData.data
                    completion(food)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addFoodToUser(food: Food, amount: Int, date: Date, completion: @escaping (Food) -> Void) {
        let endpoint = "\(host)/api/foods/\(food.name)/add/"
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let params:[String:Any] = [
            "user_id":1,
            "amount":amount,
            "year":year,
            "month":month,
            "day":day
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    try jsonDecoder.decode(AddFoodResponse.self, from: data)
                } catch {
                    print("\(error) causes failure")
                }
                if let foodData = try? jsonDecoder.decode(AddFoodResponse.self, from: data) {
                    let food = foodData.data
                    completion(food)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getFoodUserByDate(userId: Int, date: Date, completion: @escaping([UserFood]) -> Void) {
        let endpoint = "\(host)/api/food/date/\(userId)/"
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let params:[String: Any] = [
            "id":1,
            "year": year,
            "month": month,
            "day": day
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    try jsonDecoder.decode(GetFoodDateResponse.self, from: data)
                } catch {
                    print("\(error) causes failure")
                }
                if let dateData = try? jsonDecoder.decode(GetFoodDateResponse.self, from: data) {
                    let userFoods = dateData.data
                    completion(userFoods)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
