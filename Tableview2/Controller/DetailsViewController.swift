//
//  DetailsViewController.swift
//  Tableview2
//
//  Created by Batoul Issa on 6/9/20.
//  Copyright © 2020 Batoul Issa. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var zipCodeLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUser()
    }
    
    func fillUser() {
        if let user = user {
            nameLbl.text = user.name
            usernameLbl.text = user.username
            phoneLbl.text = user.phone
            emailLbl.text = user.email
            cityLbl.text = user.address.city
            streetLbl.text = user.address.street
            zipCodeLbl.text = user.address.zipcode
            companyLbl.text = user.company.name
            roleLbl.text = user.company.bs
            
        }
    }
        


}
