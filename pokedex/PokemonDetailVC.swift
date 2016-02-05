//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {


    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalizedString
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = img
        currentEvo.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }

        // Do any additional setup after loading the view.
    

    func updateUI() {
        nameLbl.text = pokemon.name.capitalizedString
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = "\(pokemon.height) ft"
        pokedexLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = "\(pokemon.weight) lbs"
        attackLbl.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No evolutions"
            nextEvo.hidden = true
        } else {
            nextEvo.hidden = false
            nextEvo.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLevel != "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            evoLbl.text = str
        }
        
        nextEvo.image = UIImage(named: pokemon.nextEvolutionId)
        
            
    }
    
    @IBAction func backToMain(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    

}
