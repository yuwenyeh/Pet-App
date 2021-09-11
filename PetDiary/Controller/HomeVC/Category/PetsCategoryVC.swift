//
//  PetsCategoryVC.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/11.
//

import UIKit


let PETSCELL = "PetwCategoryCell"
let PETSETUPTABLEVC = "PetSetUpTableVC"
class PetsCategoryVC: UITableViewController {

    let setup = ["體長","散步","日記","醫院"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "設定"
        let nib = UINib(nibName: PETSCELL, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PETSCELL)
        
        let backBtn = UIBarButtonItem(title: "新的", style: .plain, target:self , action: #selector(nextVC))
        self.navigationItem.rightBarButtonItem = backBtn
    }
    
    
    @objc func nextVC() {
     
        let controller = storyboard?.instantiateViewController(identifier: PETSETUPTABLEVC) as! PetSetUpTableVC
        self.present(controller, animated: true, completion: nil)
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return setup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PETSCELL) as! PetwCategoryCell
        cell.setupLabel.text = setup[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }

}
