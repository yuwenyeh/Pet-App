//
//  MapViewController.swift
//  PetDiary
//
//  Created by etrovision on 2021/8/25.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var MapView: MKMapView! {
        didSet{
            MapView.delegate = self
        }
    }
    
    private lazy var geoCoder:CLGeocoder = {
        return CLGeocoder()
    }()
    
    var myLocationMgr:CLLocationManager!

    
    var mamager = GetDataManager()
    
    var vetPlacemarkInfo :[VetPlacemarkData] = []
    
    var placemarks : [CLPlacemark]?
    
    var vetData : [VetData] = [] {
        
        didSet{
            if vetData.isEmpty{
                return
            }else{
                DispatchQueue.main.async {
                    self.getPlacemarker()
                }
            }
        }
    }
    
    var vetLatitude: Double = 0.0
    var vetLongitude: Double = 0.0
    
    var touchedVet = ""
    
    var currentPlaceMarker: CLPlacemark?
    
    
    //傳值
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupLocation()
        
        setupMap()
        
        downloadVetData()
        
        getVetData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationAuth()
        
      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myLocationMgr.startUpdatingLocation()
    }
    
    func setupLocation (){
        // 建立一個 CLLocationManager
        myLocationMgr = CLLocationManager()
        
        // 設置委任對象
        myLocationMgr.delegate = self
        
        //當使用者移動多少距離後會更新座標點。
        myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters
        
        // 取得自身定位位置的精確度
        myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func getVetData(){
        
        mamager.getData(urlString: "https://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=078&$top=27&$skip=1600") { [weak self] result in
            switch result {
            
                case .success(let vetData):
                    
                    self?.vetData = vetData
                    
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func getPlacemarker(){
        
        for index in 0 ..< self.vetData.count{
            
            //修剪字符的功能
            let withoutWhitespace = self.vetData[index].vetAddress.trimmingCharacters(in: .whitespaces)
            
            mamager.getVetPlacemark(addressStr: withoutWhitespace) { [weak self] result in
                
                guard let stringSelf = self else{
                    return
                }
                
                switch result {
                
                case .success(let vetPlacemarks):
                    
                    stringSelf.vetPlacemarkInfo.append(vetPlacemarks)
                    
                    if index == stringSelf.vetData.count - 1 {
                        print("資料ＯＫ")
                        stringSelf.toFireBase()
                      
                    }
                case .failure(let error):
                    print(error)
                
                
                }
            }
            
        }
        
    }
    
    
    func downloadVetData() {
        
        DownloadManager.shared.downloadVetPlacemark { [weak self] result in
            
            switch result {
            
            case .success(_):
                self?.setUpPin()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func toFireBase(){
        
        for index in 0 ..< vetPlacemarkInfo.count{
            
            if vetPlacemarkInfo[index].results.count == 0 {
                continue
                
            } else {
               
                UploadManager.shared.uploadVet(vetName: vetData[index].vetName, vetPhone: vetData[index].vetPhone, vetAddress: vetData[index].vetAddress, vetLatitude: vetPlacemarkInfo[index].results[0].geometry.location.lat
                                               , vetLongitude: vetPlacemarkInfo[index].results[0].geometry.location.lng) { result in
                    
                    switch result {
                    
                    case .success(let uploadVetData):
                        print("To Firstbase Success")
                        print(uploadVetData)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    
    
    func setupMap(){
        MapView.mapType = .standard
        MapView.showsUserLocation = true
        MapView.isZoomEnabled = true
        //self.view.addSubview(MapView)
    }
    
    
    func locationAuth(){
        
        //先取得定位
        switch CLLocationManager.authorizationStatus(){
        
        case.notDetermined:
            myLocationMgr.requestWhenInUseAuthorization()
            fallthrough
            
        case .authorizedWhenInUse:
            myLocationMgr.startUpdatingLocation()
            
        case .denied:
            let alertController = UIAlertController(title: "定位權限已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            
            alertController.addAction(OkAction)
            self.present(alertController, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    
    @IBAction func myLocation(_ sender: UIButton) {
        let location = MapView.userLocation
    
        let userLocation_latitude = MapView.userLocation.location?.coordinate.latitude
        let userLocation_longitude = MapView.userLocation.location?.coordinate.longitude
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: userLocation_latitude!, longitudinalMeters: userLocation_longitude!)
        MapView.setRegion(region, animated: true)
   
    }
    
    func setUpPin() {
        
        //建立一個地點圖示
        let vetPlacemark = DownloadManager.shared.vetPlacemark
        
        for count in 0 ..< vetPlacemark.count{
            
            let objectAnnotation = MKPointAnnotation()
            
            objectAnnotation.coordinate = CLLocationCoordinate2D(latitude: vetPlacemark[count].vetLatitude, longitude: vetPlacemark[count].vetLongitude)
            
            objectAnnotation.title = "\(vetPlacemark[count].vetName)(\(vetPlacemark[count].vetPhone)"
            objectAnnotation.subtitle = vetPlacemark[count].vetAddress
            
            MapView.addAnnotation(objectAnnotation)
        }
    }
 
    
}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //印出目前所在地座標
        let currentLocation : CLLocation =
            locations[0] as CLLocation
        
        print("\(currentLocation.coordinate.latitude)")
        print(" \(currentLocation.coordinate.longitude)")
        
        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, _) -> Void in
            
            self.currentPlaceMarker = placemarks?.first
        }
        
        
        //設置地圖預設的範圍大小
        let latDelta = 0.005
        let longDelta = 0.005
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        
        //設置地圖顯示範圍與中心點座標
        let center:CLLocation  = CLLocation(
            latitude: (myLocationMgr.location?.coordinate.latitude)!, longitude: myLocationMgr.location!.coordinate.longitude)
        
   
        // span表示地圖的範圍
        let region: MKCoordinateRegion = MKCoordinateRegion(
            center: center.coordinate,
            span: currentLocationSpan)
        
        MapView.setRegion(region, animated: true)
  
    }
}

extension MapViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        //建立可重復性使用的MKPinAnnotationView
        let PinId = "Pin"
        var pinView = MapView.dequeueReusableAnnotationView(withIdentifier: PinId) as? MKPinAnnotationView
        
        if pinView == nil {
            //建立一個大頭針視圖
            pinView = MKPinAnnotationView(annotation: annotation,
                                          reuseIdentifier: PinId)
            //設置點擊大頭針後額外的視圖
            pinView?.canShowCallout = true
            //會落在下釘在地圖上的方式出現
            pinView?.animatesDrop = false
            //大頭針顏色
            pinView?.pinTintColor = .red
            //將試圖右邊資訊社為一個按鈕
            let infoBtn = UIButton(type: .detailDisclosure)
            infoBtn.addTarget(self, action: #selector(infoDetail), for: .touchUpInside)
            pinView?.rightCalloutAccessoryView = infoBtn
            
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    @objc func infoDetail() {
        let alertController = UIAlertController(title: "選擇功能", message: nil, preferredStyle: .actionSheet)
        let guideAction = UIAlertAction(title: "導航路線", style: .default) { (_) in
            self.guideToVet(destination: self.touchedVet)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(guideAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        touchedVet = (view.annotation?.subtitle ?? "") ?? ""
    }
    
    func guideToVet(destination: String) {
        
        self.geoCoder.geocodeAddressString(destination) { (place: [CLPlacemark]?, _) -> Void in
            
            guard let currentPlaceMarker = self.currentPlaceMarker,
                  let destination = place?.first
            else {
                    return
            }
            self.beginGuide(currentPlaceMarker, endPLCL: destination)
        }
    }
    
    // - 導航 -
    func beginGuide(_ startPLCL: CLPlacemark, endPLCL: CLPlacemark) {
        let startplMK: MKPlacemark = MKPlacemark(placemark: startPLCL)
        let startItem: MKMapItem = MKMapItem(placemark: startplMK)
        let endplMK: MKPlacemark = MKPlacemark(placemark: endPLCL)
        let endItem: MKMapItem = MKMapItem(placemark: endplMK)
        let mapItems: [MKMapItem] = [startItem, endItem]
        let dic: [String: AnyObject] = [
            // 導航模式:駕駛
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving as AnyObject,
            // 地圖樣式：標準樣式
            MKLaunchOptionsMapTypeKey: MKMapType.standard.rawValue as AnyObject,
            // 顯示交通：顯示
            MKLaunchOptionsShowsTrafficKey: true as AnyObject]
        // 依據 MKMapItem 的起點和終點組成數組, 通過導航地圖啟動參數字典, 調用系統地圖進行導航
        MKMapItem.openMaps(with: mapItems, launchOptions: dic)
    }
}
