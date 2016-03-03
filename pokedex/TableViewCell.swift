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
    //@IBOutlet weak var specialPhysical: UILabel!
    //@IBOutlet weak var PPlbl: UILabel!
    //@IBOutlet weak var PowerLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureMoves(moveTitle: String, atLevel: Int) {
        
        moveName.text = moveTitle
        LevelLbl.text = "\(atLevel)"
        
    }

}
