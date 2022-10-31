//
//  AdministrativeArea.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import Foundation

typealias AdminArea = AdministrativeArea

struct AdministrativeArea: Codable, Identifiable {
    // MARK: why should this one be var
    var area: Area
    let elections: [Area]
    
    enum CodingKeys: String, CodingKey {
        case area = "Area"
        case elections = "Election"
    }
    
    var id: String {
        area.id
    }
}

// MARK: - Area
struct Area: Codable {
    var id, name: String
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
