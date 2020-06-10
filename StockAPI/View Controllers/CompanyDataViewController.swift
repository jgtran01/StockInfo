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
     
    //UI LABELS
    @IBOutlet weak var companyTickerStackView: UIStackView!
    @IBOutlet var companyDataView: UIView!
    @IBOutlet weak var companyTickerLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyStockPriceLabel: UILabel!
    @IBOutlet weak var companyNewsLabel: UILabel!
    @IBOutlet weak var companyTargetsLabel: UILabel!
    @IBOutlet weak var companyFinancialsLabel: UILabel!

    @IBOutlet weak var companyPeersLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var medianPriceTargetLabel: UILabel!
    
    @IBOutlet weak var relatedCompany1Label: UILabel!
    @IBOutlet weak var relatedCompany2Label: UILabel!
    @IBOutlet weak var relatedCompany3Label: UILabel!
    @IBOutlet weak var relatedCompany4Label: UILabel!
    
    //COLORS
    var darkBorderLine = CGColor.init(srgbRed: 100/255, green: 50/255, blue: 50/255, alpha: 1)
    var greenBorderLine = CGColor.init(srgbRed: 100/255, green: 230/255, blue: 100/255, alpha: 1)
    
    //VARIABLES
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        
        updateUILayout()
        updateUIText()
    }
    
    func updateUILayout() {
        
        companyNameLabel.layer.borderWidth = 10.0
        companyNameLabel.layer.borderColor = greenBorderLine
        
        companyTickerLabel.layer.borderWidth = 10.0
        companyTickerLabel.layer.borderColor = greenBorderLine
        
        logoImageView.layer.borderWidth = 10.0
        logoImageView.layer.backgroundColor = greenBorderLine
        logoImageView.layer.borderColor = greenBorderLine
        
        companyStockPriceLabel.layer.borderWidth = 10.0
        companyStockPriceLabel.layer.borderColor = greenBorderLine
        
        companyNewsLabel.layer.borderWidth = 10.0
        companyNewsLabel.layer.borderColor = greenBorderLine
        
        medianPriceTargetLabel.layer.borderWidth = 10.0
        medianPriceTargetLabel.layer.borderColor = greenBorderLine
        companyTargetsLabel.layer.borderWidth = 10.0
        companyTargetsLabel.layer.borderColor = greenBorderLine
        
        companyFinancialsLabel.layer.borderWidth = 10.0
        companyFinancialsLabel.layer.borderColor = greenBorderLine
        

        
        companyPeersLabel.layer.borderWidth = 10.0
        companyPeersLabel.layer.borderColor = greenBorderLine
        relatedCompany1Label.layer.borderWidth = 1.0
        relatedCompany1Label.layer.borderColor = darkBorderLine
        relatedCompany2Label.layer.borderWidth = 1.0
        relatedCompany2Label.layer.borderColor = darkBorderLine
        relatedCompany3Label.layer.borderWidth = 1.0
        relatedCompany3Label.layer.borderColor = darkBorderLine
        relatedCompany4Label.layer.borderWidth = 1.0
        relatedCompany4Label.layer.borderColor = darkBorderLine
    }
    
    func updateUIText() {
        companyNameLabel.text = companyName
        companyTickerLabel.text = companyTicker
        companyTargetsLabel.text = "$\(companyMedianTargetPrice)"
        fetchLogo(imageLink: companyLogoLink)
        
        if percentChange > 0 {
            companyStockPriceLabel.text = "$\(companyCurrentStockPrice)\n\(percentChange)%"
            companyStockPriceLabel.textColor = UIColor.green
        } else {
            companyStockPriceLabel.text = "$\(companyCurrentStockPrice)\n\(percentChange)%"
            companyStockPriceLabel.textColor = UIColor.red
        }
        relatedCompany1Label.text = companyPeer1
        relatedCompany2Label.text = companyPeer2
        relatedCompany3Label.text = companyPeer3
        relatedCompany4Label.text = companyPeer4
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


    

