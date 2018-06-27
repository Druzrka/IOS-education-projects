//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Захар on 02.10.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var weather = CurrentWeather()
    var forecast = Forecast.init()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        weather.downloadWeatherDetails {
            self.updateUI()
        }
    }
    
    func downloadForecastData(completed: DownloadComplete) {
        
        var forecastURL = URL(string: FORECAST_URL)
        
        Alamofire.request(forecastURL!, method: .get).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? [String: AnyObject] {
                
                if let list = dict["list"] as? [[String: AnyObject]] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDic: obj)
                        
                        self.forecasts.append(forecast)
                    }
                }
            }
        }
    }
    
    func updateUI() {
        dateLabel.text = weather.date
        currentTempLabel.text = String(weather.currentTemp)
        currentWeatherTypeLabel.text = weather.weatherType
        locationLabel.text = weather.cityName
        currentWeatherImage.image = UIImage(named: weather.weatherType)
    }
}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        
        return cell
    }
}
