//
//  ResultsData.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/18/21.
//

import Foundation

struct ResultsData: Decodable {
    let count: Int
    let results: [SpellResults]
}


struct SpellResults: Decodable {
    let index: String?;
    let name: String?;
    let url: String?;
}
