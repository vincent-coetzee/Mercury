//
//  CountrySelectionButtonViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 17/10/21.
//

import UIKit

internal struct CountrySelectionButtonViewModel
    {
    internal var country: Country
        {
        didSet
            {
            if let button = self.button
                {
                button.setTitle(self.country.name, for: .normal)
                }
            }
        }
        
    private var button: UIButton?
    
    internal init()
        {
        self.country = CountryDatabase.shared.country(atCode: "ZA")!
        }
        
    internal mutating func configure(button: UIButton)
        {
        self.button = button
        self.button!.setTitle(self.country.name, for: .normal)
        }
    }
