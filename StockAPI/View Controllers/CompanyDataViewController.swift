//
//  CompanyProfile.swift
//  StockAPI
//
//  Created by Jonathan Tran on 5/31/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

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
//    @IBOutlet weak var medianPriceTargetLabel: UILabel!
    @IBOutlet weak var relatedCompany1Button: UIButton!
    @IBOutlet weak var relatedCompany2Button: UIButton!
    @IBOutlet weak var relatedCompany3Button: UIButton!
    @IBOutlet weak var relatedCompany4Button: UIButton!
    @IBOutlet weak var indicesButton: UIButton!
    
    
    //COLORS
    var darkBorderLine = CGColor.init(srgbRed: 100/255, green: 50/255, blue: 50/255, alpha: 1)
    var greenBorderLine = CGColor.init(srgbRed: 100/255, green: 230/255, blue: 100/255, alpha: 1)
    
    //VARIABLES
    var companyIndustry: String = ""
    var companyLogo: String = ""
    var companyIpo: String = ""
    var companyMarketCap: Double = 0.0
    var companyName: String!
    var companyShareOutstanding: Double = 0.0
    var companyTicker: String!
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
    
    //BUTTONS
    @IBAction func estimateButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEstimatesVC", sender: self)
    }
    
    
    @IBAction func newsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCompanyNewsVC", sender: self)
    }
    
    @IBAction func relatedCompany1ButtonPressed(_ sender: Any) {
        companyTicker = relatedCompany1Button.currentTitle
        performSegue(withIdentifier: "toSearchVC", sender: self)
    }
    
    @IBAction func relatedCompany2ButtonPressed(_ sender: Any) {
        companyTicker = relatedCompany2Button.currentTitle
         performSegue(withIdentifier: "toSearchVC", sender: self)
    }
    
    @IBAction func relatedCompany3ButtonPressed(_ sender: Any) {
        companyTicker = relatedCompany3Button.currentTitle
         performSegue(withIdentifier: "toSearchVC", sender: self)
    }
    
    @IBAction func relatedCompany4ButtonPressed(_ sender: Any) {
        companyTicker = relatedCompany4Button.currentTitle
         performSegue(withIdentifier: "toSearchVC", sender: self)
    }
    
    
    //MARK: - UPDATES UI LAYOUT AND TEXT
    func updateUI(){
        updateUILayout()
        updateUIText()
    }
    
    func updateUILayout() {
        
        
        companyNewsButton.layer.borderWidth = 5.0
        companyNewsButton.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)

        
        companyPriceButton.layer.borderWidth = 5.0
        companyPriceButton.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        
        
        companyTargetsButton.layer.borderWidth = 5.0
        companyTargetsButton.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        
        
        companyPeersLabel.layer.borderWidth = 5
        companyPeersLabel.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        
        companyFinancialsButton.layer.borderWidth = 5
        companyFinancialsButton.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        
        relatedCompany1Button.layer.borderWidth = 5
        relatedCompany1Button.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        relatedCompany2Button.layer.borderWidth = 5
        relatedCompany2Button.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        
        relatedCompany3Button.layer.borderWidth = 5
        relatedCompany3Button.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        relatedCompany4Button.layer.borderWidth = 5
        relatedCompany4Button.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
        
        indicesButton.layer.borderWidth = 5.0
        indicesButton.layer.borderColor = #colorLiteral(red: 0.2766755619, green: 0.8209470178, blue: 0.6074805909, alpha: 1)
    }
    
    func updateUIText() {
        let stockPriceAsString = String(format: "%.2f", companyCurrentStockPrice)
        companyNameLabel.text = companyName
        companyTickerLabel.text = companyTicker
        companyTargetsButton.setTitle("Median Price Target: \n$\(String(format: "%.2f", companyMedianTargetPrice))", for: .normal)
        fetchLogo(imageLink: companyLogoLink)
        
        if percentChange > 0 {
            companyPriceButton.setTitle("$\(stockPriceAsString)\n+\(percentChange)%", for: .normal)
            companyPriceButton.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
            
        } else {
            companyPriceButton.setTitle("$\(stockPriceAsString)\n\(percentChange)%", for: .normal)
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
    
    
    //MARK: - PREPARE FOR SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCompanyNewsVC" {
            let destinationVC = segue.destination as! CompanyNewsViewController
            destinationVC.companyTicker1 = companyTicker
            destinationVC.companyLogo = logoImageView.image
        }
        
        if segue.identifier == "toSearchVC"{
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.fetchData(ticker: companyTicker)
        }
        
        if segue.identifier == "toEstimatesVC"{
            let destinationVC = segue.destination as! EstimatesViewController
            destinationVC.ticker = companyTicker
            destinationVC.currentPrice = companyCurrentStockPrice
        }
    }
    
    
}


    

