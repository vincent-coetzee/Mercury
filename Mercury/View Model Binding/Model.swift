//
//  Model.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

///
///
/// A model manages a collection of dependents who have an interest
/// in the aspects vended by it. A dependent will ad itself to a model
/// as a dependent. When an aspect of a model changes it will broadcast
/// that aspect ( with its payload ) to all of its dependents.
///
/// 
internal protocol Model
    {
    func changed(aspect: Aspect)
    mutating func addDependent(_ dependent: Dependent)
    mutating func removeDependent(_ dependent: Dependent)
    }
