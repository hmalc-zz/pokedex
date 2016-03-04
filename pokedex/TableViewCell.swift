//
//  TableViewCell.swift
//  pokedex
//
//  Created by Hayden Malcomson on 2016-02-24.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var LevelLbl: UILabel!
    @IBOutlet weak var moveName: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    
    var pokemon: Pokemon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureMoves(moveTitle: String,Level: Int,typeName: String, powerLevel: String, accuracyLevel: String) {
        
        moveName.text = moveTitle
        LevelLbl.text = "\(Level)"
        typeLabel.text = typeName.capitalizedString
        typeLabel.layer.backgroundColor = assignColorToType(typeName.capitalizedString, alpha: 1).CGColor
        powerLabel.text = powerLevel
        if accuracyLevel != "-" {
            accuracyLabel.text = "\(accuracyLevel)%"
        } else {
            accuracyLabel.text = "\(accuracyLevel)"
        }
        
        
    }

}
