//
//  ViewController.swift
//  Map
//
//  Created by D7703_15 on 2018. 6. 7..
//  Copyright © 2018년 DIT_Food_Find. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var myMapView: MKMapView!
    
    var foodStoreNames = ["늘해랑", "번개반점", "아딸", "왕짜장", "토마토 도시락", "홍콩반점"]
    var foodStoreAddress = ["부산광역시 부산진구 양정1동 350-1",
                            "부산광역시 부산진구 양정동 418-282",
                            "부산광역시 부산진구 양정동 393-18",
                            "부산관역시 부산진구 양정1동 356-22",
                            "부산광역시 부산진구 양정1동 산19-8",
                            "부산광역시 부산진구 양정동 353-38"]
    var i = 0
    //pin의 배열 생성 및 초기화
    var annos = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in foodStoreAddress {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(item) {
                (placemarks: [CLPlacemark]?, error: Error?) -> Void in
                if let myError = error {
                    print(myError)
                    return
                }

                let myPlacemark = placemarks![0]
                //print(myPlacemark.location?.coordinate)
                
                //한개씩 뽑아서 지도에 꽂기
                if let loc = myPlacemark.location {
                  let anno = MKPointAnnotation()
                    anno.coordinate = loc.coordinate
                    anno.title = self.foodStoreNames[self.i]
                    anno.subtitle = self.foodStoreAddress[self.i]
                    self.i = self.i + 1
                    
                    //pin을 pin 배열에 추가
                    self.annos.append(anno)
                    self.myMapView.addAnnotations(self.annos)
                    
                    //pin을 맵에 꽉 넣어서 보여주기
                    self.myMapView.showAnnotations(self.annos, animated: true)
                } else {
                    print("nil 발생")
                }
                
        }
        
//        //위도, 경도 설정
//        //DIT 부산광역시 부산진구 양정동 429-19
//        //35.16599, 129.072543
//        let loc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.165999, longitude: 129.072543)
//
//        //변경
//        let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
//
//        //region
//        let region = MKCoordinateRegion(center: loc, span: span)
//
//        //Mapkit에 설정
//        myMapView.setRegion(region, animated: true)
//
//        //annotation 꼽기
//        let anno = MKPointAnnotation()
//        anno.coordinate = loc
//        anno.title = "DIT동의과학대학"
//        anno.subtitle = "내꿈이 자라는 곳"
//        myMapView.addAnnotation(anno)
        
        let addr = "부산광역시 부산진구 양정동 418-282"
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(addr) {
            (placemarks: [CLPlacemark]?, error: Error?) -> Void in
            if let error = error {
                print(error)
                return
            }
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                let loc = placemark.location?.coordinate
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center:loc!, span:span)
                self.myMapView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = loc!
                annotation.title = addr
                annotation.subtitle = "번개반점"
                self.myMapView.addAnnotation(annotation)
                
            }
        }
    }
}
}
