//
//  ViewController.swift
//  JNews
//
//  Created by Necanow on 7/31/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit

let apiKey = "1897289d45cc4a02a2f7e56a43a3077f" // global
// GitHub: Haaretz API?

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var allArticles = [[String: String]]()
    var cellHeights = [CGFloat]()
    
    let apiHandle = APIHandler()
    
    var expandedLabelHeight : CGFloat!
    var selectedRowIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        allArticles = apiHandle.getAllArticles()
        cellHeights = [CGFloat](repeating: 120, count: allArticles.count)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! HeadlineCell
        cell.article = allArticles[indexPath.row]
        
        let expanded = (indexPath.row == selectedRowIndex)
        cell.setUpUI(asExpanded: expanded)
        if !expanded {
            cellHeights[indexPath.row] = cell.contentView.frame.height
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex {
            return cellHeights[indexPath.row] + expandedLabelHeight + 32
        }
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! HeadlineCell
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1
        } else {
            selectedRowIndex = indexPath.row
            expandedLabelHeight = cell.expandedDescriptionHeight()
        }
        
        //tableView.reloadRows(at: [IndexPath(row: selectedRowIndex, section: 0)], with: .none)
        //tableView.scrollToRow(at: IndexPath(row: selectedRowIndex, section: 0), at: .top, animated: true)
        
        tableView.reloadData()
    }
}

