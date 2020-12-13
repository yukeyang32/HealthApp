//
//  NetworkManager.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//
import Foundation
import Alamofire

class NetworkManager {
    private static let host = "http://0.0.0.0:5000"
    
    
    static func getActivities(completion: @escaping ([Activity]) -> Void) {
        let endpoint = "\(host)/api/activities/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                print(data)
                print("here2")
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    try jsonDecoder.decode(ActivityDataResponse.self, from: data)
                }catch {
                    print("\(error)")
                }
                
                if let activitesData = try? jsonDecoder.decode(ActivityDataResponse.self, from: data) {
                    // Instructions: Use completion to handle response
                    print("here3")
                    completion(activitesData.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
