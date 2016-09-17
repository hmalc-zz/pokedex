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
    
    func configureImageCell(_ pokedexRef: Int,formReference: Int) {
        
        if formReference != 0 {
            mainImg.image = UIImage(named: "\(pokedexRef)hiform\(formReference)")
        } else {
        mainImg.image = UIImage(named: "\(pokedexRef)-hi")
        }
    }
}
