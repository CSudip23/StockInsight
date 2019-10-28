//
//  StockCell.swift
//  Stock Insight
//
//  Created by Sudip Chitroda on 2019-10-28.
//  Copyright © 2019 Sudip Chitroda. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var symbolCompany: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
}
