//
//  CompanyFinancials.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/11/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation


struct CompanyFinancials: Decodable {
    let metric : [String : Any]
    init(from decoder: Decoder) throws {
        metric = ["fuc":2, "fsf": "fsf"]
    }
    }
