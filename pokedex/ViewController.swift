//
//  ViewController.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-03.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // UI Labels, SearchBar and CollectionView

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var triangleDown: UIImageView!
    @IBOutlet weak var pokeballHeader: UIImageView!
    
  
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var AscendingSort = true
    var statId: Int = 0
    var rotatePosition: CGFloat = 0
    
    override func viewWillAppear(animated: Bool) {
            rotateOnce()
            }
    
    func rotateOnce() {
        
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: {
                self.pokeballHeader.transform = CGAffineTransformRotate(self.pokeballHeader.transform, CGFloat(1 * M_PI))
            },
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        statLabel.text = statsList[statId]
        
        parsePokemonCSV()
    }
    
    func parsePokemonCSV() {
        
        let path = NSBundle.mainBundle().pathForResource("pokeinit", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let type1 = row["type1_id"]!
                let type2 = row["type2_id"]!
                let gen = row["gen"]!
                let heightStat = row["height_ft"]!
                let weightStat = row["weight_lbs"]!
                let hpStat = row["hp"]!
                let attStat = row["attack"]!
                let defStat = row["defense"]!
                let spAttStat = row["special_attack"]!
                let spDefStat = row["special_defense"]!
                let spdStat = row["speed"]!
                let baseStat = row["base_stats"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId,type1: type1,type2: type2,gen: gen, heightStat: heightStat, weightStat: weightStat, hpStat: hpStat, attStat: attStat, defStat: defStat, spAttStat: spAttStat, spDefStat: spDefStat, spdStat:spdStat, baseStat:baseStat)
                
                pokemon.append(poke)

            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCellCollectionViewCell {

            
            let poke: Pokemon!
            
            if inSearchMode{
                
            poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell
        
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
           poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        
        // iPhone 4S etc
        
        if width < 350 {
            return CGSizeMake(85, 85)
        }
        
        // iPads
        
        if width > 750 {
            return CGSizeMake(165, 165)
        }
        
        // iPhone 6
        
        return CGSizeMake(107, 107)
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Handle case for empty search bar
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            appropriateSort()
            collection.reloadData()
        } else {
            inSearchMode = true
            
        // Filter based on whether string matches Name, Type or Gen. Simple and dynamic searching possible.
            
            let lower = searchBar.text!.lowercaseString
                
            filteredPokemon = pokemon.filter() {
                let name = $0.name.lowercaseString.rangeOfString(lower) != nil
                let firstType = $0.type1.lowercaseString.rangeOfString(lower) != nil
                let secondType = $0.type2.lowercaseString.rangeOfString(lower) != nil
                let generation = $0.generationId.lowercaseString.rangeOfString(lower) != nil
                return name || firstType || secondType || generation
        }
        collection.reloadData()
        }
    }
    
    // Following functions perform a sort base on the ID passed to it, which represents a Pokemon Stat
    
    func sortByAscend(statId: Int){
        
        if statId == 0 {
            pokemon.sortInPlace ({($0.pokedexId) < ($1.pokedexId)})
        }
        if statId == 1 {
            pokemon.sortInPlace ({($0.name) < ($1.name)})
        }
        if statId == 2 {
            pokemon.sortInPlace ({ Float($0.height) < Float($1.height)})
        }
        if statId == 3 {
            pokemon.sortInPlace ({ Float($0.weight) < Float($1.weight)})
        }
        if statId == 4 {
            pokemon.sortInPlace ({ Float($0.hp) < Float($1.hp)})
        }
        if statId == 5 {
            pokemon.sortInPlace ({ Float($0.attack) < Float($1.attack)})
        }
        if statId == 6 {
            pokemon.sortInPlace ({ Float($0.defense) < Float($1.defense)})
        }
        if statId == 7 {
            pokemon.sortInPlace ({ Float($0.specialAttack) < Float($1.specialAttack)})
        }
        if statId == 8 {
            pokemon.sortInPlace ({ Float($0.specialDefense) < Float($1.specialDefense)})
        }
        if statId == 9 {
            pokemon.sortInPlace ({ Float($0.speed) < Float($1.speed)})
        }
        if statId == 10 {
            pokemon.sortInPlace ({ Float($0.baseStats) < Float($1.baseStats)})
        }

        collection.reloadData()
    }
    
    func sortByDescend(statId: Int){
        
        if statId == 0 {
            pokemon.sortInPlace ({($0.pokedexId) > ($1.pokedexId)})
        }
        if statId == 1 {
            pokemon.sortInPlace ({($0.name) > ($1.name)})
        }
        if statId == 2 {
            pokemon.sortInPlace ({ Float($0.height) > Float($1.height)})
        }
        if statId == 3 {
            pokemon.sortInPlace ({ Float($0.weight) > Float($1.weight)})
        }
        if statId == 4 {
            pokemon.sortInPlace ({ Float($0.hp) > Float($1.hp)})
        }
        if statId == 5 {
            pokemon.sortInPlace ({ Float($0.attack) > Float($1.attack)})
        }
        if statId == 6 {
            pokemon.sortInPlace ({ Float($0.defense) > Float($1.defense)})
        }
        if statId == 7 {
            pokemon.sortInPlace ({ Float($0.specialAttack) > Float($1.specialAttack)})
        }
        if statId == 8 {
            pokemon.sortInPlace ({ Float($0.specialDefense) > Float($1.specialDefense)})
        }
        if statId == 9 {
            pokemon.sortInPlace ({ Float($0.speed) > Float($1.speed)})
        }
        if statId == 10 {
            pokemon.sortInPlace ({ Float($0.baseStats) > Float($1.baseStats)})
        }
        
        collection.reloadData()
    }
    
    func sortByAscendFiltered(statId: Int){
        
        if statId == 0 {
            filteredPokemon.sortInPlace ({($0.pokedexId) < ($1.pokedexId)})
        }
        if statId == 1 {
            filteredPokemon.sortInPlace ({($0.name) < ($1.name)})
        }
        if statId == 2 {
            filteredPokemon.sortInPlace ({ Float($0.height) < Float($1.height)})
        }
        if statId == 3 {
            filteredPokemon.sortInPlace ({ Float($0.weight) < Float($1.weight)})
        }
        if statId == 4 {
            filteredPokemon.sortInPlace ({ Float($0.hp) < Float($1.hp)})
        }
        if statId == 5 {
            filteredPokemon.sortInPlace ({ Float($0.attack) < Float($1.attack)})
        }
        if statId == 6 {
            filteredPokemon.sortInPlace ({ Float($0.defense) < Float($1.defense)})
        }
        if statId == 7 {
            filteredPokemon.sortInPlace ({ Float($0.specialAttack) < Float($1.specialAttack)})
        }
        if statId == 8 {
            filteredPokemon.sortInPlace ({ Float($0.specialDefense) < Float($1.specialDefense)})
        }
        if statId == 9 {
            filteredPokemon.sortInPlace ({ Float($0.speed) < Float($1.speed)})
        }
        if statId == 10 {
            filteredPokemon.sortInPlace ({ Float($0.baseStats) < Float($1.baseStats)})
        }
        
        collection.reloadData()
    }
    
    func sortByDescendFiltered(statId: Int){
        
        if statId == 0 {
            filteredPokemon.sortInPlace ({($0.pokedexId) > ($1.pokedexId)})
        }
        if statId == 1 {
            filteredPokemon.sortInPlace ({($0.name) > ($1.name)})
        }
        if statId == 2 {
            filteredPokemon.sortInPlace ({ Float($0.height) > Float($1.height)})
        }
        if statId == 3 {
            filteredPokemon.sortInPlace ({ Float($0.weight) > Float($1.weight)})
        }
        if statId == 4 {
            filteredPokemon.sortInPlace ({ Float($0.hp) > Float($1.hp)})
        }
        if statId == 5 {
            filteredPokemon.sortInPlace ({ Float($0.attack) > Float($1.attack)})
        }
        if statId == 6 {
            filteredPokemon.sortInPlace ({ Float($0.defense) > Float($1.defense)})
        }
        if statId == 7 {
            filteredPokemon.sortInPlace ({ Float($0.specialAttack) > Float($1.specialAttack)})
        }
        if statId == 8 {
            filteredPokemon.sortInPlace ({ Float($0.specialDefense) > Float($1.specialDefense)})
        }
        if statId == 9 {
            filteredPokemon.sortInPlace ({ Float($0.speed) > Float($1.speed)})
        }
        if statId == 10 {
            filteredPokemon.sortInPlace ({ Float($0.baseStats) > Float($1.baseStats)})
        }
        
        collection.reloadData()
    }

    
    func appropriateSort(){
        
        // Function performs a sort based on current sort state and whether pokemon list is filtered or not.
        
        if AscendingSort == true && inSearchMode == false {
            sortByAscend(statId)
        } else if AscendingSort == false && inSearchMode == false {
            sortByDescend(statId)
        } else if AscendingSort == true && inSearchMode == true {
            sortByAscendFiltered(statId)
        } else if AscendingSort == false && inSearchMode == true {
            sortByDescendFiltered(statId)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    func labelSetter(reference: Int) {
        statLabel.text = statsList[reference]
    }
    
    func animateTriangle(position: CGFloat) {
        UIView.animateWithDuration(0.15, animations: {
            self.triangleDown.transform = CGAffineTransformMakeRotation((position * CGFloat(M_PI)) / 180.0)
        })
    }
    
    @IBAction func descendingAscending(sender: UIButton) {
        
        if AscendingSort == true {
            AscendingSort = false
            animateTriangle(180.0)
        } else if AscendingSort == false {
            AscendingSort = true
            animateTriangle(0.0)
        }
        appropriateSort()
    }
    
    @IBAction func previousStat(sender: UIButton) {
        
        statId--
        if statId < 0 {
            statId = 10
        }
        labelSetter(statId)
        appropriateSort()
    }
    
    @IBAction func nextStat(sender: UIButton) {
        statId++
        if statId > 10 {
            statId = 0
        }
        labelSetter(statId)
        appropriateSort()
    }
}

