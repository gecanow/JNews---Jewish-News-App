//
//  APIHandler.swift
//  JNews
//
//  Created by Necanow on 8/1/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit

class APIHandler: NSObject {
    
    func getAllArticles() -> [[String: String]] {
        var articleArr = [[String: String]]()
        
        let query1 = "https://newsapi.org/v2/top-headlines?country=il&apiKey=\(apiKey)"
        let query2 = "https://newsapi.org/v2/top-headlines?sources=the-jerusalem-post&apiKey=\(apiKey)"
        
        articleArr += pleaseQuery(query1, lang: "he")
        articleArr += pleaseQuery(query2, lang: "en")
        return articleArr
    }
    
    //--------------------//
    // QUERYING FUNCTIONS //
    //--------------------//
    
    //=========================================
    // Takes in a URL and returns the results
    // of the parse function
    //=========================================
    func pleaseQuery(_ query: String, lang: String) -> [[String: String]] {
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["status"] == "ok" {
                    return self.parse(json: json, lang: lang)
                }
            }
        }
        return [[String: String]]()
    }
    
    //=========================================
    // Parses for all sources of a given type
    //=========================================
    func parse(json: JSON, lang: String) -> [[String: String]] {
        var articles = [[String: String]]()
        
        for result in json["articles"].arrayValue {
            let title = result["title"].stringValue
            let description = result["description"].stringValue
            let url = result["url"].stringValue
            let date = String(result["publishedAt"].stringValue.prefix(10))
            let sourceName = result["source"]["name"].stringValue
            
            let article = ["title": title, "description": description, "url": url, "sourceName": sourceName, "date": date, "lang": lang]
            articles.append(article)
        }
        
        return articles
    }
    
    //=========================================
    // Informs the user of a loading error
    //=========================================
    func loadError(problem: String) {
        DispatchQueue.main.async {
            [unowned self] in
            //(rest of method goes here)
            
            //let alert = UIAlertController(title: "Loading Error",
              //                            message: problem,
                //                          preferredStyle: .actionSheet)
            //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
            print("Error: \(problem)")
        }
    }
    
}
