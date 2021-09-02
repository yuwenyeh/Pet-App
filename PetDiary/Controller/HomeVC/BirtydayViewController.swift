//
//  BirtydayViewController.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/26.
//

import UIKit


protocol BirtydayDelegate:AnyObject {
    func data(Str:String)
}


class BirtydayViewController: UIViewController {

   
    @IBOutlet weak var datePicker: UIDatePicker!
 
    var birtydelegate: BirtydayDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }
    
    @IBAction func enterBtn(_ sender: Any) {

        birtydelegate?.data(Str: "\(datePicker.date)")
        
        self.navigationController?.popViewController(animated: true)

    }
    
}
