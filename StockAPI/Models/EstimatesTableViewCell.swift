//
//  EstimatesTableViewCell.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/21/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import UIKit

class EstimatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var column1Label: UILabel!
    
    @IBOutlet weak var column2Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
