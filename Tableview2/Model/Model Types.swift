//
//  File.swift
//  Tableview2
//
//  Created by Batoul Issa on 6/7/20.
//  Copyright © 2020 Batoul Issa. All rights reserved.
//

import Foundation


struct User : Codable{
    var id : Int
    var name : String
    var username : String
    var email : String
    var address : Address
    var phone : String
    var website : String
    var company : [String : String]
    
    func getCompanyInfo()->String{
        return "Name: \(company["name"] ?? "No company name" ).\n Role: \(company["bs"] ?? "")"
    }
    
}

struct Address : Codable{
    var street : String
    var suite : String
    var city : String
    var zipcode : String
    var geo : [String : String]
}



struct Wrapper: Codable{
    var users: [User]
    
}
