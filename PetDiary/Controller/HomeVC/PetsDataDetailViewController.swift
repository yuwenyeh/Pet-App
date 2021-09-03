//
//  PetsDataDetailViewController.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/2.
//

import UIKit

class PetsDataDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    @IBOutlet weak var headerView: PetDetailHeaderView!
    
    @IBOutlet weak var tableview: UITableView!
    var petDiarys : PetDiaryMO!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.hidesBarsOnSwipe = false

        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        tableview.contentInsetAdjustmentBehavior = .never
        
        headerView.nameLabel.text = petDiarys.name
        headerView.typeLabel.text = petDiarys.type
        headerView.headerImageView.image = UIImage(data: petDiarys.image! as Data)
       
 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:PetsDataDetailCell.self), for: indexPath) as! PetsDataDetailCell
            cell.iconImageView.image = UIImage(named: "dogFootprints")?.withTintColor(#colorLiteral(red: 0.6156309247, green: 0.6157218814, blue: 0.6156109571, alpha: 1), renderingMode: .alwaysOriginal)
            return cell
        case 1 :
            
            print("")
        case 2 :
            print("")
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        
        
        }
        
        
        
        
        return UITableViewCell()
    }

}
