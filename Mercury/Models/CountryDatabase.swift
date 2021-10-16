//
//  CountryDatabase.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import Foundation

public class CountryDatabase: AbstractModel
    {
    internal static let shared = CountryDatabase()
    
    private var countriesByName: Dictionary<String,Country> = [:]
    
    internal var countries: Countries!
    
    internal override init()
        {
        super.init()
        self.loadDatabase()
        }
        
    private func loadDatabase()
        {
        if let url = Bundle.main.url(forResource: "countries", withExtension: "csv"),let contents = try? String(contentsOf: url)
            {
            let lines = contents.components(separatedBy: "\n")
            for line in lines
                {
                if line.hasPrefix("\"")
                    {
                    var startIndex = line.index(after: line.startIndex)
                    var currentIndex = startIndex
                    while line[currentIndex] != "\""
                        {
                        currentIndex = line.index(after: currentIndex)
                        }
                    currentIndex = line.index(before: currentIndex)
                    let name = String(line[startIndex...currentIndex])
                    startIndex = line.index(currentIndex,offsetBy: 3)
                    currentIndex = line.index(startIndex,offsetBy: 1)
                    let code = String(line[startIndex...currentIndex])
                    self.countriesByName[name] = Country(code: code,name: name)
                    }
                else if !line.isEmpty
                    {
                    let pieces = line.components(separatedBy: ",")
                    let name = pieces[0]
                    let code = pieces[1]
                    self.countriesByName[name] = Country(code: code,name: name)
                    }
                }
            self.countries = self.countriesByName.values.sorted{$0.name < $1.name}
            self.changed(aspect: .countries(Countries(self.countriesByName.values)))
            }
        else
            {
            print("ERROR LOADING COUNTRIES DATABASE FROM STATIC DATA")
            }
        }
    }
    
