//
//  AdministrativeArea.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import Foundation

typealias AdminAreaList = AdministrativeAreaList
typealias AdminArea = AdministrativeArea

struct AdministrativeAreaList: Codable {
    var adminAreas: [AdminArea]
}

struct AdministrativeArea: Codable, Identifiable {
    let area: Area
    let elections: [Area]
    
    var id: String {
        area.id
    }
}

// MARK: - Area
struct Area: Codable {
    let id, name: String
    let ivid, code: String?
    let left, right, population, populationElectors: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case ivid
        case code
        case left = "lft"
        case right = "rght"
        case population
        case populationElectors = "population_electors"
    }
}
