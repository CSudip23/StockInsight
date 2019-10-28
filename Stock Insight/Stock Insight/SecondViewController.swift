//
//  ViewController.swift
//  Stock Insight
//
//  Created by Sudip Chitroda on 2019-10-28.
//  Copyright © 2019 Sudip Chitroda. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ChartViewDelegate{
    func didChangeTimeRange(range: ChartTimeRange) {
        loadChartWithRange(range: range)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 17 ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : StockDataCell = collectionView.dequeueReusableCell(withReuseIdentifier: "stockDataCell", for: indexPath) as! StockDataCell
        
        cell.setData(data: stock!.dataFields[(indexPath.section * 2) + indexPath.row])
        
        return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var stockSymbol: String = String()
    var stock: Stock!
    var chartView: ChartView!
    var chart: SwiftStockChart!
    
    func loadChartWithRange(range: ChartTimeRange) {
    
        chart.timeRange = range
        
        let times = chart.timeLabelsForTimeFrame(range: range)
        chart.horizontalGridStep = times.count - 1
        
        chart.labelForIndex = {(index: NSInteger) -> String in
            return times[index]
        }
        
        chart.labelForValue = {( CGFloat) -> String in
            return String(format: "%.02f")
        }
        
        // *** Here's the important bit *** //
        StockKit.fetchChartPoints(symbol: stockSymbol, range: range) { (chartPoints) -> () in
            self.chart.clearChartData()
            self.chart.setChartPoints(points: chartPoints)
        }
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = stockSymbol
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "StockDataCell", bundle: Bundle.main), forCellWithReuseIdentifier: "stockDataCell")
        automaticallyAdjustsScrollViewInsets = false
        
        chartView = ChartView.create()
        chartView.delegate = self
        chartView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(chartView)
        
        collectionView.addConstraint(NSLayoutConstraint(item: chartView, attribute: .height, relatedBy: .equal, toItem:collectionView, attribute: .height, multiplier: 1.0, constant: -(collectionView.bounds.size.height - 230)))
        collectionView.addConstraint(NSLayoutConstraint(item: chartView, attribute: .width, relatedBy: .equal, toItem:collectionView, attribute: .width, multiplier: 1.0, constant: 0))
        collectionView.addConstraint(NSLayoutConstraint(item: chartView, attribute: .top, relatedBy: .equal, toItem:collectionView, attribute: .top, multiplier: 1.0, constant: -250))
        collectionView.addConstraint(NSLayoutConstraint(item: chartView, attribute: .left, relatedBy: .equal, toItem:collectionView, attribute: .left, multiplier: 1.0, constant: 0))
        collectionView.contentInset = UIEdgeInsets(top: 250, left: 0, bottom: 0, right: 0)

        
        chart = SwiftStockChart(frame: CGRect(x: 10, y: 10, width: chartView.frame.size.width - 20, height: chartView.frame.size.height - 50))
        chart.fillColor = UIColor.clear
        chart.verticalGridStep = 3
        chartView.addSubview(chart)
        loadChartWithRange(range: .OneDay)

        
        // *** Here's the important bit *** //
        StockKit.fetchStockForSymbol(symbol: stockSymbol) { (stock) -> () in
            self.stock! = stock
            self.collectionView.reloadData()
        }
    }


}

