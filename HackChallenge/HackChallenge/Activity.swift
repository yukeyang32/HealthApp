//
//  Activity.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/6/20.
//
import Foundation


struct ActivityDataResponse: Codable {
    /* Instructions: Take a look at the JSON response we get from our HTTP Requests.
     * Model your RestaurantsDataResponse object after the JSON response.
     */
    var data:[Activity]
    
}

struct Activity: Codable{
    var id:Int
    var name: String
    var cal: Int
}
