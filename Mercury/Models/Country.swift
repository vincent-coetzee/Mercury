//
//  Country.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

internal struct Country: Equatable
    {
    internal let code: String
    internal let name: String
    }

internal typealias Countries = Array<Country>
