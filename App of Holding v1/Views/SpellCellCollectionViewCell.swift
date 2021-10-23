//
//  SpellCellCollectionViewCell.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/17/21.
//

import UIKit

class SpellCellCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: Spell){
        nameLabel.text = model.name
    }
}
