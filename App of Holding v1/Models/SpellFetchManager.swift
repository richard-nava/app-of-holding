//
//  DndManager.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation


class SpellFetchManager {
    
    let dndUrl = "https://www.dnd5eapi.co/api/"
    var spells: Array<SpellData> = []
    func fetchSpell(spellName: String) {
        print("IN FETCH SPELL FUNC *****")
       
        print(spellName)
        var newName = spellName;
        if newName.contains(" "){
            newName = spellName.replacingOccurrences(of: " ", with: "-")
        }
        let urlString = "\(dndUrl)spells/?name=\(newName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        //create URL
        if let url = URL(string: urlString){
            print(url)
            //create session
            let session = URLSession(configuration: .default)
            
            //give session task
            let task = session.dataTask(with: url) { currentData, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = currentData {
//                    print("currentData")
//                    print(currentData!)
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                    var spellList = self.parseJSON(resultsData: safeData) ?? []
                    print(spellList)
                    self.spells = spellList
                    print(safeData)
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(resultsData: Data) -> Array<SpellData>? {
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ResultsData.self, from: resultsData)
            return [decodedData]
            //print(decodedData.name)
            //print(decodedData.range)
        } catch {
            print(error)
            return nil;
        }
    }
    
//    //MARK: Test
//    if let myData = data {
//        if let json = try? JSONSerialization.jsonObject(with: myData, options: []) as! Dictionary<String,Any>{
//
//                    if let spells = json["spells"] as? Array<Dictionary<String,Any>>{
//                        self.spells = spells;
//                        DispatchQueue.main.async {
//                            self.UICollectionView.reloadData()
//                        }
//                    } else {
//
//            }
//
//        } else {
//            print(error)
//        }
//    }

}
