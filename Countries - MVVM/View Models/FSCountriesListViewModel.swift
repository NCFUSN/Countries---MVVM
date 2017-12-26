//
//  FSCountriesListViewModel.swift
//  Countries - MVVM
//
//  Created by Nathan Furman on 12/25/17.
//  Copyright © 2017 Nathan Furman. All rights reserved.
//

import Foundation

class FSCountriesListViewModel: NSObject {
    
    @objc dynamic private(set) var countryViewModels :[FSCountryViewModel] = [FSCountryViewModel]()
    private var token :NSKeyValueObservation?
    var bindToCountriesViewModels :(() -> ()) = {  }
    private var webservice: FSWebService
    
    init(webservice: FSWebService) {
        self.webservice = webservice
        super.init()
        
        token = self.observe(\.countryViewModels) { _,_ in
            self.bindToCountriesViewModels()
        }
        
        populateCountries()
    }
    
    func invalidateObservers() {
        self.token?.invalidate()
    }
    
    func populateCountries() {
        
        self.webservice.loadCountries { [unowned self] countries in
            self.countryViewModels = countries.flatMap(FSCountryViewModel.init)
        }
    }
    
    func country(at index:Int) -> FSCountryViewModel {
        return self.countryViewModels[index]
    }
}

class FSCountryViewModel: NSObject {
    
    var name: String
    var currency: String
    var symbol: String
    
    init(name: String, currency: String, symbol: String) {
        
        self.name = name; self.currency = currency; self.symbol = symbol
    }
    
    init(country: FSCountry) {
        
        self.name = country.name
        self.currency = country.currency
        self.symbol = country.symbol
    }
}
