//
//  TableViewController.swift
//  Stock Insight
//
//  Created by Sudip Chitroda on 2019-10-28.
//  Copyright © 2019 Sudip Chitroda. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: StockCell = Table.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        
        
        cell.symbolLabel.text = searchResults[indexPath.row].symbol
            cell.symbolCompany.text = searchResults[indexPath.row].name
        
            let exchange = searchResults[indexPath.row].exchange!
        
            let assetType = searchResults[indexPath.row].assetType!
            cell.InfoLabel.text = exchange + "  |  " + assetType
        
        return cell
    }
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let length = searchText.count
        
        if length > 0 {
            searchYahooFinanceWithString(searchText: searchText)
        } else {
            searchResults.removeAll()
            Table.reloadData()
        }
        
    }
    
    func searchYahooFinanceWithString(searchText: String) {
        
        StockKit.fetchStocksFromSearchTerm(term: searchText) { (stockInfoArray) -> () in
            
            self.searchResults = stockInfoArray
            self.Table.reloadData()
            
        }
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Table.tableFooterView = UIView()
        Table.dataSource = self
        Table.delegate = self
        Table.register(UINib(nibName: "StockCell", bundle: Bundle.main), forCellReuseIdentifier: "stockCell")
        Table.rowHeight = 60
        SearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var Table: UITableView!
    var searchResults: [StockSearchResult] = []
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let controller: SecondViewController = storyboard!.instantiateViewController(withIdentifier: "secondViewController") as! SecondViewController
        controller.stockSymbol = searchResults[indexPath.row].symbol!
        navigationController?.pushViewController(controller, animated: true)

        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }

}
