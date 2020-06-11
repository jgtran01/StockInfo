//
//  Article.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/6/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation

struct Article: Decodable {
    
    let category : String
    let datetime: Int
    let headline: String
    let id : Int
    let image : String
    let related : String
    let source : String
    let summary : String
    let url : String
}
