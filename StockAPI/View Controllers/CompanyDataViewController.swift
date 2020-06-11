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
    
    //UI LABELS AND BUTTONS Outlets only
    @IBOutlet var companyDataView: UIView!
    
    @IBOutlet weak var companyTickerLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPriceButton: UIButton!
    @IBOutlet weak var companyNewsButton: UIButton!
    @IBOutlet weak var companyTargetsButton: UIButton!
    @IBOutlet weak var companyFinancialsButton: UIButton!
    @IBOutlet weak var companyPeersLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var medianPriceTargetLabel: UILabel!
    @IBOutlet weak var relatedCompany1Button: UIButton!
    @IBOutlet weak var relatedCompany2Button: UIButton!
    @IBOutlet weak var relatedCompany3Button: UIButton!
    @IBOutlet weak var relatedCompany4Button: UIButton!
    
    
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
        
        companyPriceButton.layer.borderWidth = 10.0
        companyPriceButton.layer.borderColor = greenBorderLine
        
        companyNewsButton.layer.borderWidth = 10.0
        companyNewsButton.layer.borderColor = greenBorderLine
        
        medianPriceTargetLabel.layer.borderWidth = 10.0
        medianPriceTargetLabel.layer.borderColor = greenBorderLine
        companyTargetsButton.layer.borderWidth = 10.0
        companyTargetsButton.layer.borderColor = greenBorderLine
        
        companyFinancialsButton.layer.borderWidth = 10.0
        companyFinancialsButton.layer.borderColor = greenBorderLine
        
        companyPeersLabel.layer.borderWidth = 10.0
        companyPeersLabel.layer.borderColor = greenBorderLine
        relatedCompany1Button.layer.borderWidth = 10.0
        relatedCompany1Button.layer.borderColor = greenBorderLine
        relatedCompany2Button.layer.borderWidth = 10.0
        relatedCompany2Button.layer.borderColor = greenBorderLine
        
        relatedCompany3Button.layer.borderWidth = 10.0
        relatedCompany3Button.layer.borderColor = greenBorderLine
        relatedCompany4Button.layer.borderWidth = 10.0
        relatedCompany4Button.layer.borderColor = greenBorderLine
    }
    
    func updateUIText() {
        let stockPriceAsString = String(format: "%.2f", companyCurrentStockPrice)
        companyNameLabel.text = companyName
        companyTickerLabel.text = companyTicker
        companyTargetsButton.setTitle("$\(companyMedianTargetPrice)", for: .normal)
        fetchLogo(imageLink: companyLogoLink)
        
        if percentChange > 0 {
            companyPriceButton.setTitle("$\(stockPriceAsString)\n\(percentChange)%", for: .normal)
            companyPriceButton.setTitleColor(UIColor.green, for: .normal)
            
        } else {
            companyPriceButton.setTitle("$\(companyCurrentStockPrice)\n\(percentChange)%", for: .normal)
            companyPriceButton.setTitleColor(UIColor.red, for: .normal)
        }
        
        relatedCompany1Button.setTitle(companyPeer1, for: .normal)
        relatedCompany2Button.setTitle(companyPeer2, for: .normal)
        relatedCompany3Button.setTitle(companyPeer3, for: .normal)
        relatedCompany4Button.setTitle(companyPeer4, for: .normal)
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


    

