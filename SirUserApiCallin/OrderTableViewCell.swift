//
//  OrderTableViewCell.swift
//  UserApiCall
//
//  Created by R83 on 13/02/23.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var reOrderButton: UIButton!
    @IBOutlet weak var cancelOrderButton: UIButton!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var date_Time: UILabel!
    @IBOutlet weak var orderId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
