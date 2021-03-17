//
//  CustomCell.swift
//  WorldWeather
//
//  Created by ... on 2021/3/13.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var highImageView: UIImageView!
    @IBOutlet weak var lowImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    var modelCurrentCondition : ModelCurrentCondition?
     
    var modelOneDayForecast : ModelOneDayForecast?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
