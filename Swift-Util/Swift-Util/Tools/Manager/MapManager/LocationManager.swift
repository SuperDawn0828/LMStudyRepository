//
//  BaiduMapManager.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/21.
//  Copyright © 2017年 黎明. All rights reserved.
//

import Foundation

struct GeoCodeResult {
    
    var location: CLLocationCoordinate2D?        //经纬度信息
    
    var province: String?                        //省份
    
    var city: String?                            //城市名
    
    var district: String?                        //区县名
    
    var streetName: String?                      //街道名
}

final class MapManager: NSObject, BMKGeneralDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, AMapLocationManagerDelegate {

    private static let defaultManager = MapManager()
    
    private let bmkLocationManager = BMKLocationService()
    
    private let aMapLocationManager = AMapLocationManager()
    
    private var rebackLocation: ((Bool, CLLocation?) -> ())?
    
    private var rebackGeoCodeResult: ((GeoCodeResult) -> ())?
    
    private override init() {
        super.init()
        bmkLocationManager.delegate = self
        aMapLocationManager.delegate = self
    }
    
    static func manager() -> MapManager {
        return MapManager.defaultManager
    }
    
    func registerBMK(_ key: String) {
        let bmkMapManager = BMKMapManager()
        bmkMapManager.start(BaiduMapKey, generalDelegate: self)
    }
    
    func registerAMap(_ key: String) {
        let mapServices = AMapServices.shared()
        mapServices?.apiKey = GaodeMapKey
    }
    
    //高德地图定位和geocode
    func currentLocation(isGeocode: Bool, aMapRebackLocation: @escaping (Bool, CLLocation?, GeoCodeResult?) -> ()) {
        if checkLocaion() {
            aMapLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            aMapLocationManager.locationTimeout = 5
            aMapLocationManager.reGeocodeTimeout = 5
            aMapLocationManager.requestLocation(withReGeocode: isGeocode) { (location, geoCode, error) in
                let geoResult = GeoCodeResult(location: location?.coordinate, province: geoCode?.province, city: geoCode?.city, district: geoCode?.district, streetName: geoCode?.street)
                aMapRebackLocation(true, location, geoResult)
            }
        } else {
            aMapRebackLocation(false, nil, nil)
        }
    }
    
    //获取当前经纬度信息，包括是否开启定位功能
    func currentLocation(rebackLocation: @escaping (Bool, CLLocation?) -> ()) {
        if checkLocaion() {
            self.rebackLocation = rebackLocation
            bmkLocationManager.startUserLocationService()
        } else {
            rebackLocation(false, nil)
        }
    }
    
    //反地理信息编码，通过经纬度获取
    func reverseGeoCodeSearch(coordinate:CLLocationCoordinate2D, rebackGeoCodeResult: @escaping (GeoCodeResult) -> ()) {
        
        let option = BMKReverseGeoCodeOption()
        option.reverseGeoPoint = coordinate
        
        let bmkGeoSearch = BMKGeoCodeSearch()
        bmkGeoSearch.delegate = self
        bmkGeoSearch.reverseGeoCode(option)
        
        self.rebackGeoCodeResult = rebackGeoCodeResult
    }
    
    //MARK: - delegate
    internal func didUpdate(_ userLocation: BMKUserLocation!) {
        if rebackLocation != nil {
            rebackLocation!(true, userLocation.location)
        }
        bmkLocationManager.stopUserLocationService()
    }
    
    internal func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if rebackGeoCodeResult != nil {
            let geoResult = GeoCodeResult(location: result.location, province: result.addressDetail.province, city: result.addressDetail.city, district: result.addressDetail.district, streetName: result.addressDetail.streetName)
            rebackGeoCodeResult!(geoResult)
        }
    }
    
    //MARK: - other
    private func checkLocaion() -> Bool {
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||  CLLocationManager.authorizationStatus() == .authorizedAlways) || CLLocationManager.authorizationStatus() == .notDetermined {
            return true
        } else {
            return false
        }
    }
}
