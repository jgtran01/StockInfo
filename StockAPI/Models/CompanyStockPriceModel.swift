//
//  CompanyStockPrice.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/4/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation

struct CompanyStockPrice : Decodable {
    
    let o : Double
    let h : Double
    let l : Double
    let c : Double
    let pc : Double
    
}
