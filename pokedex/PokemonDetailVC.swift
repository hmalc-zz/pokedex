//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonDetailVC: UIViewController {



    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl1: UILabel!
    @IBOutlet weak var typeLbl2: UILabel!
    
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var specialattackLbl: UILabel!
    @IBOutlet weak var specialdefenseLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    @IBOutlet weak var prevEvo: UIImageView!
    
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBOutlet weak var gameRefPokedexEntry: UILabel!
    
    var pokemon: Pokemon!
    var selectedVersionLabel: Int = Int(arc4random_uniform(26) + 1)
    
    var soundPlayer: AVAudioPlayer!
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = img
        currentEvo.image = img
        
        pokemon.parsePokeStatsCSV()
        pokemon.parsePokedexEntryCSV(selectedVersionLabel)
        updateUI()
        initCries()
        
        }
    
//        pokemon.downloadPokemonDetails { () -> () in
//            self.updateUI()
//        }
//    }

        // Do any additional setup after loading the view
        


    func updateUI() {
        nameLbl.text = pokemon.name.capitalizedString
        descriptionLbl.text = pokemon.description
        gameRefPokedexEntry.text = pokemon.gameName
        
        typeLbl1.text = "\(pokemon.type1)"
        typeLbl1.layer.cornerRadius = 10.0
        typeLbl2.text = "\(pokemon.type2)"
        typeLbl2.layer.cornerRadius = 10.0
        
        typeLbl1.layer.backgroundColor = assignColorToType("\(pokemon.type1)",alpha: 1.0).CGColor
        typeLbl2.layer.backgroundColor = assignColorToType("\(pokemon.type2)",alpha: 1.0).CGColor
        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = "\(pokemon.height) ft"
        pokedexLbl.text = "#\(pokemon.pokedexId)"
        weightLbl.text = "\(pokemon.weight) lbs"
        
        hpLbl.text = pokemon.hp
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        specialattackLbl.text = pokemon.specialAttack
        specialdefenseLbl.text = pokemon.specialDefense
        speedLbl.text = pokemon.speed

        var str = ""
        
        if pokemon.previousEvolution == "" {
            prevEvo.hidden = true
        } else {
            prevEvo.hidden = false
            prevEvo.image = UIImage(named: pokemon.previousEvolution)
            
            //var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.previousEvolutionLevel != "" {
                str += "Evolved at Lv. \(pokemon.previousEvolutionLevel)"
            }
        }
        
        if pokemon.nextEvolutionId == "" {
            nextEvo.hidden = true
        } else {
            nextEvo.hidden = false
            nextEvo.image = UIImage(named: pokemon.nextEvolutionId)
            
            //var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLevel != "" {
                str += "Evolves at Lv. \(pokemon.nextEvolutionLevel)"
            }
        }
        
        if pokemon.nextEvolutionId != "" && pokemon.previousEvolution != "" {
            evoLbl.text = "Evolved at Lv. \(pokemon.previousEvolutionLevel) / Evolves at Lv. \(pokemon.nextEvolutionLevel)"
        } else {
            evoLbl.text = str
        }
        
        
        if pokemon.previousEvolution != "" {
            prevEvo.image = UIImage(named: pokemon.previousEvolution)
        }
        
    }
    
    func initCries() {
        
        let path = NSBundle.mainBundle().pathForResource("\(pokemon.pokedexId)", ofType: "mp3")!
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 0.03
            soundPlayer.numberOfLoops = 0
            soundPlayer.play()
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func backToMain(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    @IBAction func playCry(sender: UIButton!) {
            soundPlayer.play()
    }
    
    
    @IBAction func changeDexEntry(sender: UIButton) {
        
        if selectedVersionLabel == 26 {
        } else {
            selectedVersionLabel++
            pokemon.parsePokedexEntryCSV(selectedVersionLabel)
            
            while pokemon.description ==  "" {
                
                if selectedVersionLabel < 26 {
                    selectedVersionLabel++
                    pokemon.parsePokedexEntryCSV(selectedVersionLabel)
                }
            }
        }
        gameRefPokedexEntry.text = pokemon.gameName
        descriptionLbl.text = pokemon.description
    }
    
    @IBAction func changeDexEntryDown(sender: AnyObject) {
        
        if selectedVersionLabel == 1 {
        } else {
            selectedVersionLabel--
            pokemon.parsePokedexEntryCSV(selectedVersionLabel)
            
            while pokemon.description ==  "" {
            
            selectedVersionLabel--
            pokemon.parsePokedexEntryCSV(selectedVersionLabel)
            }
        }
    gameRefPokedexEntry.text = pokemon.gameName
    descriptionLbl.text = pokemon.description
    }
}

