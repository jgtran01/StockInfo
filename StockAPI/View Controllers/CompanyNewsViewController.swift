//
//  CompanyNewsViewController.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/11/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation
import UIKit

class CompanyNewsViewController: ViewController {
    
    var newsFeed : [News] = []
    var headLinesArray : [String] = []
    var companyTicker1 : String = ""
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if companyTicker1 != ""{
            fetchCompanyNews { (res) in
            }
        } else {
            print("ticker is empty")
            newsTableView.reloadData()
        }
    }
    
    func fetchCompanyNews(completion: @escaping (Result<News, Error>) -> ()) {
        

        let urlString = "https://finnhub.io/api/v1/company-news?symbol=\(companyTicker1)&from=2020-04-30&to=2020-05-01&token=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server for news")
            }
            do {
                let parsedNewsFeed = try JSONDecoder().decode(Array<News>.self, from: data!)
                print(urlString)
                self.newsFeed = parsedNewsFeed
                self.newsFeed.forEach { (article) in
                    self.headLinesArray.append(article.headline)
                }
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
        }.resume()
    }
    


}

extension CompanyNewsViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ReusableCell")
        
        cell.textLabel?.text = headLinesArray[indexPath.row]

    
        return cell
    }
    
    
}
