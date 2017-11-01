//
//  TabBarConfigurationViewController.swift
//  AgileMoodMarbles
//
//  Created by Marco D'Agostino on 30/10/17.
//  Copyright © 2017 Marco D'Agostino. All rights reserved.
//

import UIKit

class TabBarConfigurationViewController: UITabBarController {
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.tabBar.barTintColor = .white
      
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      
   }
}
