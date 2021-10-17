//
//  ViewController.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

class MainViewController: UIViewController
    {
    private static let kArticleViewControllerIdentifier = "ArticleViewController"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var countryLabel: UILabel!
    
    private let newsDatabase = NewsDatabase()
    private let countryDatabase = CountryDatabase()
    private var tableViewModel: TableViewViewModel!
    private var countryModel: CountryModel!
    private var countryViewModel: CountryViewModel!
    
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
        self.countryModel.setCountry(self.countryDatabase.country(atCode: "ZA")!)
        self.countryModel.addDependent(self.newsDatabase)
        }
        
    private func initViews()
        {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.onCountryTapped(_:)))
        self.countryLabel.isUserInteractionEnabled = true
        self.countryLabel.addGestureRecognizer(recognizer)
        self.tableView.delegate = self
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
        self.countryViewModel = CountryViewModel(countryModel: self.countryModel)
        self.countryViewModel.configure(label: self.countryLabel)
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

extension MainViewController: UITableViewDelegate
    {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
        let selectedArticle = self.tableViewModel.articles[indexPath.row]
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: Self.kArticleViewControllerIdentifier) as? ArticleViewController
            {
            self.present(controller, animated: true)
            controller.article = selectedArticle
            }
        }
    }
