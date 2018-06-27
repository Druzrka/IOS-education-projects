//
//  Constants.swift
//  WeatherApp
//
//  Created by Захар on 05.10.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import Foundation

let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGTITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "afb27bd2b0ab3f5b3a8e954174c44da6"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)-36\(LONGTITUDE)123\(APP_ID)\(API_KEY)"
let FORECAST_URL = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=-36&lon=123&cnt=10&appid=afb27bd2b0ab3f5b3a8e954174c44da6"
