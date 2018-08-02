//
//  HeadlineCell.swift
//  JNews
//
//  Created by Necanow on 8/1/18.
//  Copyright © 2018 EcaKnowGames. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {
    
    @IBOutlet weak var allContentSubview: UIView!
    
    //@IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var subscriptLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var article = [String: String]()
    var resetHeightLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpUI(asExpanded: Bool) {
        if article["lang"]! == "he" {
            headlineLabel.textAlignment = .right
            headlineLabel.semanticContentAttribute = .forceRightToLeft
            subscriptLabel.textAlignment = .right
            
            descriptionLabel.textAlignment = .right
            descriptionLabel.semanticContentAttribute = .forceRightToLeft
        } else {
            headlineLabel.textAlignment = .left
            headlineLabel.semanticContentAttribute = .forceLeftToRight
            subscriptLabel.textAlignment = .left
            
            descriptionLabel.textAlignment = .left
            descriptionLabel.semanticContentAttribute = .forceLeftToRight
        }
        
        //----
        headlineLabel.text = article["title"]!
        resetHeightLabel = headlineLabel
        resetHeight()
        
        //----
        subscriptLabel.text = article["sourceName"]! + " | " + article["date"]!
        resetHeightLabel = subscriptLabel
        resetHeight()
        
        //----
        descriptionLabel.text = ""
        
        // get the lowest y-coordinate of the descriptionLabel and resize
        var maxHeight = 8 + headlineLabel.frame.height + 8 + subscriptLabel.frame.height + 8
        if asExpanded {
            maxHeight += 8 + expandedDescriptionHeight() + 8
        }
        
        
        allContentSubview.frame.size = CGSize(width: allContentSubview.frame.width, height: maxHeight)
        resetCellFrame()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func resetHeight() {
        let labelWidth = resetHeightLabel.frame.width // remember original width
        resetHeightLabel.sizeToFit()
        resetHeightLabel.frame.size = CGSize(width: labelWidth, height: resetHeightLabel.frame.height)
    }
    
    func expandedDescriptionHeight() -> CGFloat {
        descriptionLabel.text = article["description"]!
        resetHeightLabel = descriptionLabel
        resetHeight()
        return descriptionLabel.frame.height
    }
    
    func resetCellFrame() {
        contentView.frame.size = CGSize(width: contentView.frame.width, height: allContentSubview.frame.height + 16)
        self.frame.size = CGSize(width: self.frame.width, height: allContentSubview.frame.height + 16)
    }
}
