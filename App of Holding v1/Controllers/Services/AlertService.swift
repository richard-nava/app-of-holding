//
//  AlertService.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/23/21.
//

import Foundation
import UIKit

class AlertService {
    
    func alert() -> AlertViewController {
        let storyboard = UIStoryboard(name: "AlertsStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        return alertVC
    }
    
    func alert2() -> SpellDataController {
        let storyboard = UIStoryboard(name: "SingleSpellSearched", bundle: .main)
        let spellVC = storyboard.instantiateViewController(withIdentifier: "SpellDataVC") as! SpellDataController
        return spellVC
    }
}
