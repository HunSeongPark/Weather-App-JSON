//
//  WeatherViewController.swift
//  weather_app
//
//  Created by 박훈성 on 2021/03/28.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Decode {
  
  @IBOutlet weak var tableView: UITableView!
  
  var korean_name: String?
  var asset_name: String?
  var weathers: [Weather] = []
  
  var weatherImage: UIImage?
  var weatherString: String?
  var tempString: String?
  var rainString: String?
  var isTemp: Bool = false
  var isRain: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //네비게이션 바 타이틀, 배경색 설정
    self.navigationItem.title = korean_name
    self.navigationController?.navigationBar.barTintColor = UIColor.systemGray2
    
    //json 데이터 파싱
    self.decodeData()
    
    //delegate 연결
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  //MARK: - methods
  
  //각 지역 별 데이터 설정
  func setData(index: Int) {
    
    //날씨 이미지, detail view에 넘겨줄 날씨 string 설정
    switch weathers[index].state {
    case 10:
      self.weatherImage = UIImage(named: "sunny")
      self.weatherString = "맑음"
    case 11:
      self.weatherImage = UIImage(named: "cloudy")
      self.weatherString = "흐림"
    case 12:
      self.weatherImage = UIImage(named: "rainy")
      self.weatherString = "비"
    case 13:
      self.weatherImage = UIImage(named: "snowy")
      self.weatherString = "눈"
    default:
      print("weather Image Error")
    }
    
    //온도, 강수확률 폰트 색상 변경 여부
    if self.weathers[index].celsius < 10.0 {
      self.isTemp = true
    } else {
      self.isTemp = false
    }
    
    if self.weathers[index].rainfall_probability > 50 {
      self.isRain = true
    } else {
      self.isRain = false
    }
    
    //온도, 강수확률 string 포맷 설정
    let fah: Float = self.weathers[index].celsius * 9/5 + 32
    let fahString = String(format: "%.1f", fah)
    
    self.tempString = "섭씨 \(self.weathers[index].celsius)도 / 화씨 \(fahString)도"
    self.rainString = "강수확률 \(self.weathers[index].rainfall_probability)%"
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailSegue" {
      
      self.setData(index: sender as! Int)
      
      let detailVC = segue.destination as! DetailViewController
      
      //선택된 셀에 해당하는 날씨 정보 전달
      detailVC.country = self.weathers[sender as! Int].city_name
      detailVC.image = self.weatherImage
      detailVC.weatherString = self.weatherString
      detailVC.tempString = self.tempString
      detailVC.rainString = self.rainString
      detailVC.isTemp = self.isTemp
      detailVC.isRain = self.isRain
    }
  }
  
  func decodeData() {
    let jsonDecoder = JSONDecoder()
    guard let assetName = asset_name else{ return }
    guard let assetData = NSDataAsset(name: assetName) else { return }
    
    do {
      self.weathers = try jsonDecoder.decode([Weather].self, from: assetData.data)
    } catch {
      print("Error : \(error.localizedDescription)")
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weathers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCustomCell") as! WeatherCustomCell
    
    self.setData(index: indexPath.row)
    
    //셀 이미지, label text 설정
    cell.weatherImage.image = self.weatherImage
    cell.countryLabel.text = weathers[indexPath.row].city_name
    cell.tempLabel.text = self.tempString
    cell.rainLabel.text = self.rainString
    
    //isTemp , isRain 여부에 따른 폰트 색상 변경
    if self.isTemp {
      cell.tempLabel.textColor = .blue
    } else {
      cell.tempLabel.textColor = .black
    }
    
    if self.isRain {
      cell.rainLabel.textColor = .orange
    } else {
      cell.rainLabel.textColor = .black
    }
    
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(150)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.isSelected = false
    self.performSegue(withIdentifier: "detailSegue", sender: indexPath.row)
  }
}
