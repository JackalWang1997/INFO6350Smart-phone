//
//  CovidTableViewCell.swift
//  midterm
//
//  Created by apple on 2021/3/31.
//

import UIKit

class CovidTableViewCell: UITableViewCell {

    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var positiveLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var covid:Covid!{
        didSet {
            self.stateLabel.text = "\(covid.state)"
            self.positiveLabel.text = "Positive:\(covid.positive)"
            self.totalLabel.text = "Total:\(covid.totalTestResults)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
