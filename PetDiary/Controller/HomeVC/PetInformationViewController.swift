//
//  PetInformationViewController.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/21.
//

import UIKit


class PetInformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
  
    @IBAction func unwindToHome(segue:UIStoryboardSegue){
        dismiss(animated: true, completion: nil)
    }
}
