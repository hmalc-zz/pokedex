 //
//  ViewController.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-03.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // UI Labels, SearchBar and CollectionView

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var triangleDown: UIImageView!
    @IBOutlet weak var pokeballHeader: UIImageView!
    
    @IBOutlet weak var scrollBtnContainerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var containerSpacing: NSLayoutConstraint!
    @IBOutlet weak var sortBtnView: UIView!
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    @IBOutlet weak var musicButtonImage: UIImageView!
  
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
        searchBar.returnKeyType = UIReturnKeyType.done
        setMusicButtonImage()
        parsePokemonCSV()
    }
    
    func setMusicButtonImage(){
        let soundsEnabled = UserDefaults.standard.bool(forKey: "AreSoundsEnabled")
        if soundsEnabled == false {
            musicButtonImage.alpha = 0.7
        } else {
            musicButtonImage.alpha = 1
        }
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokeinit", ofType: "csv")!
        
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCellCollectionViewCell {

            let poke: Pokemon!
            
            if inSearchMode{
                
            poke = filteredPokemon[(indexPath as NSIndexPath).row]
            } else {
                poke = pokemon[(indexPath as NSIndexPath).row]
            }
            
            cell.configureCell(poke)
            return cell
        
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
           poke = filteredPokemon[(indexPath as NSIndexPath).row]
        } else {
            poke = pokemon[(indexPath as NSIndexPath).row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        // iPhone 4S etc
        
        let WIDTH_FACTOR: CGFloat = 3.6
        let dim = width/WIDTH_FACTOR
        
        if (UIDevice.current.model.range(of: "iPad") != nil) {
            return CGSize(width: 148, height: 148)
        } else {
            return CGSize(width: dim, height: dim)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Handle case for empty search bar
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            appropriateSort()
            collection.reloadData()
        } else {
            inSearchMode = true
            
        // Filter based on whether string matches Name, Type or Gen. Simple and dynamic searching possible.
            
            let lower = searchBar.text!.lowercased()
                
            filteredPokemon = pokemon.filter() {
                let name = $0.name.lowercased().range(of: lower) != nil
                let firstType = $0.type1.lowercased().range(of: lower) != nil
                let secondType = $0.type2.lowercased().range(of: lower) != nil
                let generation = $0.generationId.lowercased().range(of: lower) != nil
                return name || firstType || secondType || generation
        }
        collection.reloadData()
        }
    }
    
    // Following functions perform a sort base on the ID passed to it, which represents a Pokemon Stat
    
    func sortByAscend(_ statId: Int){
        
        if statId == 0 {
            pokemon.sort (by: {($0.pokedexId) < ($1.pokedexId)})
        }
        if statId == 1 {
            pokemon.sort (by: {($0.name) < ($1.name)})
        }
        if statId == 2 {
            pokemon.sort (by: { ($0.height) < ($1.height)})
        }
        if statId == 3 {
            pokemon.sort (by: { ($0.weight) < ($1.weight)})
        }
        if statId == 4 {
            pokemon.sort (by: { ($0.hp) < ($1.hp)})
        }
        if statId == 5 {
            pokemon.sort (by: { ($0.attack) < ($1.attack)})
        }
        if statId == 6 {
            pokemon.sort (by: { ($0.defense) < ($1.defense)})
        }
        if statId == 7 {
            pokemon.sort (by: { ($0.specialAttack) < ($1.specialAttack)})
        }
        if statId == 8 {
            pokemon.sort (by: { ($0.specialDefense) < ($1.specialDefense)})
        }
        if statId == 9 {
            pokemon.sort (by: { ($0.speed) < ($1.speed)})
        }
        if statId == 10 {
            pokemon.sort (by: { ($0.baseStats) < ($1.baseStats)})
        }

        collection.reloadData()
    }
    
    func sortByDescend(_ statId: Int){
        
        if statId == 0 {
            pokemon.sort (by: {($0.pokedexId) > ($1.pokedexId)})
        }
        if statId == 1 {
            pokemon.sort (by: {($0.name) > ($1.name)})
        }
        if statId == 2 {
            pokemon.sort (by: { ($0.height) > ($1.height)})
        }
        if statId == 3 {
            pokemon.sort (by: { ($0.weight) > ($1.weight)})
        }
        if statId == 4 {
            pokemon.sort (by: { ($0.hp) > ($1.hp)})
        }
        if statId == 5 {
            pokemon.sort (by: { ($0.attack) > ($1.attack)})
        }
        if statId == 6 {
            pokemon.sort (by: { ($0.defense) > ($1.defense)})
        }
        if statId == 7 {
            pokemon.sort (by: { ($0.specialAttack) > ($1.specialAttack)})
        }
        if statId == 8 {
            pokemon.sort (by: { ($0.specialDefense) > ($1.specialDefense)})
        }
        if statId == 9 {
            pokemon.sort (by: { ($0.speed) > ($1.speed)})
        }
        if statId == 10 {
            pokemon.sort (by: { ($0.baseStats) > ($1.baseStats)})
        }
        
        collection.reloadData()
    }
    
    func sortByAscendFiltered(_ statId: Int){
        
        if statId == 0 {
            filteredPokemon.sort (by: {($0.pokedexId) < ($1.pokedexId)})
        }
        if statId == 1 {
            filteredPokemon.sort (by: {($0.name) < ($1.name)})
        }
        if statId == 2 {
            filteredPokemon.sort (by: { ($0.height) < ($1.height)})
        }
        if statId == 3 {
            filteredPokemon.sort (by: { ($0.weight) < ($1.weight)})
        }
        if statId == 4 {
            filteredPokemon.sort (by: { ($0.hp) < ($1.hp)})
        }
        if statId == 5 {
            filteredPokemon.sort (by: { ($0.attack) < ($1.attack)})
        }
        if statId == 6 {
            filteredPokemon.sort (by: { ($0.defense) < ($1.defense)})
        }
        if statId == 7 {
            filteredPokemon.sort (by: { ($0.specialAttack) < ($1.specialAttack)})
        }
        if statId == 8 {
            filteredPokemon.sort (by: { ($0.specialDefense) < ($1.specialDefense)})
        }
        if statId == 9 {
            filteredPokemon.sort (by: { ($0.speed) < ($1.speed)})
        }
        if statId == 10 {
            filteredPokemon.sort (by: { ($0.baseStats) < ($1.baseStats)})
        }
        
        collection.reloadData()
    }
    
    func sortByDescendFiltered(_ statId: Int){
        
        if statId == 0 {
            filteredPokemon.sort (by: {($0.pokedexId) > ($1.pokedexId)})
        }
        if statId == 1 {
            filteredPokemon.sort (by: {($0.name) > ($1.name)})
        }
        if statId == 2 {
            filteredPokemon.sort (by: { ($0.height) > ($1.height)})
        }
        if statId == 3 {
            filteredPokemon.sort (by: { ($0.weight) > ($1.weight)})
        }
        if statId == 4 {
            filteredPokemon.sort (by: { ($0.hp) > ($1.hp)})
        }
        if statId == 5 {
            filteredPokemon.sort (by: { ($0.attack) > ($1.attack)})
        }
        if statId == 6 {
            filteredPokemon.sort (by: { ($0.defense) > ($1.defense)})
        }
        if statId == 7 {
            filteredPokemon.sort (by: { ($0.specialAttack) > ($1.specialAttack)})
        }
        if statId == 8 {
            filteredPokemon.sort (by: { ($0.specialDefense) > ($1.specialDefense)})
        }
        if statId == 9 {
            filteredPokemon.sort (by: { ($0.speed) > ($1.speed)})
        }
        if statId == 10 {
            filteredPokemon.sort (by: { ($0.baseStats) > ($1.baseStats)})
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    func labelSetter(_ reference: Int) {
        statLabel.text = statsList[reference]
    }
    
    func animateTriangle(_ position: CGFloat) {
        UIView.animate(withDuration: 0.15, animations: {
            self.triangleDown.transform = CGAffineTransform(rotationAngle: (position * CGFloat(M_PI)) / 180.0)
        })
    }
    
    @IBAction func descendingAscending(_ sender: UIButton) {
        
        if AscendingSort == true {
            AscendingSort = false
            animateTriangle(180.0)
        } else if AscendingSort == false {
            AscendingSort = true
            animateTriangle(0.0)
        }
        appropriateSort()
    }
    
    func createButtons(_ label: String, tag: Int) -> UIButton {
        let btn = UIButton()
        let dim: CGFloat = 44
        btn.frame = CGRect(x: 0,y: 0,width: dim,height: dim)
        btn.layer.cornerRadius = dim/2
        btn.layer.backgroundColor = UIColor(red: 0.9333, green: 0.0039, blue: 0.3176, alpha: 1.0).cgColor
        btn.setTitle(label, for: UIControl.State())
        btn.tag = tag
        btn.titleLabel!.font = UIFont(name: "Gill Sans", size: 12)
        btn.addTarget(self, action: #selector(ViewController.buttonAction(_:)), for: UIControl.Event.touchUpInside)

        return btn
    }
    
    @objc func buttonAction(_ sender:UIButton!) {
        statId = sender.tag
        labelSetter(statId)
        appropriateSort()
    }
    
    @IBAction func sortBtn(_ sender: UIButton) {
        
        if sortMode == false {
        
            sortBtnView.isHidden = false
            horizontalScrollView.contentSize = CGSize(width: 50 * CGFloat(statsListAbbrev.count) + 40, height: 60)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5,  options: UIView.AnimationOptions(), animations: {
            self.scrollBtnContainerHeight.constant = 60
                self.containerSpacing.constant = 0
                self.view.layoutIfNeeded()
                }, completion: nil)
            
            
            self.sortMode = true
            if !self.sortAnimationRun == true {
                
                for i in 0...statsListAbbrev.count-1 {
                let sortBtn = self.createButtons(statsListAbbrev[i], tag: i)
                sortBtn.frame = CGRect(x: -44, y: 8, width: 44, height: 44)
                self.horizontalScrollView.addSubview(sortBtn)
        
                    UIView.animate(withDuration: 0.8, delay: 0.35, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5,  options: UIView.AnimationOptions(), animations: {
                sortBtn.frame = CGRect(x: 20 + CGFloat(50*i), y: 8, width: 44, height: 44)
                    }, completion: {finished in
                self.sortAnimationRun = true
                    })
                }
            }
        
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5,  options: UIView.AnimationOptions(), animations: {
                self.scrollBtnContainerHeight.constant = 0
                self.containerSpacing.constant = 20
                self.view.layoutIfNeeded()
                }, completion: {finished in
                    self.sortMode = false
            })
        }
    }
    
    @IBAction func ToggleMusicAllowed(_ sender: UIButton) {
        let musicToggle = UserDefaults.standard.bool(forKey: "AreSoundsEnabled")
        if musicToggle == true {
            UserDefaults.standard.set(false, forKey: "AreSoundsEnabled")
        } else {
            UserDefaults.standard.set(true, forKey: "AreSoundsEnabled")
        }
        setMusicButtonImage()
    }
    
    
 }
