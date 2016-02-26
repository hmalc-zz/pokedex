//
//  MainImageViewCell.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-25.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit

class MainImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImg: UIImageView!
    
    var pokemon: Pokemon!
    
    func configureImageCell(pokedexRef: Int) {
        mainImg.image = UIImage(named: "\(pokedexRef)-hi")
    }
    
}
