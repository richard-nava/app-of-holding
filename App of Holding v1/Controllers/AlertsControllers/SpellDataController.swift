//
//  SpellDataController.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/23/21.
//

import Foundation
import UIKit


class SpellDataController: UIViewController {
  
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var attackType: UILabel!
    var spell = Spell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("IN SPELL DATA VIEW")
        print(spell)
        name.text = spell.name
        attackType.text = spell.attack_type
        desc.text = spell.desc
    }
}
