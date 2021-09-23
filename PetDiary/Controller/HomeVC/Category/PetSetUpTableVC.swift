//
//  PetSetUpTableVC.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/11.
//

import UIKit

class PetSetUpTableVC: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    

}
