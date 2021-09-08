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
    let cellResuIndextifier = "HomesCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: cellResuIndextifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellResuIndextifier)
        
        
        let fetchRequerst : NSFetchRequest<PetDiaryMO> = PetDiaryMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequerst.sortDescriptors = [sortDescriptor]
        
        //建立讀取請求
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
    
    
    
    
    @IBAction func addPetData(_ sender: Any) {
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    
    func addtableview(){
        
        //去除尾部多余的空行
        self.tableView.tableFooterView = UIView(frame:CGRect.zero)
        //设置分区头部字体颜色和大小
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .textColor = UIColor.gray
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .font = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.medium)
    }
    
    
    //MARK: -Table view delegate
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { ( action, sourceView, completionHandler)  in
//
//            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//                let context = appDelegate.persistentContainer.viewContext
//                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
//                context.delete(restaurantToDelete)
//                appDelegate.saveContext()
//            }
//            completionHandler(true)
//        }
//
//        // Customize the color
//        deleteAction.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 6/255, alpha: 0.5)
//        deleteAction.image = UIImage(systemName: "trash")
//
//        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
//        return swipeConfiguration
//
//    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellResuIndextifier) as? HomesCell
            cell?.nameLabel.text = petDiarys[indexPath.row].name
            cell?.birLabel.text = petDiarys[indexPath.row].birday
            cell?.messageLabel.text = petDiarys[indexPath.row].message
            if let petDiaryImage = petDiarys[indexPath.row].image {
                cell?.HomeImage.image = UIImage(data: petDiaryImage as Data)
            }
            return cell!
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return petDiarys.count //這裡返回第二組的行數
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
        
    }
    
    
    //当覆盖了静态的cell数据源方法时需要提供一个代理方法。
    //因为数据源对新加进来的cell一无所知，所以要使用这个代理方法
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        if indexPath.section == 1 {
            
            return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 0, section: 1))
        }
        
        return super.tableView(tableView, indentationLevelForRowAt: indexPath)
    }
    
    
    //因为第二个分区单元格动态添加，会引起cell高度的变化，所以要重新设置
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            return 100
        }
        
        return 44
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
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
        
        
        switch type {
        case .insert:
            let index = IndexPath(row:newIndexPath!.row, section: 1)
            tableView.insertRows(at: [index], with: .fade)
            
        case .delete:
          let index =  IndexPath(row: indexPath!.row, section: 1)
            tableView.deleteRows(at: [index], with: .fade)
    
        case .update:
            
            let index = IndexPath(row: indexPath!.row, section: 1)
           
                tableView.reloadRows(at: [index], with: .fade)
            
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
