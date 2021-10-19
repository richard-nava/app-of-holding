//
//  SpellSearchController.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation
import UIKit

class SpellSearchController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchSpell: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var spellManager = SpellFetchManager()
    var spellName = ""
    var spells: Array<Dictionary<String,Any>> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "UICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "spellCell")
    }
    
    //MARK: Search Bar Methods
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        spellName = searchTextField.text!
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        spellName = searchTextField.text!
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Enter a spell"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        spellName = searchTextField.text!
        print(spellName)
        spellManager.fetchSpell(spellName: spellName)
        
    }
    
    //MARK: Collection View Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spellCell", for: indexPath) as! UICollectionViewCell;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellWidth = collectionView.frame.size.width
            return CGSize(width: cellWidth, height: cellWidth*0.8)
        }
}

