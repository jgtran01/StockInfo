//
//  CompanyNewsViewController.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/11/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation
import UIKit

class CompanyNewsViewController: SearchViewController {
    
    var newsFeed : [News] = []
    var headLinesArray : [String] = []
    var imageLinkArray: [String] = []
    var imagesArray : [Data] = []
    var dateArray : [String] = []
    var companyTicker1 : String = ""
    var companyLogo : UIImage!
    var urlArray = [String]()
    var sourceArray = [String]()
    
    //date initializers
    let calendar = Calendar.current
    let dateRightNow = Date()
    let dateOneWeekAgo = Date() - 604800

    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        
        formatDate()
        

    }
    
    func fetchCompanyNews(completion: @escaping (Result<News, Error>) -> (), currentMonth: String, currentDay: String, currentYear: Int, pastMonth: String, pastDay: String, pastYear: Int) {
        
        
        let urlString = "https://finnhub.io/api/v1/company-news?symbol=\(companyTicker1)&from=\(pastYear)-\(pastMonth)-\(pastDay)&to=\(currentYear)-\(currentMonth)-\( currentDay)&token=\(apiKey)"
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
                    let date = NSDate(timeIntervalSince1970: Double(article.datetime))
                    //figure out what to do with date, currently can't find a way to put in array
                    self.sourceArray.append(article.source)
                    self.imageLinkArray.append(article.image)
                    self.urlArray.append(article.url)
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
    
    
    func formatDate() {
        let date = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: date)
        let currentDay = calendar.component(.day, from: date)
        let currentYear = calendar.component(.year, from: date)
        let reformattedMonth = String(format: "%02d", currentMonth)
        let reformmatedDay = String(format: "%02d", currentDay)
        
        let pastDate = Date() - 2592000
        let pastMonth = calendar.component(.month, from: pastDate)
        let pastDay = calendar.component(.day, from: pastDate)
        let pastYear = calendar.component(.year, from: pastDate)
        let reformattedPastMonth = String(format: "%02d", pastMonth)
        let reformmatedPastDay = String(format: "%02d", pastDay)
        fetchCompanyNews(completion: { (res) in
        }, currentMonth: reformattedMonth, currentDay: reformmatedDay, currentYear: currentYear, pastMonth: reformattedPastMonth, pastDay: reformmatedPastDay, pastYear: pastYear)
       
    }
    
    
    


}

extension CompanyNewsViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headLinesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "ReusableCell") as! NewsTableViewCell
        //save textView font and style
        let font = cell.textView.font
        let alignment = cell.textView.textAlignment
        cell.sourceTextView.text = sourceArray[indexPath.row]
        cell.textView.text = headLinesArray[indexPath.row]
  //      cell.dateTextView.text = String(dateArray[indexPath.row])
        cell.articleImageView.image = companyLogo
        
        
        //create hyperlink
        let attributedString = NSAttributedString.makeHyperLink(for: urlArray[indexPath.row], in: cell.textView.text, as: cell.textView.text)
        cell.textView.attributedText = attributedString
        cell.textView.font = font
        cell.textView.textColor = UIColor.red
        cell.textView.textAlignment = alignment
        cell.textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return cell
    }
    
    
}

extension CompanyNewsViewController{
    override func viewWillLayoutSubviews() {}

}
