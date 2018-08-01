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
        
        let query = "https://newsapi.org/v2/top-headlines?country=il&apiKey=\(apiKey)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            // rest of method goes here
            
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    if json["status"] == "ok" {
                        self.parse(json: json)
                        return
                    }
                }
            }
            self.loadError(problem: "There was a problem loading the news feed.")
        }
    }
    
    
    
    //--------------------//
    // QUERYING FUNCTIONS //
    //--------------------//
    
    //=========================================
    // Parses for all sources of a given type
    //=========================================
    func parse(json: JSON) {
        print(json["totalResults"])
        for result in json["articles"].arrayValue {
            let title = result["title"].stringValue
            let description = result["description"].stringValue
            let url = result["url"].stringValue
            let date = String(result["publishedAt"].stringValue.prefix(10))
            let sourceName = result["source"]["name"].stringValue
            
            let article = ["title": title, "description": description, "url": url, "sourceName": sourceName, "date": date, "timeToComplete": "", "isFinished": "false"]
            articles.append(article)
        }
        
        if articles.count > 0 {
            DispatchQueue.main.async {
                [unowned self] in
                self.performSegue(withIdentifier: "gameSegue2", sender: self)
            }
        } else {
            loadError(problem: "Not enough sources available.")
        }
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
