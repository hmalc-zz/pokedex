//
//  PokeCellCollectionViewCell.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 3.0
        layer.shadowOpacity = 0.2
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        nameLbl.backgroundColor = assignColorToType("\(self.pokemon.type1)",alpha: 0.4)
        thumbImg.backgroundColor = assignColorToType("\(self.pokemon.type2)",alpha: 0.4)
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
