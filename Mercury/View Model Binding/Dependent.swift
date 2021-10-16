//
//  Dependent.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

internal protocol Dependent
    {
    var key: DependentKey { get }
    func update(aspect: Aspect,from: Model)
    }
