//
//  RecordViewController.swift
//  PetDiary
//
//  Created by 葉育彣 on 2021/8/26.
//

import UIKit
import FSCalendar

extension Date {
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -0), to: self.startOfMonth())!
    }
}

class RecordViewController: UIViewController, FSCalendarDataSource , FSCalendarDelegate{

     
    @IBOutlet weak var calender: FSCalendar!{
        didSet{
           
            self.calender.delegate = self
            self.calender.dataSource = self
        }
    }
    
    var currentDateData :[String] = []
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.dataSource = self
            tableview.delegate = self
        }
    }
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = { [unowned self] in
        
        //解釋平移手勢的離散手勢識別器。
        let panGesture = UIPanGestureRecognizer(
            target: self.calender,
            action: #selector(self.calender.handleScopeGesture(_:))
        )
        
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    lazy var formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setCalendar() {
        
         // 上滑月曆變週曆
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableview.panGestureRecognizer.require(toFail: self.scopeGesture)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCalendar()
    }

}

extension RecordViewController{
    
    // 月曆-週曆
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()//如果需要，重新計算接收器的佈局。
    }
    
    //點選日期
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //selectedDate = date
    }
}

extension RecordViewController {
    
}

extension RecordViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}

extension RecordViewController :UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        return  UITableViewCell()
    }
    
    
    
    
}
