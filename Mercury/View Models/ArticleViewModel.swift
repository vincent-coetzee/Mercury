//
//  ArticleViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

internal struct ArticleViewModel
    {
    ///
    ///
    /// All constants are prefixed with "k" to indicate they are constants, a hangover
    /// from Objective C days. Constants are stored inline with classes and structs so
    /// they are close to the "point of use", a concept important to Swift. This is different
    /// to how some Java pundits do it which is by centralising them on Interfaces or Classes.
    ///
    /// 
    private static let kDateFormatter: DateFormatter =
        {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return(formatter)
        }()
        
    private static let kConcurrentQueue = DispatchQueue(label: "com.macsemantics.queue",attributes: .concurrent)
    
    private let article: Article
    
    init(article: Article)
        {
        self.article = article
        }
    ///
    ///
    /// Configure the article cells, this engenders different behaviour
    /// to configuring a view since thew views makes use of more
    /// data.
    ///
    ///
    internal func configure(cell: ArticleTableViewCell)
        {
        cell.titleView.text = self.article.title
        cell.titleView.sizeToFit()
        cell.dateView.text = Self.kDateFormatter.string(from: self.article.publishedAt)
        cell.pictureView.image = UIImage(named: "NoImage")!
        self.loadArticleImage
            {
            image in
            DispatchQueue.main.async
                {
                cell.pictureView.image = image ?? UIImage(named: "NoImage")!
                }
            }
        }
        
    internal func configure(view: UIView)
        {
        }
    ///
    ///
    /// Asynchronously load the image associated with the article.
    ///
    ///
    internal func loadArticleImage(_ completion: @escaping (UIImage?) -> Void)
        {
        if let url = self.article.urlToImage
            {
            Self.kConcurrentQueue.async
                {
                if let data = try? Data(contentsOf: url,options: .alwaysMapped)
                    {
                    let image = UIImage(data: data)
                    completion(image)
                    }
                else
                    {
                    completion(nil)
                    }
                }
            }
        }
    }
