import UIKit

class Main: UIViewController{
  let wCell = "WeatherCell"
  var data = [CellData]()
  
  let topView:UIView = {
    let v = UIView()
    v.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    return v
  }()
  
  let dateLabel: UILabel = {
    let l = UILabel()
    l.text = "Wed 4 April 2018"
    l.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    return l
  }()
  
  let locationLabel: UILabel = {
    let l = UILabel()
    l.text = "Damietta, Egypt"
    l.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    return l
  }()
  
  let conditionLabel: UILabel = {
    let l = UILabel()
    l.text = "Cool"
    l.textAlignment = .center
    l.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    return l
  }()
  
  let conditionImg: UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "Clouds")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let tempLabel: UILabel = {
    let l = UILabel()
    l.text = "26°"
    
    l.font = UIFont.boldSystemFont(ofSize: 70)
    l.textAlignment = .center
    
    l.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    return l
  }()
  
  let weatherTable: UITableView = {
    let tv = UITableView()
    tv.allowsSelection = false
    return tv
  }()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    networkCalls()
  }
  
  func setupViews(){
    view.addSubview(topView)
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    setupTopView()
    setupWeatherTable()
  }
  
}

// top view
extension Main{
  func setupTopView(){
    topView.anchorEdges(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil)
    topView.anchorWH(width: nil, wMultiplier: 0, height: view.heightAnchor, hMultiplier: 1/3)
    topView.addSubview(dateLabel)
    topView.addSubview(locationLabel)
    topView.addSubview(conditionLabel)
    topView.addSubview(conditionImg)
    topView.addSubview(tempLabel)
    
    dateLabel.anchorEdges(top: topView.safeAreaLayoutGuide.topAnchor, tConst: 16, left: topView.safeAreaLayoutGuide.leftAnchor, lConst: 16, right: nil, rConst: 0, bottom: nil, bConst: 0)
    
    locationLabel.anchorEdges(top: nil, tConst: 0, left: topView.safeAreaLayoutGuide.leftAnchor, lConst: 16, right: nil , rConst: 0 , bottom: topView.safeAreaLayoutGuide.bottomAnchor, bConst: -16)
    
    locationLabel.anchorWHC(width: view.frame.width / 2, height: nil)
    
    conditionLabel.anchorEdges(top: nil, tConst: 0, left: locationLabel.rightAnchor, lConst: 16 , right: topView.rightAnchor, rConst: -16, bottom: topView.bottomAnchor, bConst: -16)
    
    tempLabel.anchorEdges(top: dateLabel.topAnchor, tConst: 32, left: topView.leftAnchor, lConst: 16, right: nil, rConst: 0, bottom: locationLabel.topAnchor, bConst: -16)
    
    conditionImg.anchorEdges(top: topView.topAnchor, tConst: 32, left: nil, lConst: 0, right: topView.rightAnchor, rConst: -16, bottom: nil, bConst: 0)
  }
  
}




extension Main: UITableViewDelegate, UITableViewDataSource {
  
  func setupWeatherTable(){
    weatherTable.register(WeatherCell.self, forCellReuseIdentifier: wCell)
    weatherTable.separatorStyle = .none
    weatherTable.rowHeight = 90
    weatherTable.showsVerticalScrollIndicator = false
    
    view.addSubview(weatherTable)
    weatherTable.dataSource = self
    weatherTable.delegate = self
    weatherTable.anchorEdges(top: topView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: wCell) as! WeatherCell
    cell.updateViews(data: data[indexPath.row])
    return cell
  }
}

extension Main {
  func networkCalls(){
    guard let url = URL(string: "http://localhost:3000/data") else {print("failed"); return}
    URLSession.shared.dataTask(with: url) { (data, resp, error) in
      do{
        let decoder = JSONDecoder()
        let data =  try decoder.decode([CellData].self, from: data!)
        self.data = data
        DispatchQueue.main.async {
          self.weatherTable.reloadData()
        }
      }catch{
        print("failed, should handle errors here")
      }
      
      }.resume()
  }
}

struct CellData: Codable {
  var high: Int
  var low: Int
  var condition: String
  var day: String
}
