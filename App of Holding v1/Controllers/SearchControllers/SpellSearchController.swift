//
//  SpellSearchController.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation
import AVKit
import AVFoundation
import UIKit

class SpellSearchController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, URLSessionDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //let downloadService = DownloadService()
    let queryService = SpellFetchManager()
    
    var spellManager = SpellFetchManager()
    var spellName = ""
    var spells: [Spell]! = []
    
    lazy var downloadsSession: URLSession = {
      let configuration = URLSessionConfiguration.background(withIdentifier:
        "com.navadev.App-of-Holding-v1.bgSession")
      return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    var searchResults: [Spell] = []

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
    
    func reload(_ row: Int) {
//      tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
        collectionView.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "UICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "spellCell")
        searchBar.delegate = self
    }
    
    
    //
    //MARK: Collection View Methods
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("SPELL COUNT VVVV")
        print(spells.count)
        return self.spells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let spellCell: SpellCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "spellCell", for: indexPath) as! SpellCellCollectionViewCell
        
        return spellCell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("here!")
        
        dismissKeyboard()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
          return
        }
        print(searchText)
        self.spells = queryService.getSearchResults(searchterm: searchText)
        print("SAVED SPELLS vvvvvvvvv")
        self.spells = queryService.spells
        
        self.collectionView.reloadData()
        print(self.spells)
    
    }
}

extension SpellSearchController: UISearchBarDelegate {
    
    
}

//
// MARK: - URL Session Download Delegate
//
extension SpellSearchController: URLSessionDownloadDelegate {
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didFinishDownloadingTo location: URL) {
    // 1
    guard let sourceURL = downloadTask.originalRequest?.url else {
      return
    }
    
//    let download = downloadService.activeDownloads[sourceURL]
//    downloadService.activeDownloads[sourceURL] = nil
    
    // 2
    let destinationURL = localFilePath(for: sourceURL)
    print(destinationURL)
    
    // 3
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    
//    do {
//      try fileManager.copyItem(at: location, to: destinationURL)
//      download?.track.downloaded = true
//    } catch let error {
//      print("Could not copy file to disk: \(error.localizedDescription)")
//    }
    
    // 4
//    if let index = download?.track.index {
//      DispatchQueue.main.async { [weak self] in
//        self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
//      }
//    }
  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                  totalBytesExpectedToWrite: Int64) {
    // 1
//    guard
//      let url = downloadTask.originalRequest?.url,
//      let download = downloadService.activeDownloads[url]  else {
//        return
//    }
//
//    // 2
//    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//    // 3
//    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
//
    // 4
//    DispatchQueue.main.async {
//      if let trackCell = self.collectionView.cellForRow(at: IndexPath(row: spell.index,
//                                                                 section: 0)) as? spellCell {
//        trackCell.updateDisplay(progress: download.progress, totalSize: totalSize)
//      }
//    }
  }
}
