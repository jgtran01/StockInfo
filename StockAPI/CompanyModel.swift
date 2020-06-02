//
//  Company.swift
//  StockAPI
//
//  Created by Jonathan Tran on 5/31/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation

struct CompanyModel : Decodable {
    
    let country: String
    let currency: String
    let exchange: String
    let ipo: String
    let weburl : String
    
}
