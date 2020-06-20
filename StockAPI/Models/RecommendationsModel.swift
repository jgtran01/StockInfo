//
//  RecommendationsModel.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/17/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation

struct RecommendationsModel: Decodable {
    
    let buy : Int
    let hold: Int
    let sell: Int
    let strongBuy: Int
    let strongSell: Int
    let period: String
    
}
