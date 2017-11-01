//
//  AppDelegate.swift
//  AgileMoodMarbles
//
//  Created by Marco D'Agostino on 30/10/17.
//  Copyright © 2017 Marco D'Agostino. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let firstUse = UserDefaults.standard.object(forKey: "storedcountry")
        
        if firstUse == nil {
            
            let topWindow = UIWindow(frame: UIScreen.main.bounds)
            topWindow.rootViewController = UIViewController()
            topWindow.windowLevel = UIWindowLevelAlert + 1
            let alert = UIAlertController(title: "Please profile you!", message: "Please in order to use the application, go to the settings page and setup your profile. Thanks!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                
                topWindow.isHidden = true
            }))
            
            topWindow.makeKeyAndVisible()
            topWindow.rootViewController?.present(alert, animated: true, completion: {})
            
            navigateToSettingsViewController()
            
        }
        
        return true
    }
    
    func navigateToSettingsViewController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "NaviVC") as! UITabBarController
        rootVC.selectedIndex = 3
        self.window!.rootViewController = rootVC
        
    }
    
}
