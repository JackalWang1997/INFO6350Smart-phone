//
//  TableViewController.swift
//  homework6
//
//  Created by leii on 2021/3/15.
//

import UIKit

class TableViewController: UITableViewController {
    let viewModel = ViewModel()
    var modelCommodityList = [ModelCommodity]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let key = "27f86712add4c005a367c00fc6806a0a"
        let url = "https://financialmodelingprep.com/api/v3/quotes/commodity?apikey=" + key
        self.viewModel.getModelCommodities(url).done{ modelCommodityList in
            self.modelCommodityList = modelCommodityList
            self.tableView.reloadData()
        }.catch { error in
            print("Error in getting current conditions \(error.localizedDescription)")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelCommodityList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityCellID", for: indexPath)
        let modelCommodity = modelCommodityList[indexPath.row]
        cell.textLabel?.text = modelCommodity.name
        cell.detailTextLabel?.text = "Price: $" + String.init(format: "%.2f", modelCommodity.price)
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
