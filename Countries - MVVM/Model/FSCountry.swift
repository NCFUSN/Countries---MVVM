//
//  FSCountry.swift
//  Countries - MVVM
//
//  Created by Nathan Furman on 12/25/17.
//  Copyright © 2017 Nathan Furman. All rights reserved.
//

import Foundation

class FSCountry {
    
    var name: String
    var currency: String
    var symbol: String
    
    init?(dictionary: FSJSONDictionary) {
        
        guard let name = dictionary["country_original_name"] as? String,
            let currency = dictionary["currency_original_unit_name"] as? String,
            let symbol = dictionary["currency_unit_sign"] as? String else {
                return nil
    }
        self.name = name
        self.currency = currency
        self.symbol = symbol
  }
    
    init(viewModel :FSCountryViewModel) {
        
        self.name = viewModel.name
        self.currency = viewModel.currency
        self.symbol = viewModel.symbol
    }
}
