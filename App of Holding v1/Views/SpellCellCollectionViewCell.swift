//
//  SpellCellCollectionViewCell.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/17/21.
//

import UIKit

class SpellCellCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var castTimeLabel: UILabel!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
