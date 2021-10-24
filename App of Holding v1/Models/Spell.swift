//
//  Spell.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation

struct Spell: Decodable {
    var index: String?;
    var name: String?;
    var url: String?;
    var desc: Array<String>?;
    var range: String?;
    var casting_time: String?;
    var attack_type: String?;
    var damage: Damage?;
    var school: School?;
    
    // initializer for Spell Search
    init(index: String? = nil, name: String? = nil, url: String? = nil) {
        self.index = index
        self.name = name
        self.url = url
    }
    
    
}

struct Damage: Decodable {
    var damage_type: DamageType;
}

struct DamageType: Decodable {
    var index: String?;
    var name: String?;
    var url: String?;
}

struct School: Decodable {
    var index: String?;
    var name: String?;
    var url: String?;
}
