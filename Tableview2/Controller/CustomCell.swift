//
//  CustomCellTableViewCell.swift
//  Tableview2
//
//  Created by Batoul Issa on 6/8/20.
//  Copyright © 2020 Batoul Issa. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func companyInfoClicked(username:String)
}

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func companyInfoButtom(_ sender: UIButton) {
      
        delegate?.companyInfoClicked(username: usernameLbl.text!)
    
    }
    
}
