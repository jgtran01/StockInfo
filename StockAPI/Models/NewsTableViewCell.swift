//
//  NewsTableViewCell.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/14/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
