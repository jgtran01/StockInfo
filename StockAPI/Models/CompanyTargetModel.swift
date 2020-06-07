//
//  CompanyTargetModel.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/6/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation

struct CompanyTarget: Decodable {
    let lastUpdated : String
    let symbol: String
    let targetHigh : Double
    let targetLow: Double
    let targetMean: Double
    let targetMedian: Double
}
