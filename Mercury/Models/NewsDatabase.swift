//
//  NewsDatabase.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

///
///
/// NewsDatabase fetches and propagates news articles around the application.
/// Inherits from AbstractModel so it does not have to implement dependency
/// management from scratch. It publishes the .articles aspect.
///
///
internal class NewsDatabase: AbstractModel,Dependent
    {
    internal let key = DependentKey()
    
    private static let kNewsAPIKey = "e7bcfc5a4e0c41ac80e32e8e0f1cbccb"
    private static let kNewsAPIKeyQueryString = "apiKey=\(NewsDatabase.kNewsAPIKey)"
    private static let kNewsAPIBaseString = "https://newsapi.org/v2/top-headlines"

    internal func fetchNewsForCountry(withCode code: String)
        {
        var components = URLComponents(string: Self.kNewsAPIBaseString)
        let items = [URLQueryItem(name:"apiKey",value: Self.kNewsAPIKey),URLQueryItem(name: "country",value: code)]
        components?.queryItems = items
        if let url = components?.url
            {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request)
                {
                data,response,error in
                if error.isNotNil
                    {
                    let message = "Querying the News API failed. Please see the log for more details."
                    self.changed(aspect: .error(message))
                    print("ERROR QUERYING THE NEWS API")
                    print("\(error!)")
                    }
                else
                    {
                    if let data = data
                        {
                        do
                            {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                            let response = try decoder.decode(ArticleQueryResponse.self, from: data)
                            self.changed(aspect: .articles(response.articles))
                            }
                        catch let error
                            {
                            let message = "Unable to decode the JSON.\(error)"
                            self.changed(aspect: .error(message))
                            print("UNABLE TO DECODE THE JSON STRING ERROR \(error)")
                            print(error)
                            if let string = String(data: data,encoding: .utf8)
                                {
                                print(string)
                                }
                            }
                        }
                    else
                        {
                        let message = "Unable to convert response payload into JSON."
                        self.changed(aspect: .error(message))
                        print("UNABLE TO CONVERT RESPONSE DATA INTO A JSON STRING")
                        }
                    }
                }
            dataTask.resume()
            }
        }
        
    internal func update(aspect: Aspect,from: Model)
        {
        if case let Aspect.country(aCountry) = aspect
            {
            let code = aCountry.code.lowercased()
            self.fetchNewsForCountry(withCode: code)
            }
        }
    }

///
///
/// An extension to DateFormatter to allow for the parsing
/// of JSON as returned from the NewsAPI service. The format
/// is almost ISO8601Full but not exactly.
///
/// 
extension DateFormatter
    {
    static let iso8601Full: DateFormatter =
        {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        }()
    }
