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
    
    @IBOutlet weak var scrollBtnContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var sortBtnView: UIView!
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
  
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var AscendingSort = true
    var statId: Int = 0
    var rotatePosition: CGFloat = 0
    var sortMode = false
    var sortAnimationRun = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
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
        
        let WIDTH_FACTOR: CGFloat = 3.6
        let dim = width/WIDTH_FACTOR
        
        if (UIDevice.currentDevice().model.rangeOfString("iPad") != nil) {
            return CGSizeMake(148, 148)
        } else {
            return CGSizeMake(dim, dim)
        }
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
    
    func createButtons(label: String, tag: Int) -> UIButton {
        let btn = UIButton()
        let dim: CGFloat = 44
        btn.frame = CGRectMake(0,0,dim,dim)
        btn.layer.cornerRadius = dim/4
        btn.layer.backgroundColor = UIColor(red: 0.9333, green: 0.0039, blue: 0.3176, alpha: 1.0).CGColor
        btn.setTitle(label, forState: .Normal)
        btn.tag = tag
        btn.titleLabel!.font = UIFont(name: "Gill Sans", size: 12)
        btn.addTarget(self, action: #selector(ViewController.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        return btn
    }
    
    func buttonAction(sender:UIButton!) {
        statId = sender.tag
        labelSetter(statId)
        appropriateSort()
    }
    
    @IBAction func sortBtn(sender: UIButton) {
        
        if sortMode == false {
        
            sortBtnView.hidden = false
            horizontalScrollView.contentSize = CGSizeMake(50 * CGFloat(statsListAbbrev.count) + 40, 60)
            
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5,  options: .CurveEaseInOut, animations: {
            self.scrollBtnContainerHeight.constant = 60
                self.view.layoutIfNeeded()
                }, completion: nil)
            
            
            self.sortMode = true
            if !self.sortAnimationRun == true {
                
                for i in 0...statsListAbbrev.count-1 {
                let sortBtn = self.createButtons(statsListAbbrev[i], tag: i)
                sortBtn.frame = CGRectMake(-44, 8, 44, 44)
                self.horizontalScrollView.addSubview(sortBtn)
        
                UIView.animateWithDuration(0.8, delay: 0.35, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5,  options: .CurveEaseInOut, animations: {
                sortBtn.frame = CGRectMake(20 + CGFloat(50*i), 8, 44, 44)
                    }, completion: {finished in
                self.sortAnimationRun = true
                    })
                }
            }
        
        } else {
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5,  options: .CurveEaseInOut, animations: {
                self.scrollBtnContainerHeight.constant = 0
                self.view.layoutIfNeeded()
                }, completion: {finished in
                    self.sortMode = false
            })
        }
    }
    

    
    @IBAction func previousStat(sender: UIButton) {
        
        statId -= 1
        if statId < 0 {
            statId = 10
        }
        labelSetter(statId)
        appropriateSort()
    }
    
    @IBAction func nextStat(sender: UIButton) {
        statId += 1
        if statId > 10 {
            statId = 0
        }
        labelSetter(statId)
        appropriateSort()
    }
}

