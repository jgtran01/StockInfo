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
    
    var companyIPOArray: [String] = ["Test"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
    }

    
    @IBAction func searchButton(_ sender: Any) {
        //performSegue(withIdentifier: "toCompanyProfile", sender: self)
        
        fetchCompanyInformation { (res) in
            print("fetchCompanyInformation function compelete")
        }
        
    }
    


    func fetchCompanyInformation(completion: @escaping (Result<CompanyModel, Error>) -> ()) {
        
        self.companyIPOArray = [""]
        let urlString = "https://finnhub.io/api/v1/stock/profile2?symbol=AAPL&token=bra4vjfrh5r8evkvd7lg"
        guard let url = URL(string: urlString) else {return}
        
        
        URLSession.shared.dataTask(with: url) { (data , resp, err) in
            //if there is an error
            if let err = err {
                completion(.failure(err))
                print("failed to connect to web server")
            }
            do {
                let companyInfo = try JSONDecoder().decode(CompanyModel.self, from: data!)
                completion(.success(companyInfo))
                let ipo = companyInfo.ipo
                print(ipo)
//                ipo.forEach { (companyFetched) in
//                    self.companyIPOArray.append(String(companyFetched))
//                    print(self.companyIPOArray)
//                    print("dfsadf")
//                }
                
            } catch let jsonError{
               completion(.failure(jsonError))
            print("failed to fetch JSON", jsonError)
            }
        }.resume()
    }



}
