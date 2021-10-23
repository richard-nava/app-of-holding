//
//  ViewController.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/8/21.
//

import UIKit

class SpellController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var spells: [Spell]! = []
    
    let spell1 = Spell(index: "acid-arrow", name: "Acid-Arrow", url: "/api/spells/acid-arrow")
    let spell2 = Spell(index: "animal-friendship", name: "Animal Friendship", url: "/api/spells/animal-friendship")
    let spell3 = Spell(index: "wall-of-fire", name: "Wall of Fire", url: "/api/spells/wall-of-fire")
    let cellID = "SpellResultViewCell"
    
    @IBAction func goToSpellSearchScreen(_ sender: Any) {
        performSegue(withIdentifier: "goToSpellSearch", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spells = [spell1, spell2, spell3]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SpellResultViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)

        // Do any additional setup after loading the view.
        collectionView.reloadData()
    }
    
    
    //
    //MARK: Collection View Methods
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SpellResultViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "SpellResultViewCell", for: indexPath) as! SpellResultViewCell
        let spell = spells[indexPath.row]
        cell.spellName.text = spell.name
        //cell.backgroundColor = UIColor.magenta
        cell.layer.borderColor = UIColor.tintColor.cgColor
        cell.layer.borderWidth = 1
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Spell \(spells[indexPath.row].name)")
    }
    
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
}

