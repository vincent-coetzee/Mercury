//
//  CountriesViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 17/10/21.
//

import UIKit

internal class CountriesViewModel: NSObject
    {
    public var countries: Countries
        {
        return(self.countryModel.countries)
        }
        
    private let countryModel: CountryModel
    
    init(countryModel: CountryModel)
        {
        self.countryModel = countryModel
        }
        
    internal func configure(view: UIPickerView)
        {
        view.dataSource = self
        view.reloadComponent(0)
        }
    }
    
extension CountriesViewModel: UIPickerViewDataSource
    {
    func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
        1
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
        self.countryModel.countries.count
        }
    }
    
