//
//  Food.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//

struct NewFoodResponse:Codable {
    var data:NewFood
}

struct NewFood:Codable {
    var name:String
    var cal:Int
    var unit:String
}

struct AddFoodResponse:Codable {
    var data:Food
}

struct GetFoodDateResponse:Codable {
    var data:[UserFood]
}

struct UserFood:Codable {
    var id:Int
    var userid:Int
    var name:String
    var year:Int
    var month:Int
    var day:Int
    var amount:Int
}

struct FoodDataResponse:Codable {
    var data:Food
}

struct Food:Codable {
    var id:Int
    var name:String
    var cal:Int
    var unit:String
}
