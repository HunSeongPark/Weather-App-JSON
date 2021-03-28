//
//  WeatherCustomCell.swift
//  weather_app
//
//  Created by 박훈성 on 2021/03/28.
//

import Foundation
import UIKit

class WeatherCustomCell: UITableViewCell {

  @IBOutlet weak var weatherImage: UIImageView!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var rainLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    //폰트 크기, 스타일 설정
    self.countryLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    self.tempLabel?.font = UIFont.systemFont(ofSize: 17)
    self.rainLabel?.font = UIFont.systemFont(ofSize: 17)
    
    //오토 레이아웃 설정
    self.weatherImage?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    self.weatherImage?.widthAnchor.constraint(equalToConstant: 50).isActive = true
    self.weatherImage?.heightAnchor.constraint(equalTo: self.weatherImage.widthAnchor).isActive = true
    self.weatherImage?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.countryLabel?.leadingAnchor.constraint(equalTo: self.weatherImage.trailingAnchor, constant: 20).isActive = true
    self.tempLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
  }
}
