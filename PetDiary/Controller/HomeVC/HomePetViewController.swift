//
//  HomePetViewController.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/24.
//

import UIKit

class HomePetViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue){
        dismiss(animated: true, completion: nil)
    }



}
