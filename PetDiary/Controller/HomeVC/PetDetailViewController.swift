//
//  PetDetailViewController.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/21.
//

import UIKit

class PetDetailViewController: UIViewController {

    var str:String?
    var titlenames = ["種類","生日","顏色"]
    var selectedPhoto :UIImage?
    @IBOutlet weak var tableview: UITableView!
    
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
       
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableview.sectionHeaderHeight = 40
        
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
}


extension PetDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        
        case 0:
            if indexPath.row == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Pet Image", for: indexPath) as? PetDetailCell else{
                    return UITableViewCell() }
                
                if selectedPhoto != nil {
                    cell.petImage.isHidden = false
                    cell.petImage.image = selectedPhoto
                    cell.petImage.clipsToBounds = true
                    cell.petImage.layer.cornerRadius = 25.25
                }
                
                return cell
            }
            guard let namecell = tableView.dequeueReusableCell(withIdentifier: "Pet Name" ,for: indexPath) as? PetNameCell else {
                return UITableViewCell()
            }
            namecell.petnameLabel.text = "姓名"
            return namecell
            
        case 1:
                guard let namecell = tableView.dequeueReusableCell(withIdentifier: "Pet Name" ,for: indexPath) as? PetNameCell else {
                    return UITableViewCell()
                }
                namecell.petnameLabel.text = titlenames[indexPath.row]
                return namecell
            
       default:
            guard  let namecell = tableView.dequeueReusableCell(withIdentifier: "Pet Name" ,for: indexPath) as? PetNameCell else {
                return UITableViewCell()
            }
            namecell.petnameLabel.text = "注意"
            return namecell
            
     
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
   
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.9489377141, green: 0.9451513886, blue: 0.9606701732, alpha: 1)
        if section == 2 {
            
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.text = "注意事項"
        lbl.textColor = #colorLiteral(red: 0.4783872962, green: 0.4784596562, blue: 0.4783714414, alpha: 1)
        view.addSubview(lbl)
    }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row){
        
        case  (0, 1):
            
            let controller = UIAlertController(title: "姓名", message: "請輸入姓名", preferredStyle: .alert)
            
            
            controller.addTextField { (textField) in
                textField.keyboardType = .default
            }
            let OkAction = UIAlertAction(title: "OK", style: .default) { [unowned controller] _  in
                let text = controller.textFields?[0].text
                self.str = text!
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(OkAction)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
            
            
        default:
        print("testtest")
        } 
    }
}




extension PetDetailViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
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
            
            
        }
        
        //產生獨一無二ID方便上傳圖片命名
        let uniqueString = NSUUID().uuidString
        
        // 當判斷有selectedImage時，在 if 判斷式裡將圖片上傳
        if let selectedImage = selectedImageFromPicker {
            print("test\(uniqueString), \(selectedImage)")
        }
        tableview.reloadData()
        dismiss(animated: true, completion: nil)
    }
    // 圖片picker控制器任務結束回呼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
