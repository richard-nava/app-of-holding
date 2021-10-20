//
//  DndManager.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation


class SpellFetchManager {
    
    let dndUrl = "https://www.dnd5eapi.co/api/spells"
    
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Spell]?, String) -> Void
    
    let defaultSession = URLSession(configuration: .default)
    
    var errorMessage = ""
    var dataTask: URLSessionDataTask?
    var spells: [Spell] = []
    var receivedData: Data?
    
    func getSearchResults(searchterm:String) -> [Spell]? {
        
        dataTask?.cancel()
        var ss: [Spell] = []
        let fixedSearch = fixSearch(searchStr: searchterm)
        if var urlComponents = URLComponents(string: dndUrl){
            urlComponents.query = "name=\(fixedSearch)"
            
            guard let url = urlComponents.url else{
                return nil
            }
            print(url)
            
            let task = defaultSession.dataTask(with: url) { currentData, response, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    if let safeData = currentData {
                        let dataString = String(data: safeData, encoding: .utf8)
                        print("PRINTING DATA STRING *******")
                        print(dataString as Any)
                        ss = self.parseJSON(resultsData: safeData)!
                    }
                
            }
            task.resume()
            return ss
        }
        return nil
    }
    
    //try using NSURLConnection.sendAsync.....
    func newGetSearch(searchTerm: String) {
        dataTask?.cancel()
        var ss: [Spell] = []
        let fixedSearch = fixSearch(searchStr: searchterm)
        if var urlComponents = URLComponents(string: dndUrl) {
            
            urlComponents.query = "name=\(fixedSearch)"
            
            guard let url = urlComponents.url else{
                return nil
            }
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data){
        self.receivedData?.append(data)
    }
    
    private func updateSearchResults(_ data: Data){
        var response: JSONDictionary?
        spells.removeAll()
        
        do{
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        guard let array = response!["results"] as? [Any] else {
          errorMessage += "Dictionary does not contain results key\n"
          return
        }
        
        var index = 0
        
    }
    
    func parseJSON(resultsData: Data) -> [Spell]? {
        
        var spellList: [Spell] = []
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ResultsData.self, from: resultsData)
            //print(decodedData.results)
            for s in decodedData.results {
                var spell = Spell()
                
                spell.name = s.name
                spell.index = s.index
                spell.url = s.url
                spellList.append(spell)
            }
            print(spellList)
            self.spells = spellList
            return spellList
        } catch {
            print(error)
            return nil
        }
    }
    
    func fixSearch(searchStr: String) -> String {
        var newName = searchStr;
        if newName.contains(" "){
            newName = searchStr.replacingOccurrences(of: " ", with: "+")
        }
        return newName
    }

}
