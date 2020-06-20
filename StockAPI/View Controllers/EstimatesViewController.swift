//
//  EstimatesViewController.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/17/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import UIKit

class EstimatesViewController: SearchViewController {
    
    var targetPriceHigh: Double!
    var targetPriceLow: Double!
    var targetMean: Double!
    var targetLastUpdated: String!
    var targetMedian : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        fetchAnalystRecommendations(completion: { (res) in}, tickerToUse: ticker)
    }

    func fetchAnalystRecommendations(completion: @escaping (Result<RecommendationsModel, Error>) -> (), tickerToUse: String) {
        let urlString = "https://finnhub.io/api/v1/stock/recommendation?symbol=AAPL&token=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data , resp, err) in
            //if there is an error
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server")
            }
            do {
                let analystRecommendations = try JSONDecoder().decode(Array<RecommendationsModel>.self, from: data!)
                let rec = analystRecommendations[0]
                self.fetchEstimates(completion: { (res) in}, tickerToUse: self.ticker)
                print(rec)
            } catch let jsonError{
               completion(.failure(jsonError))
            print("failed to fetch JSON", jsonError)
            }
        }.resume()
    }
    
        func fetchEstimates(completion: @escaping (Result<CompanyTarget, Error>) -> (), tickerToUse : String) {
        
        
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
                self.targetMedian = companyTargetInfo.targetMedian
                self.targetPriceHigh = companyTargetInfo.targetHigh
                self.targetPriceLow = companyTargetInfo.targetLow
                self.targetMean = companyTargetInfo.targetMean
                self.targetLastUpdated = companyTargetInfo.lastUpdated
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
            
        }.resume()
        
    }

}
