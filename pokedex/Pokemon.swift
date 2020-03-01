//
//  Pokemon.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import Foundation

class Pokemon {
    
    // MARK: Variables
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
    fileprivate var _description: String!
    fileprivate var _gameName: String!
    fileprivate var _gameIdNo: Int!
    
    fileprivate var _type1: String!
    fileprivate var _type2: String!
    
    fileprivate var _hp: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    fileprivate var _specialAttack: String!
    fileprivate var _specialDefense: String!
    fileprivate var _speed: String!
    fileprivate var _baseStats: String!
    
    fileprivate var _height: String!
    fileprivate var _weight: String!
    
    fileprivate var _generationId: String!

    fileprivate var _nextEvolutionText: String!
    fileprivate var _nextEvolutionId: String!
    fileprivate var _nextEvolutionLevel: String!
    
    fileprivate var _previousEvolutionId: String!
    fileprivate var _previousEvolutionLevel: String!
    
    fileprivate var _firstGenEvolution: String!
    fileprivate var _thirdGenEvolution: String!
    
    fileprivate var _evolvedFromTrigger: String!
    fileprivate var _evolvedFromTriggerItem: String!
    fileprivate var _evolvesToTrigger: String!
    fileprivate var _evolvesToTriggerItem: String!
    
    fileprivate var _eventualTrigger: String!
    fileprivate var _eventualTriggerItem: String!
    fileprivate var _originalTrigger: String!
    fileprivate var _originalTriggerItem: String!
    
    fileprivate var _numberForms: String!
    fileprivate var _isMega: String!
    
    fileprivate var _firstAbility: String!
    fileprivate var _firstAbilityDesc: String!
    fileprivate var _secondAbility: String!
    fileprivate var _secondAbilityDesc: String!
    fileprivate var _hiddenAbility: String!
    fileprivate var _hiddenAbilityDesc: String!
    
    fileprivate var _pokemonUrl: String!
    
    fileprivate var _moveList: [String]!
    fileprivate var _levelList: [Int]!
    fileprivate var _typeList: [String]!
    fileprivate var _powerList: [String]!
    fileprivate var _accuracyList: [String]!
    
    //MARK: Getters
    
    
    var moveList: [String] {
        if _moveList == nil {
            _moveList = []
        }
        return _moveList
    }
    
    var levelList: [Int] {
        if _levelList == nil {
            _levelList = []
        }
        return _levelList
    }
    
    var typeList: [String] {
        if _typeList == nil {
            _typeList = []
        }
        return _typeList
    }
    
    var powerList: [String] {
        if _powerList == nil {
            _powerList = []
        }
        return _powerList
    }
    
