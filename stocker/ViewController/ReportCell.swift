//
//  HistoryCell.swift
//  stocker
//
//  Created by Setthasit Poosawat on 23/11/2564 BE.
//

import UIKit

class ReportCell: UITableViewCell {

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
