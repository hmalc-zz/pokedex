//
//  Pokemon.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import Foundation
//import Alamofire

class Pokemon {
    
    // MARK: Variables
    
    private var _name: String!
    private var _pokedexId: Int!
    
    private var _description: String!
    private var _gameName: String!
    private var _gameIdNo: Int!
    
    private var _type1: String!
    private var _type2: String!
    
    private var _hp: String!
    private var _defense: String!
    private var _attack: String!
    private var _specialAttack: String!
    private var _specialDefense: String!
    private var _speed: String!
    private var _baseStats: String!
    
    private var _height: String!
    private var _weight: String!
    
    private var _generationId: String!

    private var _nextEvolutionText: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    private var _previousEvolutionId: String!
    private var _previousEvolutionLevel: String!
    
    private var _firstGenEvolution: String!
    private var _thirdGenEvolution: String!
    
    private var _evolvedFromTrigger: String!
    private var _evolvedFromTriggerItem: String!
    private var _evolvesToTrigger: String!
    private var _evolvesToTriggerItem: String!
    
    private var _firstAbility: String!
    private var _firstAbilityDesc: String!
    private var _secondAbility: String!
    private var _secondAbilityDesc: String!
    private var _hiddenAbility: String!
    private var _hiddenAbilityDesc: String!
    
    private var _pokemonUrl: String!
    
    private var _moveList: [String]!
    private var _levelList: [Int]!
    
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

    //MARK: Initialiser
    
    init(name: String, pokedexId: Int, type1: String, type2: String) {
        self._name = name
        self._pokedexId = pokedexId
        self._type1 = type1
        self._type2 = type2
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    
    }
    
    init(pokedexId: Int) {
        self._pokedexId = pokedexId
        
    }
    
    
    
    //MARK: Parse stats
    
    func parsePokeStatsCSV() {
        
        let path = NSBundle.mainBundle().pathForResource("pokemonId\(pokedexId)", ofType: "csv")!
        
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
                
                if let _evolvesToTrigger = row["evolves_trigger"] {
                    self._evolvesToTrigger = _evolvesToTrigger
                }
                
                if let evolvesToTriggerItem = row["evolves_to_trigger"] {
                    self._evolvesToTriggerItem = evolvesToTriggerItem
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
                
                if let hiddenAbilityDesc =
                    row["hidden_ability_desc"] {
                    self._hiddenAbilityDesc = hiddenAbilityDesc
                }
                
            }
        } catch let err as NSError {
                print(err.debugDescription)
        }
    }
    
    // MARK: Parse Moves
    
    func parsePokeMovesCSV(selectedVersionLabel: Int) {
        
        var moveIndex: [Int:String] = [:]
        var levelListBuild: [Int] = []
        var moveListBuild: [String] = []
        
        let path = NSBundle.mainBundle().pathForResource("pokeMoveId\(pokedexId)", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                if selectedVersionLabel == Int(row["version_group_id"]!) {
                    
                    let key = Int((row["level"])!)
                    
                    moveIndex[key!] = row["move_name"]
                    
                }
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let sortedDict = moveIndex.sort { $0.0 < $1.0 }
        
        for var i = 0; i < sortedDict.count; i++ {
            
            let moveName = String(sortedDict[i].1)
            let levelName = Int(sortedDict[i].0)
            
            levelListBuild.append(levelName)
            moveListBuild.append(moveName)
            
            
        }
        
        self._levelList = levelListBuild
        self._moveList = moveListBuild
        
    }
    
    // MARK: Pokedex Entry sorting
    
    func parsePokedexEntryCSV(selectedVersionLabel: Int) {
        
        let path = NSBundle.mainBundle().pathForResource("pokemonDescId\(pokedexId)", ofType: "csv")!
        
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