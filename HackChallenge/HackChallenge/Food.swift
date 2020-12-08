//
//  Food.swift
//  HackChallenge
//
//  Created by Xinhao He on 12/7/20.
//

struct UserFood : Codable {
    var userId:String
    var foodId:Int
    var food:Food
    var timestamp:String
    var amount:Int
    
    init(userId:String, foodId: Int, food:Food, timestamp:String, amount:Int) {
        self.userId = userId
        self.foodId = foodId
        self.food = food
        self.timestamp = timestamp
        self.amount = amount
    }
}

struct Food:Codable {
    var foodId:Int
    var name:String
    var calPerUnit:Int
    var unit:String
    
    init(foodId:Int, name:String, calPerUnit:Int, unit:String) {
        self.foodId = foodId
        self.name = name
        self.calPerUnit = calPerUnit
        self.unit = unit
    }
}