    var accuracyList: [String] {
        if _accuracyList == nil {
            _accuracyList = []
        }
        return _accuracyList
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var gameName: String {
        if _gameName == nil {
            _gameName = ""
        }
        return _gameName
    }
    
    var gameIdNo: Int {
        return _gameIdNo
    }
    
    var type1: String {
        if _type1 == nil {
            _type1 = ""
        }
        return _type1
    }
    
    var type2: String {
        if _type2 == nil {
            _type2 = ""
        }
        return _type2
    }
    
    var hp: String {
        if _hp == nil {
            _hp = ""
        }
        return _hp
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
        
    var specialAttack: String {
        if _specialAttack == nil {
            _specialAttack = ""
        }
        return _specialAttack
    }
        
    var specialDefense: String {
        if _specialDefense == nil {
            _specialDefense = ""
        }
        return _specialDefense
    }
    
    var speed: String {
        if _speed == nil {
            _speed = ""
        }
        return _speed
    }
    
    var baseStats: String {
        if _baseStats == nil {
            _baseStats = ""
        }
        return _baseStats
    }
    
    var generationId: String {
        if _generationId == nil {
            _generationId = ""
        }
        return _generationId
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }

    var nextEvolutionLevel: String {
        
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
        }
            return _nextEvolutionLevel
    }
    
    var previousEvolutionId: String {
        
        if _previousEvolutionId == nil {
            _previousEvolutionId = ""
        }
        return _previousEvolutionId
    }
    
    var previousEvolutionLevel: String {
        
        if _previousEvolutionLevel == nil {
            _previousEvolutionLevel = ""
        }
        return _previousEvolutionLevel
    }
    
    var firstGenEvolution: String {
        
        if _firstGenEvolution == nil {
            _firstGenEvolution = ""
        }
        return _firstGenEvolution
    }
    
    var thirdGenEvolution: String {
        
        if _thirdGenEvolution == nil {
            _thirdGenEvolution = ""
        }
        return _thirdGenEvolution
    }
    
    var evolvedFromTrigger: String {
        
        if _evolvedFromTrigger == nil {
            _evolvedFromTrigger = ""
        }
        return _evolvedFromTrigger
    }
    
    var evolvedFromTriggerItem: String {
        
        if _evolvedFromTriggerItem == nil {
            _evolvedFromTriggerItem = ""
        }
        return _evolvedFromTriggerItem
    }
    
    var evolvesToTrigger: String {
        
        if _evolvesToTrigger == nil {
            _evolvesToTrigger = ""
        }
        return _evolvesToTrigger
    }
    
    var evolvesToTriggerItem: String {
        
        if _evolvesToTriggerItem == nil {
            _evolvesToTriggerItem = ""
        }
        return _evolvesToTriggerItem
    }
    
    var eventualTrigger: String {
        
        if _eventualTrigger == nil {
            _eventualTrigger = ""
        }
        return _eventualTrigger
    }
    
    var eventualTriggerItem: String {
        
        if _eventualTriggerItem == nil {
            _eventualTriggerItem = ""
        }
        return _eventualTriggerItem
    }
    
    var originalTrigger: String {
        
        if _originalTrigger == nil {
            _originalTrigger = ""
        }
        return _originalTrigger
    }
    
    var originalTriggerItem: String {
        
        if _originalTriggerItem == nil {
            _originalTriggerItem = ""
        }
        return _originalTriggerItem
    }
    
    // Changes form bool
    
    var numberForms: String {
        
        if _numberForms == nil {
            _numberForms = ""
        }
        return _numberForms
    }
    
    var isMega: String {
        
        if _isMega == nil {
            _isMega = ""
        }
        return _isMega
    }
    
    // Abilities
    
    var firstAbility: String {
        
        if _firstAbility == nil {
            _firstAbility = ""
        }
        return _firstAbility
    }
    
    var firstAbilityDesc: String {
        
        if _firstAbilityDesc == nil {
            _firstAbilityDesc = ""
        }
        return _firstAbilityDesc
    }
    
    var secondAbility: String {
        
        if _secondAbility == nil {
            _secondAbility = ""
        }
        return _secondAbility
    }
    
    var secondAbilityDesc: String {
        
        if _secondAbilityDesc == nil {
            _secondAbilityDesc = ""
        }
        return _secondAbilityDesc
    }
    
    var hiddenAbility: String {
        
        if _hiddenAbility == nil {
            _hiddenAbility = ""
        }
        return _hiddenAbility
    }
    
    var hiddenAbilityDesc: String {
        
        if _hiddenAbilityDesc == nil {
            _hiddenAbilityDesc = ""
        }
        return _hiddenAbilityDesc
    }

    //MARK: Initialisers
    
    init(name: String, pokedexId: Int, type1: String, type2: String, gen: String, heightStat: String, weightStat: String, hpStat: String, attStat: String, defStat: String, spAttStat: String, spDefStat: String, spdStat: String, baseStat: String) {
        self._name = name
        self._pokedexId = pokedexId
        self._type1 = type1
        self._type2 = type2
        self._generationId = gen
        self._height = heightStat
        self._weight = weightStat
        self._hp = hpStat
        self._attack = attStat
        self._defense = defStat
        self._specialAttack = spAttStat
        self._specialDefense = spDefStat
        self._speed = spdStat
        self._baseStats = baseStat
    
    }
    
    init(pokedexId: Int) {
        self._pokedexId = pokedexId
    }
    
    
    
    //MARK: Parse stats
    
    func parsePokeStatsCSV() {
        
        let path = Bundle.main.path(forResource: "pokemonId\(pokedexId)", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                // Name
                
                if let name = row["identifier"] {
                    self._name = name
                }
                
                // Height + Weight
                
                if let height = row["height_ft"] {
                    self._height = height
                }
                
                if let weight = row["weight_lbs"] {
                    self._weight = weight
                }
                
                // Base Stats
                
                if let hp = row["hp"] {
                    self._hp = hp
                }
                
                if let attack = row["attack"] {
                    self._attack = attack
                }
                
                if let defense = row["defense"] {
                    self._defense = defense
                }
                
                if let specialAttack = row["special_attack"] {
                    self._specialAttack = specialAttack
                }
                
                if let specialDefense = row["special_defense"] {
                    self._specialDefense = specialDefense
                }
                
                if let speed = row["speed"] {
                    self._speed = speed
                }
                
                if let baseStats = row["base_stats"] {
                    self._baseStats = baseStats
                }
                
                // Types
                
                if let type1 = row["type1_id"] {
                    self._type1 = type1
                }
                
                if let type2 = row["type2_id"] {
                    self._type2 = type2
                }
                
                if let generationId = row["generation_id"] {
                    self._generationId = generationId
                }
                
                // Evolutions
                
                if let previousEvolutionId = row["evolves_from_species_id"] {
                    self._previousEvolutionId = previousEvolutionId
                }
                
                if let nextEvolutionId = row["evolves_to_id"] {
                    self._nextEvolutionId = nextEvolutionId
                }
                
                if let thirdGenEvolution = row["third_gen_id"] {
                    self._thirdGenEvolution = thirdGenEvolution
                    
                }
                
                if let firstGenEvolution = row["1st _gen_id"] {
                    self._firstGenEvolution = firstGenEvolution
                }
                
                // Evolution Levels
                
                if let previousEvolutionLevel = row["minimum_level"] {
                    self._previousEvolutionLevel = previousEvolutionLevel
                    
                }
                
                if let nextEvolutionLevel = row["evolves_at"] {
                    self._nextEvolutionLevel = nextEvolutionLevel
                }
                
                // Evolution Triggers
                
                if let evolvedFromTrigger = row["evolved_from_trigger"] {
                    self._evolvedFromTrigger = evolvedFromTrigger
                }
                
                if let evolvedFromTriggerItem = row["evolved_from_trigger_item"] {
                    self._evolvedFromTriggerItem = evolvedFromTriggerItem
                }
                
                if let evolvesToTrigger = row["evolves_trigger"] {
                    self._evolvesToTrigger = evolvesToTrigger
                }
                
                if let evolvesToTriggerItem = row["evolves_to_trigger"] {
                    self._evolvesToTriggerItem = evolvesToTriggerItem
                }
                
                // Evolution Triggers for 3 stage Evols
                
                
                if let eventualTrigger = row["eventual_evolves_trigger"] {
                    self._eventualTrigger = eventualTrigger
                }
                
                if let eventualTriggerItem = row["eventual_evolves_trigger_item"] {
                    self._eventualTriggerItem = eventualTriggerItem
                }
                
                if let originalTrigger = row["original_evolution_trigger"] {
                    self._originalTrigger = originalTrigger
                }
                
                if let originalTriggerItem = row["original_evolution_trigger_item"] {
                    self._originalTriggerItem = originalTriggerItem
                }
                
                // Changes form indicator
                
                if let numberForms = row["changes_form"] {
                    self._numberForms = numberForms
                }
                
                // Abilities
                
                if let firstAbility = row["first_ability_name"] {
                    self._firstAbility = firstAbility
                }
                
                if let firstAbilityDesc = row["first_ability_desc"] {
                    self._firstAbilityDesc = firstAbilityDesc
                }
                
                if let secondAbility = row["second_ability_name"] {
                    self._secondAbility = secondAbility
                }
                
                if let secondAbilityDesc = row["second_ability_desc"] {
                    self._secondAbilityDesc = secondAbilityDesc
                }
                
                if let hiddenAbility = row["hidden_ability_name"] {
                    self._hiddenAbility = hiddenAbility
                }
                
                if let hiddenAbilityDesc = row["hidden_ability_desc"] {
                    self._hiddenAbilityDesc = hiddenAbilityDesc
                }
                
            }
        } catch let err as NSError {
                print(err.debugDescription)
        }
    }
    
