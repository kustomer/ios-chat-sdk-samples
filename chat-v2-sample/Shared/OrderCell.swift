//
//  OrderCell.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/12/21.
//

import UIKit

protocol OrderCellDelegate: AnyObject {
    func didTapGetHelp(forOrder order: Order)
}

class OrderCell: UITableViewCell {

    var order: Order?

    weak var delegate: OrderCellDelegate?
    
    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!

    func setUp(withOrder order: Order) {
        self.order = order
        idLabel.text = "Order Number \(order.id)"
        descriptionLabel.text = order.description
    }

    @IBAction func didTapGetHelp(_ sender: Any) {
        guard let order = order else {
            assertionFailure("No order associated with cell")
            return
        }
        delegate?.didTapGetHelp(forOrder: order)
    }
}
