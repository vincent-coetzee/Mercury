//
//  CountryViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

public class CountryViewModel
    {
    private var countryName: String
        {
        return(self.countryModel.countryName)
        }
        
    private let countryModel: CountryModel
    
    init(countryModel: CountryModel)
        {
        self.countryModel = countryModel
        }
        
    public func configure(label: UILabel)
        {
        label.text = self.countryName
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(CountryViewModel.onCountryTapped(_:)))
        label.addGestureRecognizer(recognizer)
        }
        
    @objc func onCountryTapped(_ sender: Any?)
        {
        }
    }