    // Get names of forms
    
    func pokemonFormNames(_ formIndex: Int) -> String {
            
        let path = Bundle.main.path(forResource: "newformpokeId\(pokedexId)", ofType: "csv")!
        
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                
                for row in rows {
                    
                    if formIndex == Int(row["form_number"]!)! {
                        
                        if let formName = row["form_name"] {
                            return formName
                        }
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
                
        return ""
}
    
    // Get Stats of Forms
    
    
    func parsePokeFormStatsCSV(_ formIndex: Int) {
        
        let path = Bundle.main.path(forResource: "newformpokeId\(pokedexId)", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                if formIndex == Int(row["form_number"]!) {
                    
                    // Types
                    
                    if let type1 = row["type_1"] {
                        self._type1 = type1
                    }
                    
                    if let type2 = row["type_2"] {
                        self._type2 = type2
                    }
                    
                    // Height + Weight
                    
                    if let height = row["height"] {
                        self._height = height
                    }
                    
                    if let weight = row["weight"] {
                        self._weight = weight
                    }
                    
                    // Base Stats
                    
                    if let hp = row["HP"] {
                        self._hp = hp
                    }
                    
                    if let attack = row["attack"] {
                        self._attack = attack
                    }
                    
                    if let defense = row["defense"] {
                        self._defense = defense
                    }
                    
                    if let specialAttack = row["special_attack"] {
                        self._specialAttack = specialAttack
                    }
                    
                    if let specialDefense = row["special_defense"] {
                        self._specialDefense = specialDefense
                    }
                    
                    if let speed = row["speed"] {
                        self._speed = speed
                    }
                    
                    if let baseStats = row["base_stat"] {
                        self._baseStats = baseStats
                    }
                    
                    // Abilities
                    
                    if let isMega = row["is_mega"] {
                        self._isMega = isMega
                    }
                    
                    if let firstAbility = row["first_ability_name"] {
                        self._firstAbility = firstAbility
                    }
                    
                    if let firstAbilityDesc = row["first_ability_desc"] {
                        self._firstAbilityDesc = firstAbilityDesc
                    }
                    
                    if let secondAbility = row["second_ability_name"] {
                        self._secondAbility = secondAbility
                    }
                    
                    if let secondAbilityDesc = row["second_ability_desc"] {
                        self._secondAbilityDesc = secondAbilityDesc
                    }
                    
                    if let hiddenAbility = row["hidden_ability_name"] {
                        self._hiddenAbility = hiddenAbility
                    }
                    
                    if let hiddenAbilityDesc =
                        row["hidden_ability_desc"] {
                            self._hiddenAbilityDesc = hiddenAbilityDesc
                    }
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    // MARK: Parse Moves
    
    func parsePokeMovesCSV(_ selectedVersionLabel: Int) {
        
        var moveListBuild: [String] = []
        var levelListBuild: [Int] = []
        var typeListBuild: [String] = []
        var powerListBuild: [String] = []
        var accuracyListBuild: [String] = []
        
        let path = Bundle.main.path(forResource: "pokeMoveId\(pokedexId)", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                if selectedVersionLabel == Int(row["version_group_id"]!) {
                    
                    moveListBuild.append(row["move_name"]!)
                    levelListBuild.append(Int(row["level"]!)!)
                    typeListBuild.append(row["type"]!)
                    powerListBuild.append(row["power"]!)
                    accuracyListBuild.append(row["accuracy"]!)
                    
                }
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    
        self._moveList = moveListBuild
        self._levelList = levelListBuild
        self._typeList = typeListBuild
        self._powerList = powerListBuild
        self._accuracyList = accuracyListBuild
    
        
    }
    
    // MARK: Pokedex Entry sorting
    
    
    
    func parsePokedexEntryCSV(_ selectedVersionLabel: Int) {
        
        let path = Bundle.main.path(forResource: "pokemonDescId\(pokedexId)", ofType: "csv")!
        
        var entryExists: Bool = false
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                if selectedVersionLabel == Int(row["pokedex_version_id"]!) {
                    // Pokedex for specified game
                    self._description = row["flavor_text"]
                    self._gameName = row["game_name"]
                    self._gameIdNo = Int(row["pokedex_version_id"]!)
                    
                    entryExists = true
                    
                }
                
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        if entryExists == false {
            self._description = ""
            self._gameName = ""
            self._gameIdNo = 0
        }
    }
    
    

    //MARK: Alamofire HTTP protocol for downloading from PokeAPI
    
    
    
/*    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                        
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                                
                            }
                            
                            completed()
                        }
                    }
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        // Parsing out Mega pokemon
                        
                        if to.rangeOfString("mega") == nil {
                            
                            if let jsonUri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = jsonUri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionText = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }

                            }
                        }
                    }
                }
                
            }
        }
    } */
}
