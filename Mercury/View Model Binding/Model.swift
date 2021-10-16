//
//  Model.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

internal protocol Model
    {
    func changed(aspect: Aspect)
    func addDependent(_ dependent: Dependent)
    func removeDependent(_ dependent: Dependent)
    }
