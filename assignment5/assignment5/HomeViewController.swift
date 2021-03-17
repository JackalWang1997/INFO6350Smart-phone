//
//  HomeViewController.swift
//  assignment5
//
//  Created by wang.zichu on 2021/3/13.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

let apiKey = "09a3d94b28b7410db84c6bd3a84b9d6f"
let baseURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey="

class HomeViewController: UITableViewController {

    var articles:[Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 50
        let nib = UINib.init(nibName: "HomeCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "HomeCell")
        self.tableView.tableFooterView = UIView()
        self.loadData()
    }
    
    func loadData() -> Void {
        let url = baseURL + apiKey
        AF.request(url).responseJSON { response in
            if (response.error != nil) {
                print(String(response.error!.localizedDescription))
                return
            }
            let json = try! JSON(data: response.data!)
            var tmpArr = [Article]()
            for (index, dic) in json["articles"] {
                print("index = \(index) dic = \(dic)")
                if let title = dic["title"].string {
                    let article:Article = Article()
                    article.title = title
                    tmpArr.append(article)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("HomeCell", owner: self, options: nil)?.first as! HomeCell
        cell.article = self.articles[indexPath.row]
        return cell
    }

}
