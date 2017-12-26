//
//  File.swift
//  Countries - MVVM
//
//  Created by Nathan Furman on 12/25/17.
//  Copyright © 2017 Nathan Furman. All rights reserved.
//

import Foundation

typealias FSJSONDictionary = [String:Any]

class FSWebService {
    
    func loadCountries(completion: @escaping ([FSCountry]) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string:FSWebSource.countriesList.rawValue)!) { data,_,_  in
            
            var countries = [FSCountry]()
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                for unit in json! {
                    
                    let count = FSCountry(dictionary: unit )
                    countries.append(count!)
                }
                DispatchQueue.main.async {
                    completion(countries)
                }
            }
        }.resume()
    }
}
