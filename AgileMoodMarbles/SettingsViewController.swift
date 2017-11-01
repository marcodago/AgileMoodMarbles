//
//  SettingsViewController.swift
//  AgileMoodMarbles
//
//  Created by Marco D'Agostino on 30/10/17.
//  Copyright © 2017 Marco D'Agostino. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate {
    
    @IBOutlet var country: UITextField!
    @IBOutlet var dept: UITextField!
    
    @IBOutlet weak var mybutton: UIButton!
    @IBAction func saveSettings(_ sender: Any) {
        
        UserDefaults.standard.set(country.text!, forKey: "storedcountry")
        UserDefaults.standard.set(dept.text!, forKey: "storeddept")
        UserDefaults.standard.synchronize()
        
        let alertController = UIAlertController(title: "Thanks", message: "Your profile has been completed.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.string(forKey: "storedcountry") != nil {

            country.text! = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            dept.text! = String( UserDefaults.standard.string(forKey: "storeddept")!)
        
            country.delegate = self
            dept.delegate = self
         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.string(forKey: "storedcountry") != nil {
            
            country.text! = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            dept.text! = String( UserDefaults.standard.string(forKey: "storeddept")!)
            
            country.delegate = self
            dept.delegate = self
        }
    }
    
    // Funzione per far "sparire" la tastiera se utente clicca su un punto dela view diverso da textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
