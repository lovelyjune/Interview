//
//  HomeViewController.swift
//  Interview
//
//  Created by june on 2021/1/22.
//

import Foundation
import UIKit
import SnapKit
import Toast_Swift

class HomeViewController: UIViewController
{
    private lazy var clearBtn = UIButton(type: .custom) //清空按钮
    private lazy var toNewestBtn = UIButton(type: .custom)  //到最新的按钮

    private lazy var mainTableView = UITableView()
    private var allModelArr = [NetModel]()
    private var requestTimer: Timer?   //5秒一次

    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad()
    {
        self.initData()
        self.initView()
        self.setupLayout()
    }

    private func initData()
    {
        //获取旧数据
        allModelArr = NetModel.getLocalModelArr()
        self.mainTableView.reloadData()
        
        //启动5秒后请求接口 之后循环每隔5秒都要调用一次。
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            if let self = self
            {
                self.requestApi()
                self.initTime()
            }
        }
    }

    //初始化界面
    private func initView()
    {
        clearBtn.setTitle("clear all", for: .normal)
        clearBtn.backgroundColor = .darkGray
        clearBtn.setTitleColor(.white, for: .normal)
        clearBtn.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        
        toNewestBtn.setTitle("to newest", for: .normal)
        toNewestBtn.backgroundColor = .darkGray
        toNewestBtn.setTitleColor(.white, for: .normal)
        toNewestBtn.addTarget(self, action: #selector(toNewAction), for: .touchUpInside)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainTableView)
        self.view.addSubview(clearBtn)
        self.view.addSubview(toNewestBtn)
    }

    //约束
    private func setupLayout()
    {
        clearBtn.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        toNewestBtn.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        mainTableView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.right.bottom.equalToSuperview()
        }
    }

    //初始化定时器
    private func initTime()
    {
        self.requestTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] (_) in
            guard let self = self else { return }
            self.requestApi()   //5秒调用一次接口
        })
        if let requestTimer = requestTimer
        {
            RunLoop.main.add(requestTimer, forMode: RunLoop.Mode.common)
        }
    }

    //清空所有数据
    @objc private func clearAction()
    {
        NetModel.removeLocalModelArr()
        allModelArr.removeAll()
        mainTableView.reloadData()
    }
    
    //到最新的那条
    @objc private func toNewAction()
    {
        self.allModelArr = NetModel.getLocalModelArr()
        mainTableView.reloadData()
        if allModelArr.count > 0
        {
            mainTableView.scrollToRow(at: IndexPath(row: allModelArr.count-1, section: 0), at: .none, animated: true)
        }
    }
    
    //调用接口
    private func requestApi()
    {
        let netModel = NetModel()
        netModel.modelId = UUID().uuidString
        netModel.requestUrl = "https://api.github.com"
        netModel.method = "GET"
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss SSSS"
        netModel.requestTime = dateFormatter.string(from: Date())

        guard let requestUrl = netModel.requestUrl else {
            return
        }
        
        ApiRequestManager.shared.GetRequest(url: requestUrl, parameterDict: nil) { [weak self] (responseDict) in
            
            guard let self = self else { return }

            netModel.result = responseDict?.debugDescription
            
            //保存在本地
            var oldModelArr = NetModel.getLocalModelArr()
            oldModelArr.append(netModel)
            NetModel.createSaveAllModelArr(modelArr: oldModelArr)
            
            self.view.makeToast("有新的请求成功")
            
            //界面没有数据的时候刷新表格，有数据的话就吐司提示
            if self.allModelArr.count == 0
            {
                self.allModelArr = oldModelArr
                self.mainTableView.reloadData()
            }
            
        } failure: { (error) in
            
        }
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allModelArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:HomeCell? = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell

        if cell == nil
        {
            cell = HomeCell(style: .default, reuseIdentifier: "HomeCell")
            cell?.selectionStyle = .none
        }
        
        //恢复字体
        cell?.resetLabel()
        
        let netModel = allModelArr[indexPath.row]
        cell?.updateModel(model: netModel)
        
        if indexPath.row == allModelArr.count - 1
        {
            //最新那条红色字体标记不一样
            cell?.updateLabelRed()
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}

