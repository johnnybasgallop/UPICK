//
//  Movie.swift
//  UPick
//
//  Created by johnny basgallop on 26/09/2023.
//

import Foundation

struct Movie : Hashable, Identifiable, Codable {
    var id = UUID()
    var title : String
    var img : String
    var description : String
    var StreamingServices : [String]
    var genres : [String]
    var year : String
    var rating : Double
    
}
