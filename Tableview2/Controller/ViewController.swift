//
//  ViewController.swift
//  Tableview2
//
//  Created by Batoul Issa on 6/7/20.
//  Copyright © 2020 Batoul Issa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellDelegate {

    
    
    @IBOutlet var usersTable: UITableView!
  
    var users = [User]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableConfig()
        fetchUsers()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomCell
        
        cell.delegate = self
        cell.usernameLbl.text = users[indexPath.row].username
        cell.nameLbl.text = users[indexPath.row].name
        
        return cell
        
    }
    
    func companyInfoClicked(username: String) {
        
        let user = users.first(where: { (user) -> Bool in
            user.username == username
        })!
        
        let alert = UIAlertController(title: "Company Info", message: user.getCompanyInfo(), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    

    func fetchUsers(){
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
      
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
       
        let task = session.dataTask(with: url){ (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if let jsonDate = data {
                let decoder = JSONDecoder()
                
                do{
                    self.users = try decoder.decode([User].self, from: jsonDate)
                    
                    DispatchQueue.main.async {
                        self.usersTable.reloadData()
                    }
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
    
    
    func tableConfig(){
        usersTable.delegate = self
        usersTable.dataSource = self
        
        usersTable.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "userCell")
        usersTable.estimatedRowHeight = 70
        usersTable.rowHeight = UITableViewAutomaticDimension
        
    }
}


