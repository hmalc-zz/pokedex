//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Labels
    
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
    
    @IBOutlet weak var heightWeight: UILabel!
    @IBOutlet weak var pokemonGen: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    
    // Evolution Handling
    
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    @IBOutlet weak var prevEvo: UIImageView!
    
    @IBOutlet weak var firstEvoLabel: UILabel!
    @IBOutlet weak var secondEvoLabel: UILabel!
    
    @IBOutlet weak var totalBaseStat: UILabel!
    
    // Move labels
    
    @IBOutlet weak var moveVersionLabel: UILabel!
    
    // Abilities
    
    @IBOutlet weak var firstAbility: UILabel!
    @IBOutlet weak var secondAbility: UILabel!
    @IBOutlet weak var hiddenAbility: UILabel!
    
    @IBOutlet weak var firstAbilityTitle: UILabel!
    @IBOutlet weak var secondAbilityTitle: UILabel!
    @IBOutlet weak var hiddenAbilityTitle: UILabel!
    
    // Arrow buttons
    
    @IBOutlet weak var scrollBack: UIButton!
    @IBOutlet weak var scrollForward: UIButton!
    
    // Evolution Buttons
    
    @IBOutlet weak var prevEvoButton: UIButton!
    @IBOutlet weak var currentEvoButton: UIButton!
    @IBOutlet weak var nextEvoButton: UIButton!
    
    // Forms panel labels/images
    
    @IBOutlet weak var form1: UIImageView!
    @IBOutlet weak var form2: UIImageView!
    @IBOutlet weak var form3: UIImageView!
    @IBOutlet weak var form4: UIImageView!
    @IBOutlet weak var form5: UIImageView!
    @IBOutlet weak var form6: UIImageView!
    
    @IBOutlet weak var form1Label: UILabel!
    @IBOutlet weak var form2Label: UILabel!
    @IBOutlet weak var form3Label: UILabel!
    @IBOutlet weak var form4Label: UILabel!
    @IBOutlet weak var form5Label: UILabel!
    @IBOutlet weak var form6Label: UILabel!
    
    @IBOutlet weak var formsTitle: UILabel!
    @IBOutlet weak var hideFormsView: NSLayoutConstraint!
    @IBOutlet weak var lineSeparator: UIView!
    
    // Colour stuff
    
    @IBOutlet weak var NavBarColour: UIView!
    @IBOutlet weak var colourBar: UIView!
    @IBOutlet weak var colourBar2: UIView!
    
    // Declare Variables
    
    var soundPlayer: AVAudioPlayer!
    var pokemon: Pokemon!
    var selectedVersionLabel: Int = Int(arc4random_uniform(26) + 1)
    var timer: NSTimer!
    var pokemonImg: [Int] = []
    var gameGenRef: Int = 0
    var firstTimeLoad: Bool = true
    var isPhone: Bool = true
    
    // View functions
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // Repopulates view with Pokemon infomation when collection view cell is swiped to a midpoint
    
    private var currentPokeID: Int = 0 {
        didSet {
            if currentPokeID != oldValue {
                pokemon = Pokemon(pokedexId: currentPokeID+1)
                if pokemon.pokedexId == 1 {
                    scrollBack.alpha = 0.0
                } else {
                    scrollBack.alpha = 1.0
                }
                if pokemon.pokedexId == 721 {
                    scrollForward.alpha = 0.0
                } else {
                    scrollForward.alpha = 1.0
                }
                newPokemonSetup()
                initCries(0)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            layout.itemSize = CGSize(width: itemWidth, height: 200)
            layout.invalidateLayout()
        }
        
        if (UIDevice.currentDevice().model.rangeOfString("iPad") != nil) {
            isPhone = false
        } else {
            isPhone = true
        }
    
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: pokemon.pokedexId-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: isPhone)

        UIView.animateWithDuration(0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: {
                self.setupGraphsForNewPokemon()
            },
            completion: nil)
    }
    
    // Triggers a didSet when scrolling moves image halfway off screen
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let bounds = self.collectionView.bounds
        let midpoint = CGPointMake(bounds.midX, bounds.midY)
        if let indexPath = self.collectionView.indexPathForItemAtPoint(midpoint) {
            currentPokeID = indexPath.item
        }
    }
    
    // Animates graphs when view appears
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: {
                self.setupGraphsForNewPokemon()
            },
            completion: nil)
    }
    
    // Function scroll to correct CollectionView Cell as per segue sender
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: pokemon.pokedexId-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
         }
    
    // MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup cells for CollectionView
        
        for i in 1...721 {
            pokemonImg.append(i)
        }
        
        // Specify delegates for table/collectionview
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Trigger timer to update Pokedex entries every 5 seconds
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(PokemonDetailVC.update), userInfo: nil, repeats: true)
        
        // Special handle for Pokedex No.1 since activating it won't trigger DidSet method
        
        if pokemon.pokedexId == 1 {
            
            initCries(0)
            scrollBack.alpha = 0
            newPokemonSetup()
        } else {
            currentPokeID = pokemon.pokedexId-1
        }
    }
    
    // MARK: New Pokemon Setup
    
    func newPokemonSetup() {
        
        // Parse CSV information
        
        pokemon.parsePokeStatsCSV()
        pokemon.parsePokedexEntryCSV(selectedVersionLabel)
        pokemon.parsePokeMovesCSV(returnMinGameGen(Int(pokemon.generationId)!)+1)
        while pokemon.description == "" {
            pokemon.parsePokedexEntryCSV(Int(arc4random_uniform(26) + 1))
        }
        updateUI()
        handlePokemonForms()
        self.tableHeight.constant = CGFloat(pokemon.moveList.count) * 44
        tableView.reloadData()

        
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: {
                self.setupGraphsForNewPokemon()
            },
            completion: nil)
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
        moveVersionLabel.text = "\(pokemon.gameName)"
        gameRefPokedexEntry.layer.backgroundColor = assignColoursToGame(pokemon.gameIdNo).CGColor
        gameRefPokedexEntry.layer.cornerRadius = 10.0
        
        if pokemon.type2 == "" {
            typeLbl1.text = ""
            typeLbl1.layer.backgroundColor = UIColor.whiteColor().CGColor
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
        if "\(pokemon.height)" == "0" || "\(pokemon.weight)" == "0" {
            heightWeight.text = ""
            heightWeight.hidden = true
        } else {
            heightWeight.hidden = false
            heightWeight.text = "\(pokemon.height)ft | \(pokemon.weight)lbs"
        }
        pokemonGen.text = "Gen: \(pokemon.generationId)"
        pokedexLbl.text = "# \(pokemon.pokedexId)"
        moveVersionLabel.text = "Gen \(gameVersionGen[returnMinGameGen(Int(pokemon.generationId)!)]): \(games[returnMinGameGen(Int(pokemon.generationId)!)])"
        
        gameGenRef = returnMinGameGen(Int(pokemon.generationId)!)+1
        
        hpLbl.text = pokemon.hp
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        specialattackLbl.text = pokemon.specialAttack
        specialdefenseLbl.text = pokemon.specialDefense
        speedLbl.text = pokemon.speed
        
        // Programmatically assign images based on weather evolutions exist
        
        // This code handles when there are 3 generations
        
        if pokemon.firstGenEvolution != "" || pokemon.thirdGenEvolution != "" {
            applyEvoLabelsFor3GenEvolutionPokemon()
            
        } else if pokemon.nextEvolutionId == "" && pokemon.previousEvolutionId == ""{
            
            prevEvo.image = nil
            currentEvo.hidden = false
            nextEvo.image = nil
            
            prevEvoButton.hidden = true
            currentEvoButton.hidden = false
            nextEvoButton.hidden = true
            
            firstEvoLabel.text = nil
            secondEvoLabel.text = nil
            
            currentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
            
        } else if pokemon.previousEvolutionId != "" && pokemon.nextEvolutionId != "" {
            
            prevEvo.hidden = false
            currentEvo.hidden = false
            nextEvo.hidden = false
            
            prevEvoButton.hidden = false
            currentEvoButton.hidden = false
            nextEvoButton.hidden = false
            
            firstEvoLabel.hidden = false
            secondEvoLabel.hidden = false
            
            prevEvo.image = UIImage(named: "\(pokemon.previousEvolutionId)")
            currentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
            nextEvo.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            
            previousEvolutionExistsLabelMaker()
            nextEvolutionExistsLabelMaker()
            
        } else if pokemon.previousEvolutionId != "" && pokemon.nextEvolutionId == ""{
            
            prevEvo.hidden = false
            currentEvo.hidden = false
            nextEvo.image = nil
            
            prevEvoButton.hidden = false
            currentEvoButton.hidden = false
            nextEvoButton.hidden = true
            
            firstEvoLabel.hidden = false
            secondEvoLabel.text = nil

            prevEvo.image = UIImage(named: "\(pokemon.previousEvolutionId)")
            currentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
            
            previousEvolutionExistsLabelMaker()
            
        } else if pokemon.previousEvolutionId == "" && pokemon.nextEvolutionId != ""{
           
            prevEvo.image = nil
            currentEvo.hidden = false
            nextEvo.hidden = false
            
            prevEvoButton.hidden = true
            currentEvoButton.hidden = false
            nextEvoButton.hidden = false
            
            firstEvoLabel.text = nil
            secondEvoLabel.hidden = false
            
            nextEvolutionExistsLabelMaker()

            nextEvo.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            currentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
            
        }
        
        firstAbilityTitle.hidden = true
        firstAbility.hidden = true
        secondAbilityTitle.hidden = true
        secondAbility.hidden = true
        hiddenAbilityTitle.hidden = true
        hiddenAbility.hidden = true
        
        // Abilities
        
        if pokemon.firstAbilityDesc != "" {
            firstAbilityTitle.hidden = false
            firstAbility.hidden = false
            firstAbilityTitle.text = "\(pokemon.firstAbility.capitalizedString)"
            firstAbility.text = pokemon.firstAbilityDesc
        }
        
        if pokemon.secondAbilityDesc != "" {
            secondAbilityTitle.hidden = false
            secondAbility.hidden = false
            secondAbilityTitle.text = "\(pokemon.secondAbility.capitalizedString)"
            secondAbility.text = pokemon.secondAbilityDesc
        }
        
        if pokemon.hiddenAbilityDesc != "" {
            hiddenAbilityTitle.hidden = false
            hiddenAbility.hidden = false
            hiddenAbilityTitle.text = "Hidden Ability: \(pokemon.hiddenAbility.capitalizedString)"
            hiddenAbility.text = pokemon.hiddenAbilityDesc
        }
        
        // UI Color alteration

        let pokemonUIColor: UIColor = assignColorToType(pokemon.type1, alpha: 1.0)
        let themeColor = pokemonUIColor.adjust(-0.25, green: -0.25, blue: -0.25, alpha: 1)
        NavBarColour.backgroundColor = themeColor
        colourBar.backgroundColor = themeColor
        colourBar2.backgroundColor = themeColor
        
        // Total stats calc
        
        totalBaseStat.text = pokemon.baseStats
    }
    
    func previousEvolutionExistsLabelMaker() {
        if pokemon.previousEvolutionLevel == "" || pokemon.previousEvolutionLevel == "0" {
            if pokemon.evolvedFromTrigger == "Level Up" {
                if pokemon.evolvedFromTriggerItem == "" {
                    firstEvoLabel.text = "Level up with condition"
                }
            } else {
                firstEvoLabel.text = "\(pokemon.evolvedFromTrigger) \(pokemon.evolvedFromTriggerItem.capitalizedString)"
            }
        } else {
            firstEvoLabel.text = "Lv. \(pokemon.previousEvolutionLevel)"
        }
    }
    
    func nextEvolutionExistsLabelMaker() {
        if pokemon.nextEvolutionLevel == "" || pokemon.nextEvolutionLevel == "0" {
            if pokemon.evolvesToTrigger == "Level Up" {
                if pokemon.evolvesToTriggerItem == "" {
                    secondEvoLabel.text = "Level up with condition"
                    }
                } else {
                    secondEvoLabel.text = "\(pokemon.evolvesToTrigger) \(pokemon.evolvesToTriggerItem.capitalizedString)"
            }
        } else {
            secondEvoLabel.text = "Lv. \(pokemon.nextEvolutionLevel)"
        }
    }
    
    // Allocates correct buttons and images when there's 3 stage pokemon evolution
    
    func applyEvoLabelsFor3GenEvolutionPokemon() {
        
        if pokemon.firstGenEvolution != "" {
            
            // Show correct buttons
            
            prevEvoButton.hidden = false
            currentEvoButton.hidden = false
            nextEvoButton.hidden = false
            
            // Show correct images
            
            prevEvo.hidden = false
            nextEvo.hidden = false
            
            // Assign images
            
            prevEvo.image = UIImage(named: "\(pokemon.firstGenEvolution)")
            currentEvo.image = UIImage(named: "\(pokemon.previousEvolutionId)")
            nextEvo.image = UIImage(named: "\(pokemon.pokedexId)")
            firstEvoLabel.text = "\(pokemon.originalTrigger) \(pokemon.originalTriggerItem)"
            
            // Labels
            
            if pokemon.previousEvolutionLevel == "" || pokemon.previousEvolutionLevel == "0" {
                secondEvoLabel.text = "\(pokemon.evolvedFromTrigger) \(pokemon.evolvedFromTriggerItem.capitalizedString)"
            } else {
                secondEvoLabel.text = "Lv. \(pokemon.previousEvolutionLevel)"
            }
            if pokemon.originalTrigger == "Level Up" {
                if pokemon.originalTriggerItem == "" {
                    firstEvoLabel.text = "Level up with condition"
                } else {
                    firstEvoLabel.text = "Lv. \(pokemon.originalTriggerItem)"
                }
            } else {
                firstEvoLabel.text = "\(pokemon.originalTrigger) \(pokemon.originalTriggerItem.capitalizedString)"
            }
        } else if pokemon.thirdGenEvolution != "" {
            
            // Show correct buttons
            
            prevEvoButton.hidden = false
            currentEvoButton.hidden = false
            nextEvoButton.hidden = false
            
            // Show correct images
            
            prevEvo.hidden = false
            nextEvo.hidden = false
            
            // Assign images
            
            prevEvo.image = UIImage(named: "\(pokemon.pokedexId)")
            currentEvo.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            nextEvo.image = UIImage(named: "\(pokemon.thirdGenEvolution)")
            
            // Assign Labels
            
            if pokemon.nextEvolutionLevel == "" || pokemon.nextEvolutionLevel == "0" {
                firstEvoLabel.text = "\(pokemon.evolvesToTrigger) \(pokemon.evolvesToTriggerItem.capitalizedString)"
            } else {
                firstEvoLabel.text = "Lv. \(pokemon.nextEvolutionLevel)"
            }
            
            if pokemon.eventualTrigger == "Level Up" {
                if pokemon.eventualTriggerItem == "" {
                    secondEvoLabel.text = "Level up with condition"
                } else {
                    secondEvoLabel.text = "Lv. \(pokemon.eventualTriggerItem)"
                }
            } else {
                secondEvoLabel.text = "\(pokemon.eventualTrigger) \(pokemon.eventualTriggerItem.capitalizedString)"
            }
        }
    }
    
    func initCries(formRef: Int) {
        
        var path = ""
        
        if formRef != 0 && hasMegaCry.contains(pokemon.pokedexId) {
            path = NSBundle.mainBundle().pathForResource("\(pokemon.pokedexId)form\(formRef)", ofType: "mp3")!
        } else if formRef != 0 {
        } else {
            path = NSBundle.mainBundle().pathForResource("\(pokemon.pokedexId)", ofType: "mp3")!
        }
        
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
        selectedVersionLabel += 1
        
        if selectedVersionLabel > 26 {
            selectedVersionLabel = 1
        }
        pokemon.parsePokedexEntryCSV(selectedVersionLabel)
        
        while pokemon.description ==  "" {
            
            selectedVersionLabel += 1
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
    
    // Handle possibility of having different forms
    
    func handlePokemonForms() {
        
        form1.image = nil
        form2.image = nil
        form3.image = nil
        form4.image = nil
        form5.image = nil
        form6.image = nil
        
        form1Label.text = ""
        form2Label.text = ""
        form3Label.text = ""
        form4Label.text = ""
        form5Label.text = ""
        form6Label.text = ""
        
        if pokemon.numberForms != "" {
            
            formsTitle.text = "Forms"
            lineSeparator.hidden = false
            hideFormsView.constant = 120
            
            for var i=1; i<=Int(pokemon.numberForms)!; i += 1 {
                if i == 1 {
                    form1.hidden = false
                    form1Label.hidden = false
                    form1.image = UIImage(named: "\(pokemon.pokedexId)form1")
                    form1Label.text = pokemon.pokemonFormNames(1).capitalizedString
                } else if i == 2 {
                    form2.hidden = false
                    form2Label.hidden = false
                    form2.image = UIImage(named: "\(pokemon.pokedexId)form2")
                    form2Label.text = pokemon.pokemonFormNames(2).capitalizedString
                } else if i == 3 {
                    form3.hidden = false
                    form3Label.hidden = false
                    form3.image = UIImage(named: "\(pokemon.pokedexId)form3")
                    form3Label.text = pokemon.pokemonFormNames(3).capitalizedString
                } else if i == 4 {
                    form4.hidden = false
                    form4Label.hidden = false
                    form4.image = UIImage(named: "\(pokemon.pokedexId)form4")
                    form4Label.text = pokemon.pokemonFormNames(4).capitalizedString
                } else if i == 5 {
                    form5.hidden = false
                    form5Label.hidden = false
                    form5.image = UIImage(named: "\(pokemon.pokedexId)form5")
                    form5Label.text = pokemon.pokemonFormNames(5).capitalizedString
                } else if i == 6 {
                    form6.hidden = false
                    form6Label.hidden = false
                    form6.image = UIImage(named: "\(pokemon.pokedexId)form6")
                    form6Label.text = pokemon.pokemonFormNames(6).capitalizedString
                }
            }
        } else {
            formsTitle.text = nil
            lineSeparator.hidden = true
            hideFormsView.constant = 0
        }
        
        self.view.layoutIfNeeded()
    }
    
    func setupGraphsForNewPokemon() {
        self.setUpGraphColor(self.hpBar, PokeStat: self.pokemon.hp)
        self.setUpGraphColor(self.atkBar, PokeStat: self.pokemon.attack)
        self.setUpGraphColor(self.defBar, PokeStat: self.pokemon.defense)
        self.setUpGraphColor(self.satBar, PokeStat: self.pokemon.specialAttack)
        self.setUpGraphColor(self.sdfBar, PokeStat: self.pokemon.specialDefense)
        self.setUpGraphColor(self.spdBar, PokeStat: self.pokemon.speed)
        
        self.setUpGraphs(self.hpBar, PokeStat: self.pokemon.hp)
        self.setUpGraphs(self.atkBar, PokeStat: self.pokemon.attack)
        self.setUpGraphs(self.defBar, PokeStat: self.pokemon.defense)
        self.setUpGraphs(self.satBar, PokeStat: self.pokemon.specialAttack)
        self.setUpGraphs(self.sdfBar, PokeStat: self.pokemon.specialDefense)
        self.setUpGraphs(self.spdBar, PokeStat: self.pokemon.speed)
    }
    
    // MARK: Table View Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as? TableViewCell {
            
            let move = pokemon.moveList[indexPath.row]
            let level = pokemon.levelList[indexPath.row]
            let type = pokemon.typeList[indexPath.row]
            let power = pokemon.powerList[indexPath.row]
            let accuracy = pokemon.accuracyList[indexPath.row]
        
            cell.configureMoves(move,Level: level,typeName: type, powerLevel: power, accuracyLevel: accuracy)
        
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.moveList.count
    }
    
    // MARK: Collection View Delegate Functions
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MainImageCell", forIndexPath: indexPath) as? MainImageViewCell {
            let dexID = pokemonImg[indexPath.row]
            
            cell.configureImageCell(dexID,formReference: 0)

            return cell
            
            }
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonImg.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(collectionView.bounds.size.width, 200)
        
    }
    
    // MARK: @IBAction functions
    
    @IBAction func backToMain(sender: AnyObject) {
        scrollForward.hidden = true
        scrollBack.hidden = true
        heightWeight.hidden = true
        pokemonGen.hidden = true
        timer.invalidate()
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    @IBAction func changeGameRef(sender: AnyObject) {
        
        var breaker = 0
        
        func cycleThrough() {
            while pokemon.moveList.count == 0 {
                
                if gameGenRef != 16 {
                    gameGenRef += 1
                    pokemon.parsePokeMovesCSV(gameGenRef)
                } else {
                    gameGenRef = gameVersionGen[returnMinGameGen(Int(pokemon.generationId)!)]
                    pokemon.parsePokeMovesCSV(gameGenRef)
                    breaker += 1
                    if breaker == 2 {
                        break
                    }
                }
            }
        }
        if gameGenRef != 16 {
            gameGenRef += 1
            pokemon.parsePokeMovesCSV(gameGenRef)
            cycleThrough()
        } else {
            gameGenRef = gameVersionGen[returnMinGameGen(Int(pokemon.generationId)!)]
            pokemon.parsePokeMovesCSV(gameGenRef)
            cycleThrough()
        }
        pokemon.parsePokeMovesCSV(gameGenRef)
        moveVersionLabel.text = "Gen \(gameVersionGen[gameGenRef-1]): \(games[gameGenRef-1])"
        self.tableHeight.constant = CGFloat(pokemon.moveList.count) * 44
        self.view.layoutIfNeeded()
        tableView.reloadData()
    }
    
    func newFormSetup() {
        handlePokemonForms()
        
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: {
                self.setupGraphsForNewPokemon()
            },
            completion: nil)
        updateUI()
    }
    
    func updateFormWhenPressed(formNumber: Int) {
        pokemon.parsePokeFormStatsCSV(formNumber)
        newFormSetup()
        let cell = self.collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: pokemon.pokedexId-1, inSection: 0)) as! MainImageViewCell
        cell.configureImageCell(pokemon.pokedexId,formReference: formNumber)
        initCries(formNumber)

    }
    
    func revertToOrignalFromMega() {
        let cell = self.collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: pokemon.pokedexId-1, inSection: 0)) as! MainImageViewCell
        cell.configureImageCell(pokemon.pokedexId,formReference: 0)
        newPokemonSetup()
        initCries(0)
        self.view.layoutIfNeeded()
    }
    
    @IBAction func scrollToPrevEvo(sender: UIButton!) {
        
        if pokemon.firstGenEvolution != "" {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: Int(pokemon.firstGenEvolution)!-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        } else if pokemon.thirdGenEvolution != "" {
            revertToOrignalFromMega()
        } else {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: Int(pokemon.previousEvolutionId)!-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
    }
    
    @IBAction func nextEvo(sender: UIButton!) {
        
        if pokemon.thirdGenEvolution != "" {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: Int(pokemon.thirdGenEvolution)!-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        } else if pokemon.firstGenEvolution != "" {
                revertToOrignalFromMega()
            } else {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: Int(pokemon.nextEvolutionId)!-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
    }
    
    @IBAction func scrollTo2ndGen(sender: AnyObject) {
        
        if pokemon.thirdGenEvolution != "" {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: Int(pokemon.nextEvolutionId)!-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        } else if pokemon.firstGenEvolution != "" {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: Int(pokemon.previousEvolutionId)!-1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        } else {
            revertToOrignalFromMega()
        }
    }
    
    @IBAction func nextPokemonTouch(sender: UIButton) {
        if pokemon.pokedexId != 721 {
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: pokemon.pokedexId, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
            sender.alpha = 1.0
        }
    }
    
    @IBAction func prevPokemonTouch(sender: UIButton) {
        if pokemon.pokedexId != 1 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: pokemon.pokedexId-2, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
    }
    
    @IBAction func form1Button(sender: UIButton) {
        updateFormWhenPressed(1)
    }
    @IBAction func form2Button(sender: UIButton) {
        updateFormWhenPressed(2)
    }
    @IBAction func form3Button(sender: UIButton) {
        updateFormWhenPressed(3)
    }
    @IBAction func form4Button(sender: UIButton) {
        updateFormWhenPressed(4)
    }
    @IBAction func form5Button(sender: UIButton) {
        updateFormWhenPressed(5)
    }
    @IBAction func form6Button(sender: UIButton) {
        updateFormWhenPressed(6)
    }
    
    @IBAction func changeDexEntry(sender: UIButton) {
        changeDexEntryUp()
        timer.invalidate()
    }
}



