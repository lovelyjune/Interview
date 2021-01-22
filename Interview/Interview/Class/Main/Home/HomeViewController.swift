//
//  HomeViewController.swift
//  Interview
//
//  Created by june on 2021/1/22.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController
{

    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad()
    {
        self.initData()
        self.initView()
        self.setupLayout()
        self.requestApi()
    }

    private func initData()
    {

    }

    private func initView()
    {
        self.view.backgroundColor = UIColor.white
        
    }

    private func setupLayout()
    {

    }

    private func requestApi()
    {

    }


}
