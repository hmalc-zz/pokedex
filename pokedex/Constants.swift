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
        
    return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

}

func assignColoursToGame (gameReferenceId: Int) -> UIColor {
    
    //var gameVersionArray: [String] = ["Red","Blue","Yellow","Gold","Silver","Crystal","Ruby","Sapphire","Emerald","FireRed","LeafGreen","Diamond","Pearl","Platinum","HeartGold","SoulSilver","Black","White","Colosseum","XD","Black 2","White 2","X","Y","Omega Ruby","Alpha Sapphire"]

    var gameColorSpecs: [UIColor] = [
        UIColor(red: 1, green: 0.0667, blue: 0.0667, alpha: 1.0),
        UIColor(red: 0.0667, green: 0.0667, blue: 1, alpha: 1.0),
        UIColor(red: 1, green: 0.8431, blue: 0.2, alpha: 1.0),
        UIColor(red: 0.8549, green: 0.6471, blue: 0.1255, alpha: 1.0),
        UIColor(red: 0.7529, green: 0.7529, blue: 0.7529, alpha: 1.0),
        UIColor(red: 0.3098, green: 0.851, blue: 1, alpha: 1.0),
        UIColor(red: 0.6275, green: 0, blue: 0, alpha: 1.0), /* Ruby #a00000 */
        UIColor(red: 0, green: 0, blue: 0.6275, alpha: 1.0), /* Sapphire #0000a0 */
        UIColor(red: 0, green: 0.6275, blue: 0, alpha: 1.0), /* Emerald #00a000 */
        UIColor(red: 1, green: 0.451, blue: 0.1529, alpha: 1.0), /* FireRed #ff7327 */
        UIColor(red: 0, green: 0.8667, blue: 0, alpha: 1.0), /* LeafGreen #00dd00 */
        UIColor(red: 0.6667, green: 0.6667, blue: 1, alpha: 1.0), /* Diamond #aaaaff */
        UIColor(red: 1, green: 0.6667, blue: 0.6667, alpha: 1.0), /* Pearl #ffaaaa */
        UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0), /* Platinum #999999 */
        UIColor(red: 0.7137, green: 0.6196, blue: 0, alpha: 1.0), /* Heart Gold #b69e00 */
        UIColor(red: 0.7529, green: 0.7529, blue: 0.8824, alpha: 1.0), /* Soul Silver #c0c0e1 */
        UIColor(red: 0.2667, green: 0.2667, blue: 0.2667, alpha: 1.0), /* Black #444444 */
        UIColor(red: 0.8824, green: 0.8824, blue: 0.8824, alpha: 1.0), /* White #e1e1e1 */
        UIColor(red: 0.7137, green: 0.7922, blue: 0.8941, alpha: 1.0), /* Colloseum #b6cae4 */
        UIColor(red: 0.3765, green: 0.3059, blue: 0.5098, alpha: 1.0), /* XD: Gale of Darkness #604e82 */
        UIColor(red: 0.2667, green: 0.2667, blue: 0.2667, alpha: 1.0), /* Black 2 #444444 */
        UIColor(red: 0.8824, green: 0.8824, blue: 0.8824, alpha: 1.0), /* White 2 #e1e1e1 */
        UIColor(red: 0.3882, green: 0.4627, blue: 0.7216, alpha: 1.0), /* X #6376b8 */
        UIColor(red: 0.9294, green: 0.3333, blue: 0.251, alpha: 1.0), /* Y #ed5540 */
        UIColor(red: 0.8118, green: 0.1882, blue: 0.1451, alpha: 1.0), /* Omega Ruby #cf3025 */
        UIColor(red: 0.0902, green: 0.4078, blue: 0.8196, alpha: 1.0) /* Alpha Sapphire #1768d1 */
    ]
    
    if gameReferenceId >= 1 && gameReferenceId <= 26 {
        return gameColorSpecs[gameReferenceId-1]
    }
    
    return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}
