//
//  ViewController.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/8/21.
//

import UIKit

class SpellController: UIViewController {

    @IBAction func goToSpellSearchScreen(_ sender: Any) {
        performSegue(withIdentifier: "goToSpellSearch", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
 

}

