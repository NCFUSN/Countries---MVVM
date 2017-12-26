//
//  FSCountriesTableViewController.swift
//  Countries - MVVM
//
//  Created by Nathan Furman on 12/25/17.
//  Copyright © 2017 Nathan Furman. All rights reserved.
//

import UIKit

class FSCountriesTableViewController: UITableViewController {
    
    private var webservice :FSWebService!
    private var countriesListViewModel :FSCountriesListViewModel!
    private var dataSource :FSTableViewDataSource<FScountryTableViewCell,FSCountryViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FScountryTableViewCell.self, forCellReuseIdentifier: FSConstants.FSCell.countryCell.rawValue)
        self.tableView.register(UINib.init(nibName: "FScountryTableViewCell", bundle: nil), forCellReuseIdentifier: FSConstants.FSCell.countryCell.rawValue)
        update()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func update() {
        
        self.webservice = FSWebService()
        self.countriesListViewModel = FSCountriesListViewModel(webservice: self.webservice)
        
        self.countriesListViewModel.bindToCountriesViewModels = {
            
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        
        self.dataSource = FSTableViewDataSource(cellIdentifier: FSConstants.FSCell.countryCell.rawValue, items: self.countriesListViewModel.countryViewModels) { cell, vm in
            
            cell.lblName.text = vm.name
            cell.lblCurrency.text = "\(vm.symbol) - \(vm.currency)"

        }
        
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
}
