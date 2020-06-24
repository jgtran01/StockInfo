//
//  NSAttributedStringExtension.swift
//  StockAPI
//
//  Created by Jonathan Tran on 6/23/20.
//  Copyright © 2020 Jonathan Tran. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    static func makeHyperLink(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        return attributedString
    }
}
