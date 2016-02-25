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

class PokemonDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

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

    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    // Labels
    
    
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    @IBOutlet weak var prevEvo: UIImageView!
    
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBOutlet weak var totalBaseStat: UILabel!
    
    
    // Colour stuff
    
    @IBOutlet weak var NavBarColour: UIView!
    @IBOutlet weak var colourBar: UIView!
    @IBOutlet weak var typeTitle: UILabel!
    
    var soundPlayer: AVAudioPlayer!
    var pokemon: Pokemon!
    var selectedVersionLabel: Int = Int(arc4random_uniform(26) + 1)
    var timer: NSTimer!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setUpGraphColor(self.hpBar, PokeStat: self.pokemon.hp)
        self.setUpGraphColor(self.atkBar, PokeStat: self.pokemon.attack)
        self.setUpGraphColor(self.defBar, PokeStat: self.pokemon.defense)
        self.setUpGraphColor(self.satBar, PokeStat: self.pokemon.specialAttack)
        self.setUpGraphColor(self.sdfBar, PokeStat: self.pokemon.specialDefense)
        self.setUpGraphColor(self.spdBar, PokeStat: self.pokemon.speed)
        
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseIn, animations: {

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
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "update", userInfo: nil, repeats: true)
        
        let img = UIImage(named: "\(pokemon.pokedexId)-hi")
        
        mainImg.image = img
        pokemon.parsePokeStatsCSV()
        pokemon.parsePokedexEntryCSV(selectedVersionLabel)
        pokemon.parsePokeMovesCSV(16)
        
        // Make sure Dex entry is not blank
        while pokemon.description == "" {
            pokemon.parsePokedexEntryCSV(Int(arc4random_uniform(26) + 1))
        }
        
        //
        
        // Refresh view with updateUI() function
        
        updateUI()
        
        // Load up audio
        
        initCries()
        
        // Set height of Scroll View
        
        self.tableHeight.constant = CGFloat(pokemon.moveList.count) * 44
        
        print(self.tableHeight.constant)
        // Need to call this line to force constraint updated
        
        self.view.layoutIfNeeded()
        
    }
    
    // MARK: Graph Setup
    
    func setUpGraphs(barRef: UIView, PokeStat: String) {
        
        let MAX_STAT: CGFloat = 255.0
        
        let str = PokeStat
        if let n = NSNumberFormatter().numberFromString(str) {
            let f = CGFloat(n)
            
            
            let barSize = CGRectMake(barRef.frame.origin.x, barRef.frame.origin.y, fullBar.frame.width * f/MAX_STAT, 5.0)
            
            barRef.frame = barSize

        }
        
        
        
    }
    
    func setUpGraphColor(barRef: UIView, PokeStat: String) {
        
        let COLOUR_FACTOR: CGFloat = 400
        
        let str = PokeStat
        if let n = NSNumberFormatter().numberFromString(str) {
            let f = CGFloat(n)
            
            let dynamicColour: UIColor = UIColor.init(hue: f/COLOUR_FACTOR, saturation: 1.0, brightness: 1.0, alpha: 1)
            
            barRef.backgroundColor = dynamicColour
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
        
        currentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
        
        // Programmatically assign images based on weather evolutions exist
        
        if pokemon.nextEvolutionId == "" && pokemon.previousEvolutionId == "" {
            prevEvo.hidden = true
            nextEvo.hidden = true
        } else if pokemon.previousEvolutionId != "" && pokemon.nextEvolutionId != "" {
            prevEvo.image = UIImage(named: "\(pokemon.previousEvolutionId)")
            nextEvo.image = UIImage(named: "\(pokemon.nextEvolutionId)")
        } else if pokemon.previousEvolutionId != "" && pokemon.nextEvolutionId == ""{
            prevEvo.image = UIImage(named: "\(pokemon.previousEvolutionId)")
            nextEvo.hidden = true
        } else if pokemon.previousEvolutionId == "" && pokemon.nextEvolutionId != ""{
            prevEvo.hidden = true
            nextEvo.image = UIImage(named: "\(pokemon.nextEvolutionId)")
        }
        
        // UI Color alteration

        let pokemonUIColor: UIColor = assignColorToType(pokemon.type1, alpha: 1.0)
        
        let themeColor = pokemonUIColor.adjust(-0.25, green: -0.25, blue: -0.25, alpha: 1)
        
        NavBarColour.backgroundColor = themeColor
        colourBar.backgroundColor = themeColor
        
        // Total stats calc
        
        var baseStatTotal: Int = 0
        
        if let n = NSNumberFormatter().numberFromString(pokemon.hp) {
            let f = Int(n)
            baseStatTotal += f
        }
        if let n = NSNumberFormatter().numberFromString(pokemon.defense) {
            let f = Int(n)
            baseStatTotal += f
        }
        if let n = NSNumberFormatter().numberFromString(pokemon.attack) {
            let f = Int(n)
            baseStatTotal += f
        }
        if let n = NSNumberFormatter().numberFromString(pokemon.specialAttack) {
            let f = Int(n)
            baseStatTotal += f
        }
        if let n = NSNumberFormatter().numberFromString(pokemon.specialDefense) {
            let f = Int(n)
            baseStatTotal += f
        }
        if let n = NSNumberFormatter().numberFromString(pokemon.speed) {
            let f = Int(n)
            baseStatTotal += f
        }
        
        totalBaseStat.text = "\(baseStatTotal)"
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
    
    // MARK: Table View Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UIPokeTableCell")
        
        cell?.textLabel?.text = pokemon.moveList[indexPath.row]
        
        cell?.detailTextLabel?.text = "\(pokemon.levelList[indexPath.row])"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.moveList.count
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

