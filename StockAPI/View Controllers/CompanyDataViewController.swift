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
     
    
    @IBOutlet weak var companyTickerLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    var companyIndustry: String = ""
    var companyLogo: String = ""
    var companyIpo: String = ""
    var companyMarketCap: Double = 0.0
    var companyName: String = ""
    var companyShareOutstanding: Double = 0.0
    var companyTicker: String = ""
    var companyWeburl : String = ""
    var companyCurrentStockPrice : Double = 0.0
    
    var informationArray: [String] = ["Market Cap", "Shares Outstanding", "IPO Date", "Website"]
    
    override func viewDidLoad() {
        updateUI()
    }
    
    func updateUI(){
        companyNameLabel.text = companyName
        companyTickerLabel.text = companyTicker
    }
}


    

