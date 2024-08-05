//
//  UserViewController.swift
//  AssignmentRegister
//
//  Created by Apple on 05/08/24.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userTblView: UITableView!
    private var users: [UserEntity] = []
    private let manager = DatabaseManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "UserCell", bundle: nil)
        userTblView.register(nib, forCellReuseIdentifier: "UserCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = manager.fetchUsers()
        self.userTblView.reloadData()
    }

    @IBAction func registerBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = sb.instantiateViewController(withIdentifier: "registerVC")
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

extension UserViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        
        cell.user = user
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
