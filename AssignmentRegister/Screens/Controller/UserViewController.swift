//
//  UserViewController.swift
//  AssignmentRegister
//
//  Created by Apple on 05/08/24.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = sb.instantiateViewController(withIdentifier: "registerVC")
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
