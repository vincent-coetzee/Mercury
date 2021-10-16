//
//  ViewController.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

class MainViewController: UIViewController
    {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var countryLabel: UILabel!
    
    private let newsDatabase = NewsDatabase()
    private let countryDatabase = CountryDatabase()
    private var tableViewModel: TableViewViewModel!
    private var countryModel: CountryModel!
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        self.initModels()
        self.initViews()
        self.initViewModels()
        }
        
    private func initModels()
        {
        self.countryModel = CountryModel()
        }
        
    private func initViews()
        {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.onCountryTapped(_:)))
        self.countryLabel.isUserInteractionEnabled = true
        self.countryLabel.addGestureRecognizer(recognizer)
        }
        
    @objc func onCountryTapped(_ sender: Any?)
        {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "CountryPickerViewController") as? CountryPickerViewController
            {
            self.present(controller, animated: true)
            controller.countryModel = self.countryModel
            }
        }
        
    private func initViewModels()
        {
        self.tableViewModel = TableViewViewModel(model: self.newsDatabase)
        self.tableViewModel.configure(tableView: self.tableView)
        }
    
    @IBAction func onArticleSelected(_ sender: Any?)
        {
        }
        
    internal func update(aspect: Aspect,from: Model)
        {
        if case let Aspect.articles(articles) = aspect
            {
            for article in articles
                {
                print(article.title)
                }
            }
        }
    }

