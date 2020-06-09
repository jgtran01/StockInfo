//
//  CompanyProfile.swift
//  StockAPI
//
//  Created by Jonathan Tran on 5/31/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation
import UIKit

class CompanyDataViewController : UIViewController {
     
    @IBOutlet var companyDataView: UIView!
    
    @IBOutlet weak var companyTickerLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyStockPriceLabel: UILabel!
    @IBOutlet weak var companyNewsLabel: UILabel!
    @IBOutlet weak var companyTargetsLabel: UILabel!
    @IBOutlet weak var companyFinancialsLabel: UILabel!
    @IBOutlet weak var tbdLabel: UILabel!
    @IBOutlet weak var companyPeersLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var relatedCompany1Label: UILabel!
    @IBOutlet weak var relatedCompany2Label: UILabel!
    @IBOutlet weak var relatedCompany3Label: UILabel!
    @IBOutlet weak var relatedCompany4Label: UILabel!
    
    
    
    
    
    var companyIndustry: String = ""
    var companyLogo: String = ""
    var companyIpo: String = ""
    var companyMarketCap: Double = 0.0
    var companyName: String = "Test"
    var companyShareOutstanding: Double = 0.0
    var companyTicker: String = ""
    var companyWeburl : String = ""
    var companyCurrentStockPrice : Double = 0.0
    var companyMedianTargetPrice : Double = 0.0
    var companyLogoLink : String = ""
    var percentChange : Double = 0.0
    var companyPeer1 : String = ""
    var companyPeer2: String = ""
    var companyPeer3 : String = ""
    var companyPeer4 : String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        
        companyNameLabel.text = companyName
        companyTickerLabel.text = companyTicker
        companyStockPriceLabel.text = "$\(companyCurrentStockPrice)"
        companyTargetsLabel.text = "$\(companyMedianTargetPrice)"
        fetchLogo(imageLink: companyLogoLink)
        
        if percentChange > 0 {
        percentChangeLabel.text = "+\(percentChange)%"
            percentChangeLabel.textColor = UIColor.green
        } else {
            percentChangeLabel.text = "\(percentChange)%"
            percentChangeLabel.textColor = UIColor.red
        }
        relatedCompany1Label.text = companyPeer1
        relatedCompany2Label.text = companyPeer2
        relatedCompany3Label.text = companyPeer3
        relatedCompany4Label.text = companyPeer4
        
        
        companyNameLabel.layer.borderWidth = 3.0
        companyTickerLabel.layer.borderWidth = 3.0
        companyStockPriceLabel.layer.borderWidth = 3.0
        companyNewsLabel.layer.borderWidth = 3.0
        companyTargetsLabel.layer.borderWidth = 3.0
        companyFinancialsLabel.layer.borderWidth = 3.0
        tbdLabel.layer.borderWidth = 3.0
        companyPeersLabel.layer.borderWidth = 3.0
    }
    
    func fetchLogo(imageLink : String) {
        if let url = URL(string: imageLink) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.logoImageView.image = UIImage(data: data)
                    }
                }
            })
            task.resume()
        }
    }

    
}


    

