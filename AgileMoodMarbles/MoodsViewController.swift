//
//  MoodsViewController.swift
//  AgileMoodMarbles
//
//  Created by Marco D'Agostino on 30/10/17.
//  Copyright © 2017 Marco D'Agostino. All rights reserved.
//

import UIKit

class MoodsViewController: UIViewController {
    
    var country = String()
    var dept = String()
    var nickname = String()
    
    @IBOutlet var buttonGreen: UIButton!
    @IBAction func buttonGreenpressed(_ sender: UIButton) {
        
        alertPanel(iconValue: "G")
    }
   
    @IBOutlet var buttonYellow: UIButton!
    @IBAction func buttonYellowpressed(_ sender: UIButton) {
        
        alertPanel(iconValue: "Y")
    }
   
    @IBOutlet var buttonRed: UIButton!
    @IBAction func buttonRedpressed(_ sender: UIButton) {
        
        alertPanel(iconValue: "R")
    }
    
    func alertPanel (iconValue: String) {
      
        let alertController = UIAlertController(title: "Feedback", message: "Many thanks for your evaluation. Would you also add a comment?", preferredStyle: .alert)
    
        let actionYes = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            self.leaveComment(iconValue: iconValue)
            print("Perfect! Leave your comment");
        }
        
        let actionNo = UIAlertAction(title: "No", style: .default) { (UIAlertAction) in
            print("Thanks for your evaluation");
        }
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        self.present(alertController, animated: true, completion:nil)
        
    }
   
    func leaveComment (iconValue: String) {
        
        let alertController = UIAlertController(title: "Evaluation", message: "Please enter your feedback:", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Submit", style: .default, handler: {
            
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField!
            let secondTextField = alertController.textFields![0] as UITextField!
            
            var allComments: [String] = []
            var allIconsComments: [String] = []
            
            allComments.append((firstTextField!.text!))
            
            let comment = firstTextField?.text
            
            if iconValue == "G" {
                secondTextField!.text = "G"
            }
            if iconValue == "Y" {
                secondTextField!.text = "Y"
            }
            if iconValue == "R" {
                secondTextField!.text = "R"
            }
            allIconsComments.append((secondTextField?.text!)!)
            
            self.country = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            self.dept = String( UserDefaults.standard.string(forKey: "storeddept")!)
            
            let payload = "&country=\(self.country)&dept=\(self.dept)&mood=\(iconValue)&comment=\(comment!)"
            
            self.LoadJSONtoCloudantDB(payload: payload)
            
            print("comment:\(String(describing: firstTextField?.text))")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter comment"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
                
    }
    
    func LoadJSONtoCloudantDB(payload:String) {
        
        let signature = "mdago_v01_iOS"
        let tipo = "thinkdesk_comments"
        
        let keyValues = "signature=\(signature)&type=\(tipo)" + payload
        
        let url:URL = URL(string: "https://thinkdeskmoods.mybluemix.net/moods")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url as URL)
        
        request.httpMethod = "POST"
      
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = keyValues
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let _:Data = data as Data?, let _:URLResponse = response  , error == nil else {
                
                print("error")
                return
            }
            
            let dataString = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            print(dataString!)
            
        }
        
        task.resume()
        
    }    
    
}

