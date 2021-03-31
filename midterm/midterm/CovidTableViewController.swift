//
//  CovidTableViewController.swift
//  midterm
//
//  Created by apple on 2021/3/31.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON

class CovidTableViewController: UITableViewController {

    var covids:[Covid] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib:UINib = UINib.init(nibName: "CovidTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CovidTableViewCell")
        self.tableView.rowHeight = 80.0
        self.loadData()
    }

    func loadData() -> Void {
        SwiftSpinner.show(delay: 0.0, title: "load data...")
        AF.request("https://api.covidtracking.com/v1/states/current.json",parameters:nil).responseJSON {
            (response) in
            if let value = response.value {
                let json = JSON(value)
                print(json)
                
                for dic in json.array! {
                    let covid:Covid = Covid.init()
                    covid.state = dic["state"].string!
                    
                    if let positive = dic["positive"].number {
                        covid.positive = positive.int64Value
                    }
                    if let totalTestResults = dic["totalTestResults"].number {
                        covid.totalTestResults = totalTestResults.int64Value
                    }
                    self.covids.append(covid)
                }
                self.tableView.reloadData()
            }
            SwiftSpinner.hide()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.covids.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CovidTableViewCell", for: indexPath) as! CovidTableViewCell
        cell.covid = self.covids[indexPath.row]
        return cell
    }

}
