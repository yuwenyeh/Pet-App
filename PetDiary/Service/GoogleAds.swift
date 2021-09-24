//
//  GoogleAds.swift
//  PetDiary
//
//  Created by etrovision on 2021/9/24.
//

import Foundation
import GoogleMobileAds
import UIKit

struct  GoogleAds{
    
    static let sharedInstance = GoogleAds()
   
    static var view: GADBannerView!
    
    
    func addBannerViewToView()->GADBannerView! {
        //廣告view要先擺上面
        GoogleAds.view = GADBannerView(adSize: kGADAdSizeBanner)
//        GoogleAds.view.adUnitID = "ca-app-pub-3940256099942544/2934735716"//測試apple ID
        
        GoogleAds.view.translatesAutoresizingMaskIntoConstraints = false
     
        
        GoogleAds.view.addConstraints(
            [NSLayoutConstraint(item: GoogleAds.view!,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: GoogleAds.view,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
             NSLayoutConstraint(item: GoogleAds.view!,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: GoogleAds.view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
        return GoogleAds.view
    }
    
}
