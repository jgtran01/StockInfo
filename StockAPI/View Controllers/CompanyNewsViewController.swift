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
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //newsTableView.dataSource = self
        fetchCompanyNews { (res) in
            print("fetched news")
            
            
        }
    }
    
    func fetchCompanyNews(completion: @escaping (Result<News, Error>) -> ()) {
    
        let urlString = "https://finnhub.io/api/v1/company-news?symbol=AAPL&from=2020-04-30&to=2020-05-01&token\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server for news")
            }
            do {
                let parsedNewsFeed = try JSONDecoder().decode(Array<News>.self, from: data!)
                self.newsFeed = parsedNewsFeed
                print(self.newsFeed)
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
        }.resume()
    }

}

//extension CompanyNewsViewController : UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
    
    
}
