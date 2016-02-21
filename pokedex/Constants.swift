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


func assignColorToType(type: String, alpha: CGFloat) -> UIColor {
    
    var colorList: [String] = ["Normal","Fighting","Flying","Poison","Ground","Rock","Bug","Ghost","Steel","Fire","Water","Grass","Electric","Psychic","Ice","Dragon","Dark","Fairy"]
    
    var colorSpecs: [UIColor] = [
        UIColor(red: 0.6588, green: 0.6549, blue: 0.4784, alpha: alpha),
        UIColor(red: 0.7608, green: 0.1804, blue: 0.1569, alpha: alpha),
        UIColor(red: 0.6627, green: 0.5608, blue: 0.9529, alpha: alpha),
        UIColor(red: 0.6392, green: 0.2431, blue: 0.6314, alpha: alpha),
        UIColor(red: 0.8863, green: 0.749, blue: 0.3961, alpha: alpha),
        UIColor(red: 0.7137, green: 0.6314, blue: 0.2118, alpha: alpha),
        UIColor(red: 0.651, green: 0.7255, blue: 0.102, alpha: alpha),
        UIColor(red: 0.451, green: 0.3412, blue: 0.5922, alpha: alpha),
        UIColor(red: 0.7176, green: 0.7176, blue: 0.8078, alpha: alpha),
        UIColor(red: 0.9333, green: 0.5059, blue: 0.1882, alpha: alpha),
        UIColor(red: 0.3882, green: 0.5647, blue: 0.9412, alpha: alpha),
        UIColor(red: 0.4784, green: 0.7804, blue: 0.298, alpha: alpha),
        UIColor(red: 0.9686, green: 0.8157, blue: 0.1725, alpha: alpha),
        UIColor(red: 0.9765, green: 0.3333, blue: 0.5294, alpha: alpha),
        UIColor(red: 0.5882, green: 0.851, blue: 0.8392, alpha: alpha),
        UIColor(red: 0.4353, green: 0.2078, blue: 0.9882, alpha: alpha),
        UIColor(red: 0.4392, green: 0.3412, blue: 0.2745, alpha: alpha),
        UIColor(red: 0.8392, green: 0.5216, blue: 0.6784, alpha: alpha)
    ]
    
    for var i = 0; i < colorList.count; i++ {
        
        if colorList[i] == type {
            return colorSpecs[i]
        }
    }
        
    return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)

}