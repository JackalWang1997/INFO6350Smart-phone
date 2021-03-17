//
//  HomeCell.swift
//  assignment5
//
//  Created by wang.zichu on 2021/3/13.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    var article:Article! {
        didSet {
            self.contentLabel.text = article.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
