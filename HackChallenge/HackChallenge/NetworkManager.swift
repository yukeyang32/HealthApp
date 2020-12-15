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
                    // Instructions: Use completion to handle response
                    completion(activitesData.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getActivitiesByDateAndId(date: Date, completion: @escaping ([ActivityByDate]) -> Void) {
        let endpoint = "\(host)/api/activities/date/1/"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "M"
        let month = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "d"
        let day = Int(dateFormatter.string(from: date))

        let parameters = ["year":year,"month":month,"day":day]
        AF.request(endpoint,  method: .post , parameters:parameters, encoding: JSONEncoding.default).validate().responseData{ response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let activitesData = try? jsonDecoder.decode(ActivityByDateResponse.self, from: data) {
                    // Instructions: Use completion to handle response
                    completion(activitesData.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addActivitiesToUser(date:Date, name: String, amount:Int) {
        let endpoint = "\(host)/api/acts/\(name)/add/"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "M"
        let month = Int(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "d"
        let day = Int(dateFormatter.string(from: date))

        
        
        let parameters = ["year":year,"month":month,"day":day,"user_id": 1, "amount": amount]
        AF.request(endpoint,  method: .post , parameters:parameters, encoding: JSONEncoding.default).validate().responseData{ response in
            switch response.result {
            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let activitesData = try? jsonDecoder.decode(ActivityByDateResponse.self, from: data) {
//                    // Instructions: Use completion to handle response
//                    completion(activitesData.data)
//                }
            print("successfully")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
