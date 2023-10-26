//
//  FilterStruct.swift
//  UPick
//
//  Created by johnny basgallop on 26/09/2023.
//

import Foundation


struct Filter : Hashable {
    var genres : [String]
    var services : [String]
    var minYear : Int
    var maxYear : Int
    var isMovie : Bool
}

