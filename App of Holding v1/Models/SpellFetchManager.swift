//
//  DndManager.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation

protocol SpellFetchManagerDelagate {
   func didUpdateSpellSearch(_ spellFetchManager: SpellFetchManager, results: [Spell])
    func singleSpellInfo(_ spellFetchManager: SpellFetchManager, result: Spell)
}


struct SpellFetchManager {
    
    let dndUrl = "https://www.dnd5eapi.co/api/spells"
    let rawURL = "https://www.dnd5eapi.co/api/"
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Spell]?, String) -> Void
    
    let defaultSession = URLSession(configuration: .default)
    let decoder = JSONDecoder()

    var delagate: SpellFetchManagerDelagate?
    var errorMessage = ""
    var dataTask: URLSessionDataTask?
    var spells: [Spell] = []
    var singleSpell = Spell();
    var receivedData: Data?
    
    // Pulls all spell search results from searchbar string
    func getSearchResults(searchterm:String){
        
        // stop previous task
        dataTask?.cancel()
        
        // adjust searchterm string for spaces
        let fixedSearch = fixSearch(searchStr: searchterm)
        if var urlComponents = URLComponents(string: dndUrl){
            urlComponents.query = "name=\(fixedSearch)"
            
            guard let url = urlComponents.url else{
                return
            }
            print(url)
            
            // begin search task
            let task = defaultSession.dataTask(with: url) { currentData, response, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    if let safeData = currentData {
                        let dataString = String(data: safeData, encoding: .utf8)
                        print("PRINTING DATA STRING *******")
                        print(dataString as Any)
                        
                        // parse the json results and safe to list of viewable spells
                        if let spells = self.parseJSON(resultsData: safeData){
                            self.delagate?.didUpdateSpellSearch(self, results: spells)
                        }
                    }
            }
            task.resume()
        }
        
    }
    
    func getSingleSpell(url: String) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: rawURL){
            urlComponents.path = url
            //print(urlComponents.query)
            
            guard let fullURL = urlComponents.url else {
                
                return
            }
            print(fullURL)
            let task = defaultSession.dataTask(with: fullURL) { currentData, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = currentData {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print("printing dataString in getSingleSpell *****")
                    print(dataString as Any)
                    if let spell = self.parseSingleJSON(resultsData: safeData){
                        print("IN GET SINGLE SPELL FUNCTION vvvvv")
                        print(spell)
                        self.delagate?.singleSpellInfo(self, result: spell)
                    }
                }
            }
            task.resume()
        }
    }
    
    //
    //MARK: JSON Parse Methods
    //
        
    // parse json results from api search into a list of spells to be viewed in UI
    func parseJSON(resultsData: Data) -> [Spell]? {
        
        var spellList: [Spell] = []
        do{
            let decodedData = try decoder.decode(ResultsData.self, from: resultsData)
            
            // loop through results and save each individual spell in spellList
            for s in decodedData.results {
                var spell = Spell()
                
                spell.name = s.name
                spell.index = s.index
                spell.url = s.url
                spellList.append(spell)
            }
//            print(spellList)
            return spellList
        } catch {
            print(error)
            return nil
        }
    }
    
    
    // parse a single spell result
    func parseSingleJSON(resultsData: Data) -> Spell? {
        var spell = Spell()
        do{
            let decodedData = try decoder.decode(Spell.self, from: resultsData)
            
            spell.name = decodedData.name
            spell.index = decodedData.index
            spell.url = decodedData.url
            spell.desc = decodedData.desc
            spell.range = decodedData.range
            print("Spell from singleJson: \(spell)")
            return spell
        } catch {
            print(error)
            return nil
        }
    }
    
    // adjust string to fit api search
    func fixSearch(searchStr: String) -> String {
        var newName = searchStr;
        if newName.contains(" "){
            newName = searchStr.replacingOccurrences(of: " ", with: "+")
        }
        return newName
    }

}
