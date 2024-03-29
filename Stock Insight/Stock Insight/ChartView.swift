//
//  ChartView.swift
//  Stock Insight
//
//  Created by Sudip Chitroda on 2019-10-28.
//  Copyright © 2019 Sudip Chitroda. All rights reserved.
//

import UIKit

protocol ChartViewDelegate {

       func didChangeTimeRange(range: ChartTimeRange)
   }

class ChartView: UIView {

    @IBOutlet weak var btnIndicatorView: UIView!
    var delegate: ChartViewDelegate!
    
    class func create() -> ChartView {
        let chartView = UINib(nibName: "ChartView", bundle:nil).instantiate(withOwner: nil, options: nil)[0] as! ChartView
        chartView.btnIndicatorView.layer.cornerRadius = 15
        
        return chartView
    }
    
    @IBAction func timeRangeBtnTapped(sender: AnyObject) {
        
        let btn = sender as! UIButton
       
        btnIndicatorView.center = btn.center

        var range: ChartTimeRange = .OneDay
        
        switch btn.tag {
        case 1:
            range = .OneDay
        case 2:
            range = .FiveDays
        case 3:
            range = .TenDays
        case 4:
            range = .OneMonth
        case 5:
            range = .ThreeMonths
        case 6:
            range = .OneYear
        case 7:
            range = .FiveYears
        default:
            range = .OneDay
        }
        delegate.didChangeTimeRange(range: range)
        
        for view in subviews {
            if view.isMember(of: UIButton.self){
            
                let subBtn = view as! UIButton
                if btn.tag == subBtn.tag {
                    subBtn.setTitleColor(UIColor(red: (127/255), green: (50/255), blue: (198/255), alpha: 1), for: [])
                    subBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
                } else {
                    subBtn.setTitleColor(UIColor.white, for: [])
                    subBtn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
                }
                
            }
        
        }
        
        
        
    }

}
