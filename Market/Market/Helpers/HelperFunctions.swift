//
//  HelperFunctions.swift
//  Market
//
//  Created by ioannis giannakidis on 04/09/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import Foundation
func convertToCurrency(_ number: Double)-> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    let priceString =  currencyFormatter.string(from: NSNumber(value: number))!
    
    return priceString
}
