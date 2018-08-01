//
//  ViewController.swift
//  JNews
//
//  Created by Necanow on 7/31/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit

let apiKey = "1897289d45cc4a02a2f7e56a43a3077f" // global

/*
 NewsAPI:
    - The Jerusalem Post
    - Ynet
    - Recent news from Israel
    - Recent news in Hebrew
 GitHub:
    - Haaretz API?
 
 */

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var allArticles = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let article = allArticles[indexPath.row]
        
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["sourceName"]! + " | " + article["date"]!
        return cell
    }
}

