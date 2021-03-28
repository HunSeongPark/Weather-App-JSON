//
//  Country.swift
//  weather_app
//
//  Created by 박훈성 on 2021/03/28.
//

import Foundation

/*[
  {"korean_name":"한국","asset_name":"kr"},
  {"korean_name":"독일","asset_name":"de"},
  {"korean_name":"이탈리아","asset_name":"it"},
  {"korean_name":"미국","asset_name":"us"},
  {"korean_name":"프랑스","asset_name":"fr"},
  {"korean_name":"일본","asset_name":"jp"}
] */

struct Country: Codable {
  let korean_name: String
  let asset_name: String
  
  var flag_name: String {
    return "flag_\(self.asset_name)"
  }
}
