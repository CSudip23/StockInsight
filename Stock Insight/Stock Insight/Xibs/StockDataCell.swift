//
//  StockDataCell.swift
//  Stock Insight
//
//  Created by Sudip Chitroda on 2019-10-28.
//  Copyright © 2019 Sudip Chitroda. All rights reserved.
//

import UIKit

class StockDataCell: UICollectionViewCell {
    
    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var fieldValue: UILabel!
    
    func setData(data: [String : String]) {
        fieldName.text = data.keys.first
        fieldValue.text = data.values.first

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
