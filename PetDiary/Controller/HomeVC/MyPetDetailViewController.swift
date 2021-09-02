//
//  MyPetDetailViewController.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/23.
//

import UIKit
import CoreData

class MyPetDetailViewController: UITableViewController {
    
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animareLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var PetDiarys :PetDiaryMO!
    let picker = UIImagePickerController()
   
   
    @IBAction func cameraBtn(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert), name: Notification.Name("ShowAlert"), object: nil)
        
      petData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func petData(){
        
        guard PetDiarys != nil else{return}
        self.nameLabel.text = PetDiarys.name
        self.birthdayLabel.text = PetDiarys.birday
        self.messageLabel.text = PetDiarys.message
        self.animareLabel.text = PetDiarys.type
        
        if let petImages = PetDiarys.image {
            petImage.image = UIImage(data: petImages as Data)

        }
    }

    

    @objc func showAlert(){
        
        let controller = UIAlertController(title: "上傳寵物圖片", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "相機", style: .default) { [self] (_) in
            self.tapCameraBtn()
        }
        let libraryAction = UIAlertAction(title: "相片", style: .default) { (_) in
            self.tapLibraryBtn()
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cameraAction)
        controller.addAction(libraryAction)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 60
        }else{
        return UITableView.automaticDimension
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0,indexPath.row == 1{
            
            let controller = UIAlertController(title: "姓名", message: "請輸入姓名", preferredStyle: .alert)
            controller.addTextField { (textField) in textField.keyboardType = .default}
            let OkAction = UIAlertAction(title: "OK", style: .default) { [unowned controller] _  in
                let text = controller.textFields?[0].text
                self.nameLabel.text = text
            }
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(OkAction)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
        }
        
        if indexPath.section == 1, indexPath.row == 0 {
           let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PettypeVC") as! PettypeViewController
            controller.petnamedelegate = self
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "bir"
        {
            let birtydayVC = segue.destination as! BirtydayViewController
            birtydayVC.birtydelegate = self
        }
        if segue.identifier == "Pet name Segue"{
            let pettypeVC = segue.destination as! PettypeViewController
            pettypeVC.petnamedelegate = self
        }
        
        if segue.identifier == "Pet message" {
            let textfieldVC = segue.destination as! PetTextFieldVC
            textfieldVC.textFieldDelegate = self
            textfieldVC.message = self.messageLabel.text
        }
    }
    

    //完成
    @IBAction func done(_ sender: Any) {
        
        guard self.nameLabel.text != "" || self.birthdayLabel.text != "" || self.animareLabel.text != "" else {
            alert(message: "資料輸入不完全", title: "提醒")
            return
        }
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            PetDiarys = PetDiaryMO(context: appDelegate.persistentContainer.viewContext)
       
        PetDiarys.name = nameLabel.text
        PetDiarys.type = birthdayLabel.text
        PetDiarys.message = messageLabel.text
        
        
        if let PetDiarysImage = petImage.image {
            PetDiarys.image = PetDiarysImage.pngData()
        }
            appDelegate.saveContext()//儲存起來
    }
        dismiss(animated: true, completion: nil)
        
    }
}
 

extension MyPetDetailViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func getPhotoWay(type:Int){
        
        switch type {
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            }else {
                alert(message: "無鏡頭可使用", title: "Oops!")
            }
        default:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    func tapCameraBtn(){
        self.getPhotoWay(type: 1)
    }
    func tapLibraryBtn(){
        self.getPhotoWay(type: 2)
    }
    
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        if let pickedImage = info[.originalImage] as? UIImage{
            
            petImage.clipsToBounds = true
            petImage.image = pickedImage
            petImage.contentMode = .scaleAspectFill
            petImage.layer.cornerRadius = petImage.frame.height/2
            
        }

        dismiss(animated: true, completion: nil)
        
    }
    
}

extension MyPetDetailViewController: PetDelegate,BirtydayDelegate,PetTextFieldDelegate{
    
    func Petdata(PetName: String) {
        
        self.animareLabel.text = PetName
    }
    
    func pettextData(str: String) {
        self.messageLabel.text = str
     
    }
    
    func data(Str: String) {
        self.birthdayLabel.text = Str
      
    }
}
    
    

