//
//  LoggedInModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 17/10/21.
//

import Foundation

internal class LoggedInModel: AbstractModel
    {
    internal var loggedIn: Bool = false
        {
        didSet
            {
            self.changed(aspect: .loggedIn(self.loggedIn))
            }
        }
    }
