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
    
    let apiKey = "bra4vjfrh5r8evkvd7lg"
    var industry: String = ""
    var logo: String = ""
    var ipo: String = ""
    var marketCap: Double = 0.0
    var name: String = ""
    var shareOutstanding: Double = 0.0
    var ticker: String = ""
    var weburl : String = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func searchButton(_ sender: Any)  {
        //performSegue(withIdentifier: "toCompanyProfile", sender: self)

        fetchCompanyInformation { (res) in}
        
        performSegue(withIdentifier: "goToCompanyDataVC", sender: self)
    }



    func fetchCompanyInformation(completion: @escaping (Result<CompanyProfileModel, Error>) -> ()) {
        
        let ticker = tickerTextField.text!
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
                print(self.name)
                print(self.industry)
                print(self.marketCap)
                print(self.shareOutstanding)
                print(self.ipo)
            } catch let jsonError{
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
        }
    }

        
}
