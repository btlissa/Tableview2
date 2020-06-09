//
//  ViewController.swift
//  Tableview2
//
//  Created by Batoul Issa on 6/7/20.
//  Copyright © 2020 Batoul Issa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var usersTable: UITableView!
  
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableConfig()
        fetchUsers()
    }

    func fetchUsers() {
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
    
    func tableConfig() {
        usersTable.delegate = self
        usersTable.dataSource = self
        
        usersTable.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        usersTable.estimatedRowHeight = 70
        usersTable.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        
        if let indexPath = usersTable.indexPathForSelectedRow {
            destinationVC.user = users[indexPath.row]
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        cell.delegate = self
        cell.usernameLbl.text = users[indexPath.row].username
        cell.nameLbl.text = users[indexPath.row].name
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
}


extension ViewController: CellDelegate {
   
    func companyInfoClicked(username: String) {
        let user = users.first(where: { (user) -> Bool in
            user.username == username
        })!
        
        let alert = UIAlertController(title: NSLocalizedString("Company Info", comment: "Get Information about user's company"), message: user.companyInfo(), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "Close the alert"), style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
