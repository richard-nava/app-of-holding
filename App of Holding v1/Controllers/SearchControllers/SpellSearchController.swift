//
//  SpellSearchController.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation
import UIKit

class SpellSearchController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, URLSessionDelegate, UICollectionViewDelegateFlowLayout {
    
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let session = URLSession()
    let alertService = AlertService()
    
    var spellManager = SpellFetchManager()
    var spellName = ""
    var searchResults: [Spell] = []

    private var spell = Spell()
    private var spells: [Spell]! = []
    
    let cellID = "SpellSearchViewCell"
    let spell1 = Spell(index: "acid-arrow", name: "Acid-Arrow", url: "/api/spells/acid-arrow")
    let spell2 = Spell(index: "animal-friendship", name: "Animal Friendship", url: "/api/spells/animal-friendship")
    let spell3 = Spell(index: "wall-of-fire", name: "Wall of Fire", url: "/api/spells/wall-of-fire")

    lazy var tapRecognizer: UITapGestureRecognizer = {
      var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
      return recognizer
    }()
    
    //
    // MARK: - Internal Methods
    //
    @objc func dismissKeyboard() {
      searchBar.resignFirstResponder()
    }
    
    func localFilePath(for url: URL) -> URL {
      return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        spells = [spell1, spell2, spell3]
        spellManager.delagate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SpellSearchViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        searchBar.delegate = self
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSingleSpell"{
            print("PREPARED SPELL vvvv")
            print(spell)
            let transferredSpell = spell
            let controller = segue.destination as! SpellDataController
            controller.spell = transferredSpell
        }
        print("PRINTING SEGUE ID IN PREPARE FUNC")
        print(segue.identifier)
        print(spell)
    }
    
    
    //
    //MARK: Collection View Methods
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("SPELL COUNT VVVV")
        print(spells.count)
        return spells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.9, height: 81)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SpellSearchViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpellSearchViewCell", for: indexPath) as! SpellSearchViewCell
        
        cell.spellName.text = spells[indexPath.row].name
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 3
        //cell.backgroundColor = UIColor.magenta
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Spell \(spells[indexPath.row].name)")
        spellManager.getSingleSpell(url: spells[indexPath.row].url!)
//        let alertVC = alertService.alert()
        //performSegue(withIdentifier: "goToSingleSpell", sender: self)
        
    }
    
    
    //
    //MARK: Search Bar Methods
    //
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("here!")
        dismissKeyboard()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
          return
        }
        spellManager.getSearchResults(searchterm: searchText)
        collectionView.reloadData()
    }
}

extension SpellSearchController: UISearchBarDelegate {
    
    
}

extension SpellSearchController: SpellFetchManagerDelagate {
    func didUpdateSpellSearch(_ spellFetchManager: SpellFetchManager, results: [Spell]){
        DispatchQueue.main.async { [weak self] in
            print("results from dispatch")
            print(results)
            self?.spells = results
            self?.collectionView.reloadData()
        }
    }
    
    func singleSpellInfo(_ spellFetchManager: SpellFetchManager, result: Spell) {
        DispatchQueue.main.async { [weak self] in
            print("results from SINGLE SPELL INFO")
            print(result)
            self?.spell = result
            self?.collectionView.reloadData()
            
            // why does my perform segue transfer data here, but not in didSelectItemAt?ß
            self?.performSegue(withIdentifier: "goToSingleSpell", sender: self)
        }
    }
}

extension UICollectionViewCell {
    
}



