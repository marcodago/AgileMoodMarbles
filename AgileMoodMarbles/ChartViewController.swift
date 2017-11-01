//
//  ChartViewController.swift
//  AgileMoodMarbles
//
//  Created by Marco D'Agostino on 30/10/17.
//  Copyright © 2017 Marco D'Agostino. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    var pieChartView: PieChartView!
    
    var marble: [String] = []
    var date: [String] = []
    var jsonArray: [String] = []
    var GREEN: Double = 0.00
    var YELLOW: Double = 0.00
    var RED: Double = 0.00
    var TOTAL: Double = 0.00
    var country = String()
    var dept = String ()
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let firstUse = UserDefaults.standard.object(forKey: "storedcountry")
        
        if firstUse != nil {
            
            self.country = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            self.dept = String( UserDefaults.standard.string(forKey: "storeddept")!)
            
            GetJSONfromCloudantDB ()
            
            let moods = ["Green", "Amber", "Red"]
            let percentage = [GREEN/TOTAL*100.00, YELLOW/TOTAL*100.00, RED/TOTAL*100.00]
            
            pieChartView = PieChartView(frame: self.view.bounds)
            self.view.addSubview(pieChartView!)
            setChart(dataPoints: moods, values: percentage)
        }
        
    }
    
    func GetJSONfromCloudantDB () {
        
        let postEndpoint: String = ("https://0887ad8a-8f0b-4aec-b8fc-bf66958c007a-bluemix:b044033ceb27472f0c349ac201473b760f3e3f1f360d19209f37e860118ff9bd@0887ad8a-8f0b-4aec-b8fc-bf66958c007a-bluemix.cloudant.com/comments/_all_docs?include_docs=true")
        
        let url = NSURL(string: postEndpoint)!
        
        let now = Date()
        let oneMonthAgo = now.addingTimeInterval(-1 * 30 * 24 * 60 * 60) as Date
        
        do {
            let allCommentsData = try Data(contentsOf: url as URL)
            
            
            let jsonArray = try JSONSerialization.jsonObject(with: allCommentsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
            
            if let myjsonArray = jsonArray["rows"] as? [[String: Any]] {
                
                marble = []
                
                if myjsonArray.count > 0 {
                    for index in 0...myjsonArray.count-1 {
                        
                        let record = myjsonArray[index] as [String : AnyObject]
                        
                        if let recordDate = record["doc"]?["date"] as? String {
                            date.append(recordDate)
                            //***************************************************
                            let dateComponents = recordDate.components(separatedBy: "T")
                            let dateOnly = dateComponents[0]
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateFormatter.locale = Locale(identifier: "en_US")
                            let dateOfRecord = dateFormatter.date(from: dateOnly)
                            //***************************************************
                            
                            if dateOfRecord! > oneMonthAgo {
                                
                                if country == record["doc"]?["country"] as? String {
                                    
                                    if dept == record["doc"]?["dept"] as? String {
                                        
                                        let moodmarble = record["doc"]?["mood"]
                                        marble.append(moodmarble as! String)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            for i in 0..<marble.count {
                if marble[i] == "G" {
                    GREEN += 1
                    TOTAL += 1
                }
                if marble[i] == "Y" {
                    YELLOW += 1
                    TOTAL += 1
                }
                if marble[i] == "R" {
                    RED += 1
                    TOTAL += 1
                }
            }
        }
            
        catch {
            
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i])
            dataEntries.append(dataEntry1)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Mood Marbles Segmentation")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        let colorBlack = UIColor.black
        pieChartData.setValueTextColor(colorBlack)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1.0
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        
        for _ in 0..<dataPoints.count {
            
            pieChartDataSet.sliceSpace = 1
            pieChartDataSet.colors = [UIColor.green, UIColor.yellow, UIColor.red]
            
        }
        
        self.pieChartView.data = PieChartData(dataSet: pieChartDataSet)
        
    }
}
