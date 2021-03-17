//
//  WorldWeatherHomeVC.swift
//  WorldWeather
//
//  Created by ... on 2021/3/13.
//

import UIKit
import CoreLocation
class WorldWeatherHomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    
    // We need to have a class of View Model
    let viewModel = WorldWeatherViewModel()
    var dayForecastList = [ModelOneDayForecast]()
    var modelCity : ModelCity?
    
    var modelCurrentCondition : ModelCurrentCondition?
    var modelOneDayForecast : ModelOneDayForecast?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate  = self
        tableView.dataSource =  self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
   //cellIDOne
    
  //  CustomCellTwo
    

}
extension WorldWeatherHomeVC:UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    //MARK: Location Manager functions
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currLocation = locations.last{
            
            let lat = currLocation.coordinate.latitude
            let lng = currLocation.coordinate.longitude
            
            print(lat)
            print(lng)
            updateWeatherData(lat, lng)
        }
    }
    
    
    //MARK: Update the weather from ViewModel
    
    func updateWeatherData(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees){
        
        let cityDataURL = getLocationURL(lat, lng)
        
        viewModel.getCityData(cityDataURL).done { city in
            // Update City Name
            //self.lblCity.text = city.cityName
            self.modelCity = city
            let key = city.cityKey
            let currentConditionURL = getCurrentConditionURL(key)
            let oneDayForecastURL = getOneDayURL(key)
            let fiveDayForecastURL = getFiveDayURL(key)
            
            self.viewModel.getCurrentConditions(currentConditionURL).done { currCondition in
                //self.lblCondition.text = currCondition.weatherText
                //self.lblTemperature.text =  "\(currCondition.imperialTemp)°"
                self.modelCurrentCondition = currCondition
                self.tableView.reloadData()
            }.catch { error in
                print("Error in getting current conditions \(error.localizedDescription)")
            }
            
            self.viewModel.getOneDayConditions(oneDayForecastURL).done { oneDay in
                //self.lblHighLow.text = "H: \(oneDay.dayTemp)° L: \(oneDay.nightTemp)°"
                self.modelOneDayForecast = oneDay
                self.tableView.reloadData()
            }.catch { error in
                print("Error in getting one day forecast conditions \(error.localizedDescription)")
            }
            self.viewModel.getFiveDayConditions(fiveDayForecastURL).done { dayForecastList in
                //self.lblHighLow.text = "H: \(oneDay.dayTemp)° L: \(oneDay.nightTemp)°"
                self.dayForecastList = dayForecastList
                self.tableView.reloadData()
            }.catch { error in
                print("Error in getting one day forecast conditions \(error.localizedDescription)")
            }
        }
        .catch { error in
            print("Error in getting City Data \(error.localizedDescription)")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Bonus cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellTwo", for: indexPath) as! CustomCell
            
            //1modelCity
            if modelCity != nil {
                cell.cityLabel.text = modelCity!.cityName
            }
            //2modelCurrentCondition
            if modelCurrentCondition != nil {
                var imageName = String(modelCurrentCondition!.weatherIcon) + "-s"
                if modelCurrentCondition!.weatherIcon < 10 {
                    imageName = "0" + imageName
                }
                cell.tempImageView.image = UIImage(named: imageName)
                cell.conditionLabel.text = modelCurrentCondition!.weatherText
                cell.tempLabel.text  = "\(modelCurrentCondition!.imperialTemp)°"
            }
            //3modelOneDayForecast
            if modelOneDayForecast != nil {
                
                
                cell.highLabel.text = "H: \(modelOneDayForecast!.dayTemp)°"
                cell.lowLabel.text  = "L: \(modelOneDayForecast!.nightTemp)°"
                
                //set highImageView the image
                var dayIcon = String(modelOneDayForecast!.dayIcon) + "-s"
                if modelOneDayForecast!.dayIcon < 10 {
                    dayIcon = "0" + dayIcon
                }
                cell.highImageView.image = UIImage(named: dayIcon)
                //set lowImageView the image
                var nightIcon = String(modelOneDayForecast!.nightIcon) + "-s"
                if modelOneDayForecast!.nightIcon < 10 {
                    nightIcon = "0" + nightIcon
                }
                cell.lowImageView.image = UIImage(named: nightIcon)
            }
            
            return cell
        }
        
        //12345
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIDOne", for: indexPath)
        if (indexPath.row - 1) < dayForecastList.count {
            
            let dayForecast = dayForecastList[indexPath.row - 1]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 11)
            cell.textLabel?.text = "Day:\(dayForecast.dayIconPhrase)\nNight:\(dayForecast.nightIconPhrase)"
            // show 2 line
            cell.textLabel?.numberOfLines = 2
            // \n next line
            cell.detailTextLabel?.text = "H: \(dayForecast.dayTemp)° \nL: \(dayForecast.nightTemp)°"
            cell.detailTextLabel?.numberOfLines = 2
        }else{
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            
        }
        
        return cell
        
        
        
        
    }
    
    
    
}


