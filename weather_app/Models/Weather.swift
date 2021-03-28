//
//  Weather.swift
//  weather_app
//
//  Created by 박훈성 on 2021/03/28.
//

import Foundation

/* {
  "city_name":"베를린",
  "state":12,
  "celsius":10.8,
  "rainfall_probability":60
}, */

struct Weather: Codable {
  let city_name: String
  let state: Int
  let celsius: Float
  let rainfall_probability: Int
}
