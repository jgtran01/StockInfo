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
    
    let apiKey = "brdg5pnrh5rf712pc860"
    var industry: String = ""
    var logo: String = ""
    var ipo: String = ""
    var marketCap: Double = 0.0
    var name: String = ""
    var shareOutstanding: Double = 0.0
    var ticker: String = ""
    var weburl : String = ""
    var currentStockPrice : Double = 0.0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true

    }

    @IBAction func searchButton(_ sender: Any)  {

        fetchCompanyProfileInformation { (res) in
            print(self.name)
            print(self.ticker)
        }
        fetchCompanyStockInformation { (res) in
            print(self.currentStockPrice)
        }
        performSegue(withIdentifier: "goToCompanyDataVC", sender: self)
    }



    func fetchCompanyProfileInformation(completion: @escaping (Result<CompanyProfileModel, Error>) -> ()) {
        
        let ticker = tickerTextField.text!.uppercased()
        
        // Fetches Company Profile Information
        let urlString = "https://finnhub.io/api/v1/stock/profile2?symbol=\(ticker)&token=\(apiKey)"
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
            } catch let jsonError{
               completion(.failure(jsonError))
            print("failed to fetch JSON", jsonError)
            }
        }.resume()
    }
    
    func fetchCompanyStockInformation(completion: @escaping (Result<CompanyStockPrice, Error>) -> ()) {
        let ticker = tickerTextField.text!.uppercased()
        
        //Fetches Company Stock Information
        let urlString = "https://finnhub.io/api/v1/quote?symbol=\(ticker)&token=\(apiKey)"
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
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
            
        }.resume()
        
    }
    
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
        }
    }

        
}
