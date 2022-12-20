//
//  InventoryCell.swift
//  stocker
//
//  Created by Setthasit Poosawat on 14/11/2564 BE.
//

import UIKit

class InventoryCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
