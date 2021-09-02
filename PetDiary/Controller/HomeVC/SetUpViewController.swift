//
//  SetUpViewController.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/21.
//

import UIKit

class SetUpViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    
    let names = ["有無廣告","版本：","圖樣選擇"]
    
   
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorColor = .clear
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableview.sectionHeaderHeight = 40
    }
    

    
    
}
extension SetUpViewController:UITableViewDelegate,UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpCell", for: indexPath) as? SetUpCell else{
                return UITableViewCell()
            }
            cell.AddLabel.text = names[indexPath.section]
            return cell
            
        case 1 :
            
            let titlecell = tableView.dequeueReusableCell(withIdentifier: "Version Label" ,for: indexPath) as? TitleLabelCell
            
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
                titlecell!.TitleLabel.text = names[indexPath.section]
                titlecell!.numberLabel.text = "\(version)"
            }
            return titlecell!
            
        default:
            
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "image Cell" , for: indexPath) as? ImageCell else{
                return UITableViewCell()
            }
            imageCell.imageLabel.text = names[indexPath.section]
            
            return imageCell
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            return nil
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.9489377141, green: 0.9451513886, blue: 0.9606701732, alpha: 1)
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.text = "有無廣告"
        lbl.textColor = #colorLiteral(red: 0.4783872962, green: 0.4784596562, blue: 0.4783714414, alpha: 1)
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
