//
//  NavigationController.swift
//  useCLLocalManager
//
//  Created by Peter on 2018/4/23.
//  Copyright © 2018年 Peter. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(ViewController(), animated: true)
    }
}
