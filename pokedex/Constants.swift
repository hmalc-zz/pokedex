//
//  Constants.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-04.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import Foundation
import UIKit

 let URL_BASE = "http://pokeapi.co/"
 let URL_POKEMON = "/api/v1/pokemon/"

typealias DownloadCompe = () -> ()

// MARK: Type Colors

func assignColorToType(type: String) -> UIColor {
 
    var colorTypes: [String:UIColor] = [
        
     "Normal":UIColor(red: 0.6588, green: 0.6549, blue: 0.4784, alpha: 1.0),
     "Fighting" : UIColor(red: 0.7608, green: 0.1804, blue: 0.1569, alpha: 1.0),
     "Flying" : UIColor(red: 0.6627, green: 0.5608, blue: 0.9529, alpha: 1.0),
     "Poison" : UIColor(red: 0.6392, green: 0.2431, blue: 0.6314, alpha: 1.0),
     "Ground" : UIColor(red: 0.8863, green: 0.749, blue: 0.3961, alpha: 1.0),
     "Rock" : UIColor(red: 0.7137, green: 0.6314, blue: 0.2118, alpha: 1.0),
     "Bug" : UIColor(red: 0.651, green: 0.7255, blue: 0.102, alpha: 1.0),
     "Ghost" : UIColor(red: 0.451, green: 0.3412, blue: 0.5922, alpha: 1.0),
     "Steel" : UIColor(red: 0.7176, green: 0.7176, blue: 0.8078, alpha: 1.0),
     "Fire" : UIColor(red: 0.9333, green: 0.5059, blue: 0.1882, alpha: 1.0),
     "Water" : UIColor(red: 0.3882, green: 0.5647, blue: 0.9412, alpha: 1.0),
     "Grass" : UIColor(red: 0.4784, green: 0.7804, blue: 0.298, alpha: 1.0),
     "Electric" : UIColor(red: 0.9686, green: 0.8157, blue: 0.1725, alpha: 1.0),
     "Psychic" : UIColor(red: 0.9765, green: 0.3333, blue: 0.5294, alpha: 1.0),
     "Ice" : UIColor(red: 0.5882, green: 0.851, blue: 0.8392, alpha: 1.0),
     "Dragon" : UIColor(red: 0.4353, green: 0.2078, blue: 0.9882, alpha: 1.0),
     "Dark" : UIColor(red: 0.4392, green: 0.3412, blue: 0.2745, alpha: 1.0),
     "Fairy" : UIColor(red: 0.8392, green: 0.5216, blue: 0.6784, alpha: 1.0)]
    
    "Normal":UIColor(red: 0.6588, green: 0.6549, blue: 0.4784, alpha: 1.0)
    
    for keys in colorTypes {
        if type == colorTypes[keys] {
            return colorTypes[
        } else {
            return UIColor(red: 0., green: 0., blue: 0., alpha: 1.0)
        }
    }

}