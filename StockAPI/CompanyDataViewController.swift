//
//  CompanyProfile.swift
//  StockAPI
//
//  Created by Jonathan Tran on 5/31/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation
import UIKit

class CompanyDataViewController : ViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var companyTickerLabel: UILabel!
    
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    var companyIndustry: String = ""
    var companyLogo: String = ""
    var companyIpo: String = ""
    var companyMarketCap: Double = 0.0
    var companyName: String = ""
    var companyShareOutstanding: Double = 0.0
    var companyTicker: String = ""
    var companyWeburl : String = ""
    
    
    override func viewDidLoad() {
        print("view2 did load")
        updateUI()
    }
    
    func updateUI(){
        companyNameLabel.text = companyName
        companyTickerLabel.text = companyTicker
    }
}
