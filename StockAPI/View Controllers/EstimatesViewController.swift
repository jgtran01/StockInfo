//
//  EstimatesViewController.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/17/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import UIKit
import Charts

class EstimatesViewController: SearchViewController {
    
    @IBOutlet weak var recommendationBarChart: BarChartView!
    @IBOutlet weak var estimatesTableView: UITableView!
    @IBOutlet weak var lastupdatedLabel: UILabel!
    
    var targetPriceHigh: Double!
    var highDifference: Double!
    var targetPriceLow: Double!
    var lowDifference: Double!
    var targetMean: Double!
    var averageDifference: Double!
    var targetLastUpdated: String!
    var targetMedian : Double!
    var medianDifference : Double!
    var currentPrice: Double!
    
    
    //Chart Variables
    var strongBuy = BarChartDataEntry(x: 1, y: 0)
    var buy = BarChartDataEntry(x: 2, y: 0)
    var hold = BarChartDataEntry(x: 3, y: 0)
    var sell = BarChartDataEntry(x: 4, y: 0)
    var strongSell = BarChartDataEntry(x: 5, y: 0)
    
    var numberofRecommendations = [BarChartDataEntry]()
    var column1LabelsArray = ["Current Price", "Median Target Price", "Average Target Price", "High Target Price", "Low Taget Price"]
    var estimatedNumbersArray : [String] = ["","","","",""]
    
    //colors
    
    var lightGreen = UIColor.init(displayP3Red: 0/255, green: 240/255, blue: 0/255, alpha: 1.0)
    var darkGreen = UIColor.init(displayP3Red: 0/255, green: 150/255, blue: 10/255, alpha: 1.0)
    var darkRed = UIColor.init(displayP3Red: 200/255, green: 10/255, blue: 10/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
       // super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        fetchAnalystRecommendations(completion: { (res) in}, tickerToUse: ticker)
    }

    func fetchAnalystRecommendations(completion: @escaping (Result<RecommendationsModel, Error>) -> (), tickerToUse: String) {
        let urlString = "https://finnhub.io/api/v1/stock/recommendation?symbol=\(ticker!)&token=\(apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data , resp, err) in
            //if there is an error
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server")
            }
            do {
                let analystRecommendations = try JSONDecoder().decode(Array<RecommendationsModel>.self, from: data!)
                let recommendation = analystRecommendations[0]
                self.strongBuy = BarChartDataEntry(x: 1, y: Double(recommendation.strongBuy))
                self.buy = BarChartDataEntry(x: 2, y: Double(recommendation.buy))
                self.hold = BarChartDataEntry(x: 3, y: Double(recommendation.hold))
                self.sell = BarChartDataEntry(x: 4, y: Double(recommendation.sell))
                self.strongSell = BarChartDataEntry(x: 5, y: Double(recommendation.strongSell))
                self.numberofRecommendations = [self.strongBuy, self.buy, self.hold, self.sell, self.strongSell]
                DispatchQueue.main.async {
                    self.updateChart()
                }
                self.fetchEstimates(completion: { (res) in}, tickerToUse: self.ticker)
                print(recommendation)
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
                self.estimatedNumbersArray.insert((String(format: "%.2f", self.currentPrice)), at: 0)
                self.estimatedNumbersArray.insert((String(format: "%.2f", self.targetMedian)), at: 1)
                self.estimatedNumbersArray.insert((String(format: "%.2f", self.targetMean)), at: 2)
                self.estimatedNumbersArray.insert((String(format: "%.2f", self.targetPriceHigh)), at: 3)
                self.estimatedNumbersArray.insert((String(format: "%.2f", self.targetPriceLow)), at: 4)
                print(self.estimatedNumbersArray)
                DispatchQueue.main.async {
                    self.estimatesTableView.reloadData()
                    self.lastupdatedLabel.text = "Last Updated: \(self.targetLastUpdated!)"
                }
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
            
        }.resume()
        
    }
    
    func calcDifference() {
        
    }
    
    func updateChart() {
        let chartDataSet = BarChartDataSet(entries: numberofRecommendations, label: nil)
        let chartData = BarChartData(dataSet: chartDataSet)
        
        let colors = [darkGreen, lightGreen ,UIColor.yellow, UIColor.red, darkRed]
        chartDataSet.colors = colors
        
        recommendationBarChart.data = chartData
        recommendationBarChart.xAxis.drawGridLinesEnabled = false
        recommendationBarChart.xAxis.drawAxisLineEnabled = false
    
        let xAxis = ["", "Strong Buy", "Buy", "Hold", "Sell", "Strong Sell"]
        recommendationBarChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxis)
        recommendationBarChart.xAxis.granularity = 1
    }

}

extension EstimatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return column1LabelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = estimatesTableView.dequeueReusableCell(withIdentifier: "estimatesReusableCell") as! EstimatesTableViewCell
        
        cell.column1Label.text = column1LabelsArray[indexPath.row]
        cell.column2Label.text = "$\(String(estimatedNumbersArray[indexPath.row]))"
        return cell
    }
}

extension EstimatesViewController{
    override func viewWillLayoutSubviews() {}
}
