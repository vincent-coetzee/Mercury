//
//  Dependent.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

///
///
/// A depedent will get notified when an aspect changes. It is the
/// dependents resposibility to test the aspect to see if it is relevant
/// to it and to extract the payload if it is. A depdendent neeeds to have a
/// key which uniquely identifies it so the model can manage depdencies
/// accordingly.
///
/// 
internal protocol Dependent
    {
    var key: DependentKey { get }
    func update(aspect: Aspect,from: Model)
    }

internal typealias Dependents = Array<Dependent>
