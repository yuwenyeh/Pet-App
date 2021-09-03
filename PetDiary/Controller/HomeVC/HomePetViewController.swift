//
//  HomePetViewController.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/24.
//

import UIKit
import CoreData

class HomePetViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    var petDiarys :[PetDiaryMO] = []
    var fetchResultController : NSFetchedResultsController<PetDiaryMO>!

    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var DetailCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
 
        let fetchRequerst : NSFetchRequest<PetDiaryMO> = PetDiaryMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequerst.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequerst, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    petDiarys = fetchedObjects
                }
            }catch{
                print(error)
            }
        }
       addtableview()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationController?.hidesBarsOnSwipe = true
    }
    
    
    
    @IBAction func addPetData(_ sender: Any) {
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    

    func addtableview(){
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
         //去除尾部多余的空行
        self.tableView.tableFooterView = UIView(frame:CGRect.zero)
         //设置分区头部字体颜色和大小
         UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
             .textColor = UIColor.gray
         UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
             .font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.medium)
    }
    
    //MARK: -Table view delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { ( action, sourceView, completionHandler)  in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                appDelegate.saveContext()
            }
            completionHandler(true)
        }
        
        // Customize the color
        deleteAction.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 6/255, alpha: 0.5)
        deleteAction.image = UIImage(systemName: "trash")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return petDiarys.count
        }else{
            return 2
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        //只有第二个分区是动态的，其它默认
        if indexPath.section == 1{
            
            //用重用的方式获取标识为wifiCell的cell
           var cell = tableView.dequeueReusableCell(withIdentifier: "wifiCell")
            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "wifiCell")
            }
           
            cell?.textLabel?.text = petDiarys[indexPath.row].name
            cell?.detailTextLabel?.text = petDiarys[indexPath.row].birday
            if let petDiaryImage = petDiarys[indexPath.row].image {
                cell?.imageView?.image = UIImage(data: petDiaryImage as Data)
            }
            return cell!
            
        }else{
            return super.tableView(tableView,cellForRowAt: indexPath)
        }
    }
    
    //點擊動態Cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PetsDataDetailVC") as! PetsDataDetailViewController
            controller.petDiarys = petDiarys[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        
    }
    
    
    //因为第二个分区单元格动态添加，会引起cell高度的变化，所以要重新设置
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 100
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    
    //当覆盖了静态的cell数据源方法时需要提供一个代理方法。
    //因为数据源对新加进来的cell一无所知，所以要使用这个代理方法
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        if indexPath.section == 1{
            //当执行到日期选择器所在的indexPath就创建一个indexPath然后强插
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        }else{
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func unwindToEditEvent(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
  
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        print("indexPath = ",indexPath as Any)
        print("newIndexPath = ",newIndexPath as Any)
        
        switch type {
        case .insert:
            let index = IndexPath(row: 0, section: 1)
                tableView.insertRows(at: [index], with: .fade)
      
        case .delete:
            if let indexPath = indexPath {
               
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fatchedObjects = controller.fetchedObjects {
            petDiarys = fatchedObjects as! [PetDiaryMO]
        }
    
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
