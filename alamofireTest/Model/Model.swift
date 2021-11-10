//
//  Model.swift
//  alamofireTest
//
//  Created by Furkan Yıldız on 20.06.2021.
//

import Foundation

struct Model: Decodable {
    var mission_name: String?
    var launch_year: String
    var details: String?
    var flight_number: Int
    var launch_date_local: String?
    var links: Links
    let rocket: Rocket
    
    
    enum CodingKeys: String, CodingKey{
        
        case mission_name = "mission_name"
        case launch_date_local = "launch_date_local"
        case details = "details"
        case launch_year = "launch_year"
        case links = "links"
        case rocket = "rocket"
        case flight_number = "flight_number"
    }
    
    
}

struct Links: Codable {
    var mission_patch, mission_patch_small: String?
    var video_link: String
    

    enum CodingKeys: String, CodingKey {
        case mission_patch = "mission_patch"
        case mission_patch_small = "mission_patch_small"
        case video_link = "video_link"
       
    }
}

struct Rocket: Codable {
    var rocket_name,rocket_type:String?
    
    enum CodingKeys: String, CodingKey{
        case rocket_name = "rocket_name"
        case rocket_type = "rocket_type"
    }
}
