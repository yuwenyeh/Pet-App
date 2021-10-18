//
//  HomePetViewController.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/24.
//

import UIKit
import CoreData
import GoogleMobileAds



let PETSDATADETAILVC = "PetsDataDetailVC"
let cellResuIndextifier = "HomesCell"

class HomePetViewController: UITableViewController,NSFetchedResultsControllerDelegate{
    
    var bannerView :GADBannerView!
    var petDiarys :[PetDiaryMO] = []
   
    let homecounter: HomCounter = HomCounter()
    @IBOutlet weak var onSegmentControl: UISegmentedControl!
    var fetchResultController : NSFetchedResultsController<PetDiaryMO>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults.standard.dictionaryRepresentation())
        print(NSHomeDirectory())
        
        //廣告view要先擺上面
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"//測試apple ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        //在畫view
        let nib = UINib(nibName: cellResuIndextifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellResuIndextifier)
        self.tableView.alwaysBounceVertical = true
        self.tableView.bounces = false//靜止彈跳
        appdelegate()
        addtableview()
        
 
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
       bannerView.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(bannerView)
       view.addConstraints(
         [NSLayoutConstraint(item: bannerView,
                             attribute: .bottom,
                             relatedBy: .equal,
                             toItem: bottomLayoutGuide,
                             attribute: .top,
                             multiplier: 1,
                             constant: 0),
          NSLayoutConstraint(item: bannerView,
                             attribute: .centerX,
                             relatedBy: .equal,
                             toItem: view,
                             attribute: .centerX,
                             multiplier: 1,
                             constant: 0)
         ])
      }
    
    func appdelegate(){
        
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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellResuIndextifier) as? HomesCell
            
            cell?.delegate = self
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
    

    
    //點擊動態Cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 0 {
            
        }
        
        if indexPath == [0,0] {
           
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
             let controller = storyboard.instantiateViewController(withIdentifier: "PetsCategoryVC") as! PetsCategoryVC
           self.navigationController?.show(controller, sender: true)
   
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    
    @IBAction func addPetData(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func unwindToEditEvent(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            let index = IndexPath(row:newIndexPath!.row, section: 1)
            tableView.insertRows(at: [index], with: .fade)
            
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
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    @IBAction func onChange(_ sender: UISegmentedControl) {
        
        if let btntitle = sender.titleForSegment(at: sender.selectedSegmentIndex){
            homecounter.homeCounter(str: btntitle)
        }
    }
}



extension HomePetViewController: MyTableviewCellDelegate {
    func didTapMyBtn(sender: HomesCell) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let indexPath = self.tableView.indexPath(for: sender) else {return }
        let controller = storyboard.instantiateViewController(withIdentifier: PETSDATADETAILVC) as! PetsDataDetailViewController
        controller.petDiarys = petDiarys[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomePetViewController: GADBannerViewDelegate {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return bannerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 1
//        }else{
            return bannerView.frame.height
       // }
       
    }
    
    
    //接收到廣告之後才將橫幅廣告添加到視圖層次結構
     func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
    }
     
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        
        let translateTransform = CGAffineTransform(translationX: 0, y: +bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }

    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("Fail to receive ads")
        print(error)
    }
    
    
    //以下是廣告條件
  
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }


}
