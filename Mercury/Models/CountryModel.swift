//
//  CountryModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

public class CountryModel: AbstractModel, Dependent
    {
    internal var countries: Countries
        {
        return(CountryDatabase.shared.countries)
        }
        
    internal var countryName: String
        {
        self.country?.name ?? ""
        }
        
    internal var key = DependentKey()
    internal private(set) var country: Country?
    
    internal func update(aspect: Aspect,from: Model)
        {
        if case let Aspect.country(aCountry) = aspect
            {
            self.country = aCountry
            }
        self.changed(aspect: aspect)
        }
        
    internal func setCountry(_ country: Country)
        {
        self.country = country
        self.changed(aspect: .country(country))
        }
    }
