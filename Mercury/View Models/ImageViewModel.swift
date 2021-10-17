//
//  ImageViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 17/10/21.
//

import UIKit

internal typealias ImageViewModelMappingClosure = (Aspect) -> UIImage?

public class ImageViewModel: Dependent
    {
    internal var key = DependentKey()
    
    internal var imageValue: UIImage = UIImage()
    
    private let closure: ImageViewModelMappingClosure
    
    init(closure: @escaping ImageViewModelMappingClosure)
        {
        self.closure = closure
        }
        
    internal func update(aspect: Aspect,from: Model)
        {
        if let image = self.closure(aspect)
            {
            self.imageValue = image
            }
        }
    }
