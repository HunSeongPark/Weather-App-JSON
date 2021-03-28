//
//  DetailViewController.swift
//  weather_app
//
//  Created by 박훈성 on 2021/03/29.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
  
  var country: String?
  var image: UIImage?
  var weatherString: String?
  var tempString: String?
  var rainString: String?
  var isTemp: Bool = false
  var isRain: Bool = false
  
  @IBOutlet weak var weatherImage: UIImageView!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var rainLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //네비게이션 바 타이틀, 배경색 설정
    self.navigationItem.title = country
    self.navigationController?.navigationBar.barTintColor = UIColor.systemGray2
    
    //각 Label text 및 폰트 설정
    self.weatherImage.image = self.image
    self.weatherLabel.text = self.weatherString
    self.weatherLabel.font = UIFont.boldSystemFont(ofSize: 17)
    
    self.tempLabel.text = self.tempString
    self.rainLabel.text = self.rainString
    
    //온도, 강수 확률에 따른 폰트 색상 변경
    if self.isTemp {
      self.tempLabel.textColor = .blue
    } else {
      self.tempLabel.textColor = .black
    }
    if self.isRain {
      self.rainLabel.textColor = .orange
    } else {
      self.rainLabel.textColor = .black
    }
    
  }
}
