//
//  PettypeViewController.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/24.
//

import UIKit

class PettypeViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
  
    var PetName = ["未選取","狗","貓","倉鼠","雪貂","兔子","小鸚鵡","貓頭鷹","松鼠","烏龜","青蛙","觀賞魚","蜥蜴","其他"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        
    }
    


}
extension PettypeViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PetName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "pettypeCell", for: indexPath)
        cell.textLabel?.text = PetName[indexPath.row]
        return cell
    }
    
    
    
    
    
    
    
    
}
