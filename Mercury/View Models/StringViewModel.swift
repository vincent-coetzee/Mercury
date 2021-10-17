//
//  StringViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 17/10/21.
//

import UIKit

internal typealias StringViewModelMappingClosure = (Aspect) -> String?

public class StringViewModel: Dependent
    {
    internal var key = DependentKey()
    
    internal var stringValue: String = ""
    
    private let closure: StringViewModelMappingClosure
    
    init(closure: @escaping StringViewModelMappingClosure)
        {
        self.closure = closure
        }
        
    internal func update(aspect: Aspect,from: Model)
        {
        if let string = self.closure(aspect)
            {
            self.stringValue = string
            }
        }
    }
