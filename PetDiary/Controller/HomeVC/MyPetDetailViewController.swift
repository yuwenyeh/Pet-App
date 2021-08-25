//
//  MyPetDetailViewController.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/23.
//

import UIKit

class MyPetDetailViewController: UITableViewController {
    
    
    let picker = UIImagePickerController()
    var selectedPhoto :UIImage?
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func cameraBtn(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert), name: Notification.Name("ShowAlert"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        return UITableView.automaticDimension
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0,indexPath.row == 1{
            let controller = UIAlertController(title: "姓名", message: "請輸入姓名", preferredStyle: .alert)
            
            
            controller.addTextField { (textField) in
                textField.keyboardType = .default
            }
            let OkAction = UIAlertAction(title: "OK", style: .default) { [unowned controller] _  in
                let text = controller.textFields?[0].text
                self.nameLabel.text = text
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(OkAction)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
        }
        
        
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
                //alert(message: "無鏡頭可使用", title: "Oops!")
                let OK = UIAlertAction.addAction(title: "OK", style: .default, handler: nil)
                UIAlertController.showAlertController(title: "無鏡頭可用", msg: "Oops!", style: .alert, actions: [OK])
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
        
        var selectedImageFromPicker:UIImage?
        if let pickedImage = info[.originalImage] as? UIImage{
            selectedImageFromPicker = pickedImage
            selectedPhoto = selectedImageFromPicker!
            petImage.image = selectedPhoto
            petImage.clipsToBounds = true
            petImage.layer.cornerRadius = 15
            
        }
        
        //產生獨一無二ID方便上傳圖片命名
        let uniqueString = NSUUID().uuidString
        
        // 當判斷有selectedImage時，在 if 判斷式裡將圖片上傳
        if let selectedImage = selectedImageFromPicker {
            print("test\(uniqueString), \(selectedImage)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    // 圖片picker控制器任務結束回呼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
