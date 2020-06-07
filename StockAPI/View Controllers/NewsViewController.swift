//
//  NewsViewController.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/6/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    let apiKey = "brdg5pnrh5rf712pc860"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("News VC loaded")
        fetchNews { (res) in
            print("fetched news")
        }
    }
    

    func fetchNews(completion: @escaping (Result<GeneralNews, Error>) -> ()) {
        let urlString = "https://finnhub.io/api/v1/news?category=general&token=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server for news")
            }
            do {
                let news = try JSONDecoder().decode(Array<GeneralNews>.self, from: data!)
                print(news[0].headline)
                print(news[1].headline)
                print(news[2].headline)
            } catch let jsonError {
                completion(.failure(jsonError))
                print("failed to fetch JSON", jsonError)
            }
        }.resume()
    }
}


