//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class PokemonDetailVC: UIViewController {

    //

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl1: UILabel!
    @IBOutlet weak var typeLbl2: UILabel!
    @IBOutlet weak var gameRefPokedexEntry: UILabel!
    @IBOutlet weak var pokemonTitle: UILabel!
    
    // Base stats
    
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var specialattackLbl: UILabel!
    @IBOutlet weak var specialdefenseLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    
    // Base stat bars
    
    @IBOutlet weak var fullBar: UIView!
    
    @IBOutlet weak var hpBar: UIView!
    @IBOutlet weak var atkBar: UIView!
    @IBOutlet weak var defBar: UIView!
    @IBOutlet weak var satBar: UIView!
    @IBOutlet weak var sdfBar: UIView!
    @IBOutlet weak var spdBar: UIView!

    // Labels
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    @IBOutlet weak var prevEvo: UIImageView!
    
    @IBOutlet weak var evoLbl: UILabel!
    
    // Colour stuff
    
    @IBOutlet weak var NavBarColour: UIView!
    @IBOutlet weak var segmentColour: UISegmentedControl!
    @IBOutlet weak var colourBar: UIView!
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var HPTitle: UILabel!
    @IBOutlet weak var attackTitle: UILabel!
    @IBOutlet weak var defenseTitle: UILabel!
    @IBOutlet weak var spAttackTitle: UILabel!
    @IBOutlet weak var spDefenseTitle: UILabel!
    @IBOutlet weak var speedTitle: UILabel!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var dexNoTitle: UILabel!
    

    
    var soundPlayer: AVAudioPlayer!
    var pokemon: Pokemon!
    var selectedVersionLabel: Int = Int(arc4random_uniform(26) + 1)
    var timer: NSTimer!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    /*override func viewDidLayoutSubviews() {
        
        // Load Graphs
        
        setUpGraphs(hpBar, PokeStat: pokemon.hp)
        setUpGraphs(atkBar, PokeStat: pokemon.attack)
        setUpGraphs(defBar, PokeStat: pokemon.defense)
        setUpGraphs(satBar, PokeStat: pokemon.specialAttack)
        setUpGraphs(sdfBar, PokeStat: pokemon.specialDefense)
        setUpGraphs(spdBar, PokeStat: pokemon.speed)
    }*/
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, delay: -2.0, options: .CurveEaseIn, animations: {
        self.setUpGraphs(self.hpBar, PokeStat: self.pokemon.hp)
        self.setUpGraphs(self.atkBar, PokeStat: self.pokemon.attack)
        self.setUpGraphs(self.defBar, PokeStat: self.pokemon.defense)
        self.setUpGraphs(self.satBar, PokeStat: self.pokemon.specialAttack)
        self.setUpGraphs(self.sdfBar, PokeStat: self.pokemon.specialDefense)
        self.setUpGraphs(self.spdBar, PokeStat: self.pokemon.speed)
            }, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "update", userInfo: nil, repeats: true)
        
        let img = UIImage(named: "\(pokemon.pokedexId)-hi")
        
        mainImg.image = img
        //currentEvo.image = img
        
        pokemon.parsePokeStatsCSV()
        
        pokemon.parsePokedexEntryCSV(selectedVersionLabel)
        
        // Make sure Dex entry is not blank
        while pokemon.description == "" {
            pokemon.parsePokedexEntryCSV(Int(arc4random_uniform(26) + 1))
        }
        
        // Refresh view with updateUI() function
        
        updateUI()
        
        // Load up audio
        
        initCries()
    
    // MARK: Graph Setup
        
    }
    
    func setUpGraphs(barRef: UIView, PokeStat: String) {
        
        let MAX_STAT: CGFloat = 255.0
        
        let str = PokeStat
        if let n = NSNumberFormatter().numberFromString(str) {
            let f = CGFloat(n)
            
            
            let barSize = CGRectMake(barRef.frame.origin.x, barRef.frame.origin.y, fullBar.frame.width * f/MAX_STAT, 5.0)
            
            barRef.frame = barSize
            
            UIView.animateWithDuration(2.0, delay: 2.0, options: .CurveEaseOut, animations: {
                barRef.alpha = 1
                }, completion: nil)

        }
        
    }

    
    
    // MARK: Functions

    func updateUI() {
        
        // Labels
        
        nameLbl.text = pokemon.name.capitalizedString
        pokemonTitle.text = pokemon.name.capitalizedString
        descriptionLbl.text = pokemon.description
        
        gameRefPokedexEntry.text = pokemon.gameName
        gameRefPokedexEntry.layer.backgroundColor = assignColoursToGame(pokemon.gameIdNo).CGColor
        gameRefPokedexEntry.layer.cornerRadius = 10.0
        
        if pokemon.type2 == "" {
            typeLbl2.text = "\(pokemon.type1)"
            typeLbl2.layer.cornerRadius = 10.0
            typeLbl2.layer.backgroundColor = assignColorToType("\(pokemon.type1)",alpha: 1.0).CGColor
        } else {
            typeLbl1.text = "\(pokemon.type1)"
            typeLbl1.layer.cornerRadius = 10.0
            typeLbl2.text = "\(pokemon.type2)"
            typeLbl2.layer.cornerRadius = 10.0
            
            typeLbl1.layer.backgroundColor = assignColorToType("\(pokemon.type1)",alpha: 1.0).CGColor
            typeLbl2.layer.backgroundColor = assignColorToType("\(pokemon.type2)",alpha: 1.0).CGColor
        }
        

        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        //heightLbl.text = "\(pokemon.height) ft"
        pokedexLbl.text = "# \(pokemon.pokedexId)"
        //weightLbl.text = "\(pokemon.weight) lbs"
        
        hpLbl.text = pokemon.hp
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        specialattackLbl.text = pokemon.specialAttack
        specialdefenseLbl.text = pokemon.specialDefense
        speedLbl.text = pokemon.speed
        
        // Graph setup
    
        
        /*
        
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
        */
        
        // UI Color alteration

        let pokemonUIColor: UIColor = assignColorToType(pokemon.type1, alpha: 1.0)
        
        let themeColor = pokemonUIColor.adjust(-0.25, green: -0.25, blue: -0.25, alpha: 1)
        
        NavBarColour.backgroundColor = themeColor
        colourBar.backgroundColor = themeColor
        
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
    
    func update() {
        changeDexEntryUp()
    }
    
    func changeDexEntryUp() {
        selectedVersionLabel++
        
        if selectedVersionLabel > 26 {
            selectedVersionLabel = 1
        }
        
        pokemon.parsePokedexEntryCSV(selectedVersionLabel)
        
        while pokemon.description ==  "" {
            
            selectedVersionLabel++
            pokemon.parsePokedexEntryCSV(selectedVersionLabel)
            
            if selectedVersionLabel >= 26 {
                selectedVersionLabel = 1
                pokemon.parsePokedexEntryCSV(selectedVersionLabel)
                
            }
        }
        gameRefPokedexEntry.layer.backgroundColor = assignColoursToGame(pokemon.gameIdNo).CGColor
        gameRefPokedexEntry.text = pokemon.gameName
        descriptionLbl.fadeTransition(0.25)
        descriptionLbl.text = pokemon.description
        
    }
    
    // MARK: @IBAction functions
    
    @IBAction func backToMain(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    @IBAction func playCry(sender: UIButton!) {
        soundPlayer.play()
    }
    
    @IBAction func changeDexEntry(sender: UIButton) {
        changeDexEntryUp()
        timer.invalidate()
    }
    
    @IBAction func changeDexEntryDown(sender: AnyObject) {
        
        timer.invalidate()
        
        selectedVersionLabel--
        
        if selectedVersionLabel < 1 {
            selectedVersionLabel = 26
        }
        
        pokemon.parsePokedexEntryCSV(selectedVersionLabel)
 
        while pokemon.description ==  "" {
            
            selectedVersionLabel--
            pokemon.parsePokedexEntryCSV(selectedVersionLabel)
                
            if selectedVersionLabel <=  1 {
                selectedVersionLabel = 26
                pokemon.parsePokedexEntryCSV(selectedVersionLabel)
                }
            }
        gameRefPokedexEntry.fadeTransition(0.4)
        gameRefPokedexEntry.layer.backgroundColor = assignColoursToGame(pokemon.gameIdNo).CGColor
        gameRefPokedexEntry.text = pokemon.gameName
        descriptionLbl.fadeTransition(0.25)
        descriptionLbl.text = pokemon.description
    }
}

