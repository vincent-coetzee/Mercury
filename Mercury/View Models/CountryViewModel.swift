//
//  CountryViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

public class CountryViewModel: Dependent
    {
    internal let key = DependentKey()
    
    internal var countryName: String
        {
        return(self.countryModel.countryName)
        }
        
    private let countryModel: CountryModel
    private var label: UILabel!
    
    init(countryModel: CountryModel)
        {
        self.countryModel = countryModel
        self.countryModel.addDependent(self)
        }
        
    public func configure(label: UILabel)
        {
        label.text = self.countryName
        self.label = label
        }
        
    internal func update(aspect: Aspect,from: Model)
        {
        if case let Aspect.country(aCountry) = aspect
            {
            self.label.text = aCountry.name
            }
        }
    }
