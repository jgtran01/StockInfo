//
//  ViewController.swift
//  StockAPI
//
//  Created by Jonathan Tran on 5/31/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterTickerHereLabel: UILabel!
    @IBOutlet weak var tickerTextField: UITextField!
    
    let apiKey = "briigsnrh5rf00gkdpm0"
    
    //Company Basic Profile Variables
    var industry: String = ""
    var logo: String = ""
    var ipo: String = ""
    var marketCap: Double = 0.0
    var name: String = ""
    var shareOutstanding: Double = 0.0
    var ticker: String!
    var weburl : String = ""
    var logoLink : String = ""
    
    //Company Stock Variables
    var currentStockPrice : Double = 0.0
    var medianTargetPrice : Double = 0.0
    var previousClosePrice : Double = 0.0
    var roundedPercentChange : Double = 0.0
    
    //Related Companies Button
    var relatedCompany1 : String = ""
    var relatedCompany2 : String = ""
    var relatedCompany3 : String = ""
    var relatedCompany4 : String = ""
    
//    var weekHigh52 : String = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    @IBAction func searchButton(_ sender: Any)  {
        
        fetchData(ticker: tickerTextField.text!)
        }
 
    func fetchData(ticker: String) {
        
        fetchCompanyProfileInformation(completion: { (res) in
        }, tickerToUse: ticker)
        fetchCompanyStockInformation(completion: { (res) in
        }, tickerToUse: ticker)
        fetchCompanyTargetInformation(completion: { (res) in
        }, tickerToUse: ticker)
//        fetchCompanyFinancials { (res) in
//        }
    }


    
    
    
//MARK: - Fetch JSON Functions
    func fetchCompanyProfileInformation(completion: @escaping (Result<CompanyProfileModel, Error>) -> (), tickerToUse: String) {
        
//        let ticker = tickerTextField.text!.uppercased()
        
        // Fetches Company Profile Information
        let urlString = "https://finnhub.io/api/v1/stock/profile2?symbol=\(tickerToUse)&token=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        
        URLSession.shared.dataTask(with: url) { (data , resp, err) in
            //if there is an error
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server")
            }
            do {
                let companyInfo = try JSONDecoder().decode(CompanyProfileModel.self, from: data!)
                completion(.success(companyInfo))
                self.name = companyInfo.name
                self.industry = companyInfo.finnhubIndustry
                self.logo = companyInfo.logo
                self.ipo = companyInfo.ipo
                self.marketCap = companyInfo.marketCapitalization
                self.shareOutstanding = companyInfo.shareOutstanding
                self.ticker = companyInfo.ticker
                self.weburl = companyInfo.weburl
                self.logoLink = companyInfo.logo
            } catch let jsonError{
               completion(.failure(jsonError))
            print("failed to fetch JSON", jsonError)
            }
        }.resume()
    }
    
    func fetchCompanyStockInformation(completion: @escaping (Result<CompanyStockPrice, Error>) -> (), tickerToUse : String) {
//        let ticker = tickerTextField.text!.uppercased()
        
        //Fetches Company Stock Information
        let urlString = "https://finnhub.io/api/v1/quote?symbol=\(tickerToUse)&token=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server for API")
            }
            do {
                let companyStockInfo = try JSONDecoder().decode(CompanyStockPrice.self, from: data!)
                completion(.success(companyStockInfo))
                self.currentStockPrice = companyStockInfo.c
                let percentChangeFromPreviousCloseAsDecimal = ((self.currentStockPrice/companyStockInfo.pc)-1)
                self.roundedPercentChange = self.reformatPercentChangeToPercentage(decimalValue: percentChangeFromPreviousCloseAsDecimal)
                self.fetchRelatedCompanies(completion: { (res) in
                }, tickerToUse: tickerToUse)
                
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
            
        }.resume()
        
    }

    func fetchCompanyTargetInformation(completion: @escaping (Result<CompanyTarget, Error>) -> (), tickerToUse : String) {
        
//        let ticker = tickerTextField.text!.uppercased()
        
        //Fetches Company Stock Information
        let urlString = "https://finnhub.io/api/v1/stock/price-target?symbol=\(tickerToUse)&token=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server for API")
            }
            do {
                let companyTargetInfo = try JSONDecoder().decode(CompanyTarget.self, from: data!)
                self.medianTargetPrice = companyTargetInfo.targetMedian
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
            
        }.resume()
        
    }
    
    func reformatPercentChangeToPercentage(decimalValue : Double) -> Double{
        
        let percentChange = decimalValue * 100
        let roundedPercentChange = Double(round(100 * percentChange) / 100)
        return roundedPercentChange
    }
    
    func fetchRelatedCompanies(completion: @escaping (Result<RelatedCompanies, Error>) -> (), tickerToUse : String) {
            
        
        //Fetches Company Stock Information
        let urlString = "https://finnhub.io/api/v1/stock/peers?symbol=\(tickerToUse)&token=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server for API")
            }
            do {
                let relatedCompanies = try JSONDecoder().decode([String].self, from: data!)
                self.relatedCompany1 = relatedCompanies[0]
                self.relatedCompany2 = relatedCompanies[1]
                self.relatedCompany3 = relatedCompanies[2]
                self.relatedCompany4 = relatedCompanies[3]
                DispatchQueue.main.async {
                             self.performSegue(withIdentifier: "goToCompanyDataVC", sender: self)
                 }
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
            
        }.resume()
    }
    
//    func fetchCompanyFinancials(completion: @escaping (Result<CompanyFinancials, Error>) -> ()) {
//        
//        let ticker = tickerTextField.text!.uppercased()
//        
//        //Fetches Company Stock Information
//        let urlString = "https://finnhub.io/api/v1/stock/metric?symbol=\(ticker)&metric=all&token=\(apiKey)"
//        guard let url = URL(string: urlString) else {return}
//        
//        URLSession.shared.dataTask(with: url) { (data, resp, err) in
//            if let err = err {
//                completion(.failure(err))
//                print("failed to connect to web server for API")
//            }
//            do {
//                let companyFinancials = try JSONDecoder().decode(CompanyFinancials.self, from: data!)
//            } catch let jsonError {
//                completion(.failure(jsonError))
//                print("failed to fetch JSON for Company Financials", jsonError)
//            }
//            
//        }.resume()
//    }
//    
    
    
//MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCompanyDataVC" {
            let destinationVC = segue.destination as! CompanyDataViewController
            destinationVC.companyTicker = ticker
            destinationVC.companyName = name
            destinationVC.companyIndustry = industry
            destinationVC.companyLogo = logo
            destinationVC.companyIpo = ipo
            destinationVC.companyShareOutstanding = shareOutstanding
            destinationVC.companyWeburl = weburl
            destinationVC.companyCurrentStockPrice = currentStockPrice
            destinationVC.companyMedianTargetPrice = medianTargetPrice
            destinationVC.companyLogoLink = logoLink
            destinationVC.percentChange = roundedPercentChange
            destinationVC.companyPeer1 = relatedCompany1
            destinationVC.companyPeer2 = relatedCompany2
            destinationVC.companyPeer3 = relatedCompany3
            destinationVC.companyPeer4 = relatedCompany4
        }
    }

        
}
