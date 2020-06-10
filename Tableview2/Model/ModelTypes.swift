//
//  File.swift
//  Tableview2
//
//  Created by Batoul Issa on 6/7/20.
//  Copyright © 2020 Batoul Issa. All rights reserved.
//

import Foundation


struct User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    
    func companyInfo()->String {
        return "Name: \(company.name).\n Role: \(company.bs)"
    }
    
}

struct Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: [String : String]
}

struct Company: Codable {
    var name: String
    var bs: String
    var catchPhrase: String
}


struct Photo: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url:String
    var thumbnailUrl: String
}


