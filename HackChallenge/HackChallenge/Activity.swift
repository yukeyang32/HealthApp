//
//  Activity.swift
//  healthyeat
//
//  Created by YEXIN WU on 12/6/20.
//
import Foundation

class Activity{
    var activity_name: String
    var cal: Int
    var unit: (Int,String)
    var picture: String
    
    init(activity_name an: String, cal: Int, unit:(Int,String), picture:String) {
        self.activity_name = an
        self.cal = cal
        self.unit = unit
        self.picture = picture
    }
}
