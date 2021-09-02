//
//  PetTextFieldVC.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/24.
//

import UIKit

protocol PetTextFieldDelegate: AnyObject {
    
    func pettextData(str:String)
}

class PetTextFieldVC: UIViewController{

    var textFieldDelegate:PetTextFieldDelegate?
    
    var message :String?
    
    @IBOutlet weak var textView: UITextView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.text = message
        
        
    }
    

    @IBAction func done(_ sender: UIBarButtonItem) {
        
        textFieldDelegate?.pettextData(str: self.textView.text)
        self.navigationController?.popViewController(animated: true)
        
    }
}
