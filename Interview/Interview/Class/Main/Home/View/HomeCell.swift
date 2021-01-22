//
//  HomeCell.swift
//  Interview
//
//  Created by june on 2021/1/22.
//

import UIKit

class HomeCell: UITableViewCell {

    lazy var requestLabel = UILabel()
    lazy var resultLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.initData()
        self.initView()
        self.setupUILayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initData()
    {
        
    }
    
    func initView()
    {
        requestLabel.textColor = .black
        resultLabel.textColor = .black
        
        requestLabel.numberOfLines = 2
        resultLabel.numberOfLines = 0
        
        requestLabel.adjustsFontSizeToFitWidth = true
        resultLabel.adjustsFontSizeToFitWidth = true
        
        self.contentView.addSubview(requestLabel)
        self.contentView.addSubview(resultLabel)
    }
    
    func setupUILayout()
    {
        requestLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(60)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func updateModel(model:NetModel)
    {
        requestLabel.text = "请求url=\(model.requestUrl ?? "") 请求方式=\(model.method ?? "")\n请求时间=\(model.requestTime ?? "")"
        resultLabel.text = "请求返回=\(model.result ?? "")"
    }
    
    func updateLabelRed()
    {
        requestLabel.textColor = .red
        resultLabel.textColor = .red
    }
    
    func resetLabel()
    {
        requestLabel.textColor = .black
        resultLabel.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
