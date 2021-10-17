//
//  ArticleViewController.swift
//  Mercury
//
//  Created by Vincent Coetzee on 17/10/21.
//

import UIKit

class ArticleViewController: UIViewController
    {
    internal var article: Article?
        {
        didSet
            {
            if let article = self.article
                {
                self.articleModel.changed(aspect: .article(article))
                }
            }
        }
        
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var dateView: UILabel!
    @IBOutlet var urlView: UILabel!
    @IBOutlet var descriptionView: UILabel!
    @IBOutlet var contentView: UITextView!
    
    private var titleViewModel: StringViewModel!
    private var dateViewModel: StringViewModel!
    private var urlViewModel: StringViewModel!
    private var descriptionViewModel: StringViewModel!
    private var contentViewModel: StringViewModel!
    private var articleModel: AbstractModel!
    private var imageViewModel: ImageViewModel!
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        self.articleModel = AbstractModel()
        self.initViewModels()
        }
        
    private func initViewModels()
        {
        self.titleViewModel = StringViewModel
            {
            [weak self]
            aspect in
            if case let Aspect.article(article) = aspect
                {
                self?.titleView.text = article.title
                return(article.title)
                }
            return(nil)
            }
        self.articleModel.addDependent(self.titleViewModel)
        self.dateViewModel = StringViewModel
            {
            [weak self]
            aspect in
            if case let Aspect.article(article) = aspect
                {
                let string = ArticleViewModel.kDateFormatter.string(from: article.publishedAt)
                self?.dateView.text = string
                return(string)
                }
            return(nil)
            }
        self.articleModel.addDependent(self.dateViewModel)
        self.urlViewModel = StringViewModel
            {
            [weak self]
            aspect in
            if case let Aspect.article(article) = aspect
                {
                self?.urlView.text = article.url
                return(article.url)
                }
            return(nil)
            }
        self.articleModel.addDependent(self.urlViewModel)
        self.descriptionViewModel = StringViewModel
            {
            [weak self]
            aspect in
            if case let Aspect.article(article) = aspect
                {
                self?.descriptionView.text = article.description
                return(article.description)
                }
            return(nil)
            }
        self.articleModel.addDependent(self.descriptionViewModel)
        self.contentViewModel = StringViewModel
            {
            [weak self]
            aspect in
            if case let Aspect.article(article) = aspect
                {
                self?.contentView.text = article.content
                return(article.content)
                }
            return(nil)
            }
        self.articleModel.addDependent(self.contentViewModel)
        self.imageViewModel = ImageViewModel
            {
            [weak self]
            aspect in
            if case let Aspect.article(article) = aspect
                {
                if let string = article.urlToImage,let url = URL(string: string)
                    {
                    ArticleViewModel.kConcurrentQueue.async
                        {
                        if let data = try? Data(contentsOf: url,options: .alwaysMapped)
                            {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async
                                {
                                self?.imageView.image = image
                                }
                            }
                        }
                    }
                }
            return(nil)
            }
        self.articleModel.addDependent(self.imageViewModel)
        }
        
    @IBAction func onDismissTapped(_ sender: Any?)
        {
        self.dismiss(animated: true)
        }
    }
