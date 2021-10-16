//
//  AbstractModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

public class AbstractModel: Model
    {
    private var dependents: Dictionary<DependentKey,Dependent> = [:]
    
    internal func addDependent(_ dependent: Dependent)
        {
        self.dependents[dependent.key] = dependent
        }
        
    internal func removeDependent(_ dependent: Dependent)
        {
        self.dependents[dependent.key] = nil
        }
        
    internal func changed(aspect: Aspect)
        {
        for dependent in self.dependents.values
            {
            DispatchQueue.main.async
                {
                dependent.update(aspect: aspect,from: self)
                }
            }
        }
    }
