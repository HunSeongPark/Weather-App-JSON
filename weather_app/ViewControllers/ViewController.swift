//
//  ViewController.swift
//  weather_app
//
//  Created by 박훈성 on 2021/03/25.
//

import UIKit

protocol Decode {
  func decodeData()
}

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, Decode {

  @IBOutlet weak var tableView: UITableView!
  var countries: [Country] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    //네비게이션 바 타이틀 , 배경색 설정
    self.navigationItem.title = "세계 날씨"
    self.navigationController?.navigationBar.barTintColor = UIColor.systemGray2
    
    //json 데이터 파싱
    decodeData()
    
    //delegate 연결
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  
  //MARK: - methods
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "weatherSegue" {
      //데이터 전달
      let secondVC = segue.destination as! WeatherViewController
      secondVC.korean_name = countries[sender as! Int].korean_name
      secondVC.asset_name = countries[sender as! Int].asset_name
    }
  }
  
  func decodeData() {
    let jsonDecoder = JSONDecoder()
    guard let assetData = NSDataAsset(name: "countries") else { return }
    
    do {
      self.countries = try jsonDecoder.decode([Country].self, from: assetData.data)
    } catch {
      print("Error : \(error.localizedDescription)")
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell") as! MainCustomCell
    cell.countryImage.image = UIImage(named: countries[indexPath.row].flag_name)
    cell.countryLabel.text = countries[indexPath.row].korean_name
    
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(50)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.cellForRow(at: indexPath)?.isSelected = false //셀 선택 효과 제거
    self.performSegue(withIdentifier: "weatherSegue", sender: indexPath.row)
  }
}

