//
//  AppDelegate.swift
//  AgileMoodMarbles
//
//  Created by Marco D'Agostino on 17/11/2019.
//  Copyright © 2019 Marco D'Agostino. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let firstUse = UserDefaults.standard.object(forKey: "storedcountry")
        
        if firstUse == nil {
            
            let topWindow = UIWindow(frame: UIScreen.main.bounds)
            topWindow.rootViewController = UIViewController()
            topWindow.windowLevel = UIWindow.Level.alert + 1
            let alert = UIAlertController(title: "Profile is needed!", message: "To use this application, go to the settings page and setup your profile. Thanks!", preferredStyle: .alert)
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
