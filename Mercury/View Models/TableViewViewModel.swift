//
//  TableViewModel.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

internal class TableViewViewModel: NSObject
    {
    private static let kArticleTableViewCellIdentifier = "ArticleTableViewCell"
    
    internal var key = DependentKey()
    
    internal weak var tableView: UITableView?
    internal var delegateTarget: NSObject?
    internal var delegateAction: Selector?
    internal private(set) var articles = Articles()
    private var model: NewsDatabase
    
    init(model: NewsDatabase)
        {
        self.model = model
        super.init()
        self.model.addDependent(self)
        self.model.fetchNewsForCountry(withCode: "za")
        }
        
    internal func configure(tableView: UITableView)
        {
        tableView.dataSource = self
        tableView.rowHeight = 100
        self.tableView = tableView
        let nib = UINib(nibName: Self.kArticleTableViewCellIdentifier, bundle: nil)
        self.tableView?.register(nib, forCellReuseIdentifier: Self.kArticleTableViewCellIdentifier)
        tableView.reloadData()
        }
    }

extension TableViewViewModel: Dependent
    {
    internal func update(aspect: Aspect, from: Model)
        {
        if case let Aspect.articles(someArticles) = aspect
            {
            self.articles = someArticles
            self.tableView?.reloadData()
            }
        }
    }
    
extension TableViewViewModel: UITableViewDataSource
    {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
        self.articles.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Self.kArticleTableViewCellIdentifier) as? ArticleTableViewCell
            {
            let view = UIView()
            view.backgroundColor = UIColor(named: "HighlightColor")
            cell.selectedBackgroundView = view
            let model = ArticleViewModel(article: self.articles[indexPath.row])
            model.configure(cell: cell)
            return(cell)
            }
        fatalError("If this has occurred something very serious is wrong")
        }
    }
    

