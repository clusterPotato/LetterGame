//
//  LetterTileCollectionViewCell.swift
//  Letter Game
//
//  Created by Travis Halle on 5/19/21.
//

import UIKit

class LetterTileCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var letterTileImage: UIImageView!
    
    
    //MARK: - Properties
    var letter: String? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions
    @IBAction func letterTileTapped(_ sender: Any) {
        letterTileImage.tintColor = .gray
    }
    
    func updateViews() {
        guard let letter = letter else {return}
        letterTileImage.image = UIImage(named: letter)
    }
}//End of class
