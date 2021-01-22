//
//  RootTabBarController.swift
//  SwiftCode
//
//  Created by danxiao on 2019/10/15.
//  Copyright © 2019 lovense. All rights reserved.
//

import Foundation
import UIKit

class RootTabBarController: UITabBarController,UITabBarControllerDelegate
{
    lazy var VCArr = [UINavigationController]()

    override func viewDidLoad()
    {
        self.delegate = self
        self.setupTabar()
        self.setUpAllChildViewController()
    }

    private func setupTabar()
    {

    }

    private func setUpAllChildViewController()
    {
        let homeVC = HomeViewController()
        self.setChildVC(vc: homeVC, title: "首页", imgName: "bp_tabbar_home_up", selImgName: "bp_tabbar_home_down")


        self.viewControllers = self.VCArr
    }

    private func setChildVC(vc:UIViewController,title:String,imgName:String,selImgName:String)
    {
        vc.title = title
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imgName)
        vc.tabBarItem.image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selImgName)
        vc.tabBarItem.selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)

        let nav = UINavigationController(rootViewController: vc)

        self.VCArr.append(nav)

    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {

    }
}
