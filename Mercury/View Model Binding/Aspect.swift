//
//  Aspect.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

///
///
/// An aspect defines an aspect of a model as well as defining ( and carrying as
/// a payload ) the type of data that an aspect of a model consists of. Instead of
/// broadcasting arbitrary messages, models very specifically notify their
/// dependents of changes to their aspects, sending along with the aspect the
/// data that has changed. This allows the depenent to be notified and updated
/// in a single step.
///
/// 
internal enum Aspect
    {
    case articles(Articles)
    case articleTitle(String)
    case articleDate(Date)
    case articleImage(UIImage)
    case articleText(String)
    case country(Country)
    case countries(Countries)
    case article(Article)
    case error(String)
    case loggedIn(Bool)
    }
