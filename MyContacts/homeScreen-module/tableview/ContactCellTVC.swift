//
//  ContactCellTVC.swift
//  MyContacts
//
//  Created by halil dikişli on 18.01.2023.
//

import UIKit

class ContactCellTVC: UITableViewCell {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
