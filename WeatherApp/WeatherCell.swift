import UIKit


class WeatherCell: UITableViewCell {
  let conditionImg: UIImageView = {
    let iv = UIImageView()
//    iv.image = #imageLiteral(resourceName: "Clouds Mini")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let dayLabel: UILabel = {
    let l = UILabel()
//    l.text = "Wednesday"
    return l
  }()
  
  let conditionLabel: UILabel = {
    let l = UILabel()
//    l.text = "Hot"
    return l
  }()
  
  let highDegreeLabel: UILabel = {
    let l = UILabel()
//    l.text = "28°"
    return l
  }()
  
  let lowDegreeLabel: UILabel = {
    let l = UILabel()
//    l.text = "28°"
    return l
  }()
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layoutMargins = .zero
    separatorInset = .zero 
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupViews(){
    addSubview(conditionImg)
    addSubview(dayLabel)
    addSubview(conditionLabel)
    addSubview(highDegreeLabel)
    addSubview(lowDegreeLabel)
    
    
    conditionImg.anchorWHC(width: 70, height: 70)
    conditionImg.anchorEdges(top: topAnchor, tConst: 15, left: leftAnchor, lConst: 10, right: nil, rConst: 0, bottom: nil, bConst: 0)
    
    
    dayLabel.anchorEdges(top: conditionImg.topAnchor, tConst: 10, left: conditionImg.rightAnchor, lConst: 15, right: nil, rConst: 0, bottom: nil, bConst: 0)
    conditionLabel.anchorEdges(top: dayLabel.bottomAnchor, tConst: 8, left: dayLabel.leftAnchor, lConst: 0, right: nil, rConst: 0, bottom: nil, bConst: 0)
    
    highDegreeLabel.anchorEdges(top: dayLabel.topAnchor, tConst: 0, left: nil, lConst: 0, right: rightAnchor, rConst: -16, bottom: nil, bConst: 0)
    lowDegreeLabel.anchorEdges(top: conditionLabel.topAnchor, tConst: 0, left: nil, lConst: 0, right: rightAnchor, rConst: -16, bottom: nil, bConst: 0)

  }
  
  func updateViews(data: CellData){
    conditionLabel.text = data.condition
    dayLabel.text = data.day
    highDegreeLabel.text = String(data.high)
    lowDegreeLabel.text  = String(data.low)
    
    // either name image to match condition or do a lookup table or
    // like here do a long if else to check for all possible cases.
    if (data.condition.lowercased() == "cloudy") {
      conditionImg.image = #imageLiteral(resourceName: "Clouds Mini")
    }
    
  }
  
}

























