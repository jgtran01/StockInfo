//
//  Company.swift
//  StockAPI
//
//  Created by Jonathan Tran on 5/31/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation

struct CompanyProfileModel : Decodable {
    
    let country: String
    let currency: String
    let exchange: String
    let finnhubIndustry: String
    let logo: String
    let ipo: String
    let marketCapitalization: Double
    let name: String
    let phone: String
    let shareOutstanding: Double
    let ticker: String
    let weburl : String
    
}
