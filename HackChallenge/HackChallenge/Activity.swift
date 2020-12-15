//
//  Activity.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/6/20.
//
import Foundation

struct ActivityDataResponse: Codable {
    var data:[Activity]
}

struct Activity: Codable{
    var id:Int
    var name: String
    var cal: Int
}
