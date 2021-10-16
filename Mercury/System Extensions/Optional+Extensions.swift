//
//  Optional+Extensions.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

///
///
/// Add two simple extensions to Optional to make deealing with them
/// easier.
///
/// 
extension Optional
    {
    internal var isNil: Bool
        {
        switch(self)
            {
            case .none:
                return(true)
            default:
                return(false)
            }
        }
        
    internal var isNotNil: Bool
        {
        switch(self)
            {
            case .some:
                return(true)
            default:
                return(false)
            }
        }
    }
