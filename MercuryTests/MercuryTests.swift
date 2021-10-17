//
//  MercuryTests.swift
//  MercuryTests
//
//  Created by Vincent Coetzee on 16/10/21.
//

import XCTest
@testable import Mercury

class MercuryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
        
    func testCountryDatabase()
        {
        let database = CountryDatabase()
        if let countries = database.countries
            {
            XCTAssertEqual(countries.count,250,"The Country Database should have returned 250 countries but returned \(countries.count) countries.")
            }
        else
            {
            XCTFail("The Country Database should have returned countries and did not.")
            }
        }
        
    func testArticleViewModel()
        {
        let currentDate = Date()
        let article = Article(title: "title", description: "", url: "", urlToImage: "https://domain.com/images/image.jpg", publishedAt: currentDate, content: "")
        let viewModel = ArticleViewModel(article: article)
        XCTAssertEqual(viewModel.title,"title","ArticleViewModel.title should be 'title' and is not.")
        XCTAssertEqual(viewModel.publishedAt,currentDate,"ArticleViewModel.publishedAt should match the date and does not.")
        XCTAssertEqual(viewModel.urlToImage,URL(string: "https://domain.com/images/image.jpg"),"ArticleViewModel.urlToImage should match and does not.")
        }
        
    func testCountriesViewModel()
        {
        let countryModel = CountryModel()
        let countries = countryModel.countries
        let countriesViewModel = CountriesViewModel(countryModel: countryModel)
        let vmCountries = countriesViewModel.countries
        XCTAssertEqual(countries.count,vmCountries.count,"The number of countries from the CountryModel and the CountriesViewModel should be the same.")
        guard countries.count == vmCountries.count else
            {
            return
            }
        for index in 0..<countries.count
            {
            XCTAssertEqual(countries[index],vmCountries[index],"Country at index \(index) should be the same in CountryModel.countries and CountriesViewModel.countries and is not.")
            }
        }
        
    func testCountryViewModel()
        {
        let countryModel = CountryModel()
        countryModel.setCountry(CountryDatabase().country(atCode: "ZA")!)
        let countryViewModel = CountryViewModel(countryModel: countryModel)
        XCTAssertEqual(countryViewModel.countryName,countryModel.country!.name,"The country names should be the same and are not.")
        }
        
    func testStringViewModel()
        {
        let model = AbstractModel()
        let currentDate = Date()
        let article = Article(title: "title", description: "", url: "", urlToImage: "https://domain.com/images/image.jpg", publishedAt: currentDate, content: "")
        let aspect = Aspect.article(article)
        let stringViewModel = StringViewModel
            {
            aspect in
            if case let Aspect.article(article) = aspect
                {
                return(article.title)
                }
            return(nil)
            }
        stringViewModel.update(aspect: aspect,from: model)
        XCTAssertEqual(stringViewModel.stringValue,article.title,"article.title should equal StringViewModel.stringValue and does not.")
        }
        
    func testTableViewViewModel()
        {
        class Target: Dependent
            {
            var key = DependentKey()
            
            var articles = Articles()
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation)
                {
                self.expectation = expectation
                }
                
            func update(aspect: Aspect,from: Model)
                {
                if case let Aspect.articles(someArticles) = aspect
                    {
                    self.articles = someArticles
                    }
                self.expectation.fulfill()
                }
            }
        let newsDatabase = NewsDatabase()
        let tableViewModel = TableViewViewModel(model: newsDatabase)
        let expectation = self.expectation(description: "News")
        let target = Target(expectation: expectation)
        newsDatabase.addDependent(target)
        newsDatabase.fetchNewsForCountry(withCode: "za")
        self.wait(for: [expectation], timeout: 60)
        XCTAssertEqual(newsDatabase.articles.count,tableViewModel.articles.count,"The counts should be the same and are not")
        guard newsDatabase.articles.count == tableViewModel.articles.count else
            {
            return
            }
        for index in 0..<newsDatabase.articles.count
            {
            XCTAssertEqual(newsDatabase.articles[index],tableViewModel.articles[index],"The articles at index \(index) should be equal and are not")
            }
        }
    }

}
