//
//  ViewController.swift
//  assignment4
//
//  Created by wang.zichu on 2021/3/13.
//

import UIKit

class ViewController: UITableViewController {

    let cityArray = ["Seattle", "Boston", "LA", "New York", "San Deago", "Kirkland", "DC"]
    let temperatureArray = ["43", "38", "62", "69", "66", "29", "79"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "TextTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TextTableViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TextTableViewCell", owner: self, options: nil)?.first as! TextTableViewCell
        cell.cityLabel.text = self.cityArray[indexPath.row]
        let temperatureStr = "\(self.temperatureArray[indexPath.row]) F°"
        cell.temperatureLabel.text = temperatureStr
        return cell
    }
}

