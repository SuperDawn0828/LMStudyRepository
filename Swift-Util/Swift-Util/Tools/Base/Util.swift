//
//  Util.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/12.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import MJRefresh
import AFNetworking
//json数据转换
func JsonStringToDictionaryOrArray(_ jsonString: String) -> Any? {
    let jsonData = jsonString.data(using: .utf8)
    if let data = jsonData {
        do {
            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return result
        } catch {
            return nil
        }
    } else {
        return nil
    }
}

func JsonStringFromDictionaryOrArray(_ object: Any) -> String? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString
    } catch {
        return nil
    }
}

//数据存储
func SvaeData(_ value: Any?, forKey key: String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}

func ReadData(forKey key: String) -> Any? {
    return UserDefaults.standard.object(forKey: key)
}

func RemoveData(with key: String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

//时间转换
func DateToString(by date: Date, formettor: String) -> String {
    let dateformettor = DateFormatter()
    dateformettor.locale = Locale.current
    dateformettor.dateFormat = formettor
    return dateformettor.string(from: date)
}

func DateToString(by timeInterval: TimeInterval, formettor: String) -> String {
    let date = Date(timeIntervalSince1970: timeInterval)
    let dateformettor = DateFormatter()
    dateformettor.locale = Locale.current
    dateformettor.dateFormat = formettor
    return dateformettor.string(from: date)
}

func DateFromString(by dateString: String, formettor: String) -> Date? {
    let dateformettor = DateFormatter()
    dateformettor.locale = Locale.current
    dateformettor.dateFormat = formettor
    return dateformettor.date(from: dateString)
}

func TimeInterval(by dateString: String, formettor: String) -> TimeInterval? {
    let dateformettor = DateFormatter()
    dateformettor.locale = Locale.current
    dateformettor.dateFormat = formettor
    let date = dateformettor.date(from: dateString)
    return date?.timeIntervalSince1970
}

func TimeDifferenceSineNow(with timeInterval: TimeInterval) -> TimeInterval {
    let date = Date(timeIntervalSince1970: timeInterval)
    return date.timeIntervalSinceNow
}

func TimeDifferenceSineNow(with date: Date) -> TimeInterval {
    return date.timeIntervalSinceNow
}

//电话号码校验
func CheckPhoneNumber(_ phoneNumber: String) -> Bool {
    
    let MOBILE = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let CT = "^1((33|53|77|8[09])[0-9]|349)\\d{7}$"
    
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@", CM)
    let regextestcu = NSPredicate(format: "SELF MATCHES %@", CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@", CT)
    
    if regextestmobile.evaluate(with: phoneNumber) || regextestcm.evaluate(with: phoneNumber) || regextestcu.evaluate(with: phoneNumber) || regextestct.evaluate(with: regextestct) {
        return true
    } else {
        return false
    }
}

//身份证校验
func CheckIdentityCardNumber(_ carNumber: String) -> Bool {
    
    var idCard = carNumber
    
    if idCard.characters.count != 18 && idCard.characters.count != 15 {
        return false
    }
    
    if idCard.characters.count == 15 {
        idCard = carNumber.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if idCard.isEmpty {
            return false
        } else {
            if idCard.characters.count != 15 {
                return false
            }
        }
        
        let areasArray = ["11", "12", "13", "14", "15", "21", "22","23", "31","32", "33","34", "35","36",
                          "37", "41", "42", "43", "44", "45", "46","50", "51","52", "53","54", "61","62",
                          "63", "64", "65", "71", "81", "82", "91"]
        
        let vauleStart2 = idCard.substring(to: idCard.index(idCard.startIndex, offsetBy: 2))
        var areaFlag = false
        for areaCode in areasArray {
            if areaCode == vauleStart2 {
                areaFlag = true
                break
            }
        }
        
        if areaFlag == false {
            return false
        }
        
        var regularExpression: NSRegularExpression?
        var numberofMatch: Int? = 0
        var year = 0
        
        year = Int(idCard.substring(with: Range(idCard.index(idCard.startIndex, offsetBy: 6) ..< idCard.index(idCard.startIndex, offsetBy: 8))))! + 1900
        if year % 4 == 0 || (year % 4 == 0 && year % 100 == 0) {
            regularExpression = try? NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}",
                                                    options: .caseInsensitive)
        } else {
            regularExpression = try? NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$",
                                                              options: .caseInsensitive)
        }
        
        numberofMatch = (regularExpression?.numberOfMatches(in: idCard, options: .reportProgress, range: NSMakeRange(0, idCard.characters.count)))
        
        guard let _ = numberofMatch else {
            return false
        }
        
        if numberofMatch! > 0 {
            return true
        } else {
            return false
        }
        
    } else {
        if idCard.characters.count != 18 {
            return false
        }
        
        let codeArray = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"]
        let checkCodeDic = ["0": "1", "1": "0", "2": "X", "3": "9", "4": "8", "5": "7", "6": "6", "7": "5", "8": "4", "9": "3", "10": "2"]
        
        let scan = Scanner(string: idCard.substring(to: idCard.index(idCard.startIndex, offsetBy: 17)))
        
        var val = 0
        let isNum = scan.scanInt(&val) && scan.isAtEnd
        if isNum == false {
            return false
        }
        var sumValue: Int = 0
        
        for i in 0 ..< 17 {
            sumValue += Int(String(idCard[idCard.index(idCard.startIndex, offsetBy: i)]))! * Int(codeArray[i])!
        }
        
        let strlast = checkCodeDic[String(format: "%d", sumValue % 11)]
        let idCardlast = String(idCard[idCard.index(before: idCard.endIndex)])
        if strlast == idCardlast {
            return true
        } else {
            return false
        }
    }
}

//获取系统版本
func GetSystemVersion() -> Double? {
    return Double(UIDevice.current.systemVersion)
}

//获取bundleIdentifier
func GetBundleIndetifier() -> String {
    return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
}

//获取应用版本
func GetBundleVersion() -> String {
    return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
}

//获取当前控制器
func GetCurrentViewController() -> UIViewController? {
    var result: UIViewController?
    var window = UIApplication.shared.keyWindow
    
    if window?.windowLevel != UIWindowLevelNormal {
        let windows = UIApplication.shared.windows
        for tmpWindow in windows {
            if tmpWindow.windowLevel == UIWindowLevelNormal {
                window = tmpWindow
                break
            }
        }
    }
    
    let frontView = window?.subviews.first
    let nextResponder = frontView?.next
    
    if nextResponder is UIViewController {
        result = nextResponder as? UIViewController
    } else {
        result = window?.rootViewController
    }
    
    var topVC: UIViewController?
    if result is UITabBarController {
        let tabBarVC = result as? UITabBarController
        let navVC = tabBarVC?.selectedViewController as? UINavigationController
        topVC = navVC?.topViewController
    } else if result is UINavigationController {
        let navVC = result as? UINavigationController
        topVC = navVC?.topViewController
    } else {
        topVC = result
    }
    
    let vc = topVC?.presentedViewController
    if let _ = vc {
        if vc is UINavigationController {
            let navVC = vc as? UINavigationController
            return navVC?.topViewController
        }
        return vc
    }
    
    return topVC
}

//下拉刷新，下拉加载
func headerRefresh(_ target: Any, selector: Selector) -> MJRefreshHeader? {
    let header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: selector)
    header?.setTitle("下拉可以刷新", for: .idle)
    header?.setTitle("松开立即刷新", for: .pulling)
    header?.setTitle("努力加载中...", for: .refreshing)
    header?.stateLabel.textColor = .black
    header?.stateLabel.font = UIFont.systemFont(ofSize: 12)
    header?.lastUpdatedTimeLabel.isHidden = true
    header?.activityIndicatorViewStyle = .gray
    header?.stateLabel.text = "努力加载中"
    return header
}

func footerRefresh(_ target: Any, selector: Selector) -> MJRefreshFooter? {
    let footer = MJRefreshAutoNormalFooter(refreshingTarget: selector, refreshingAction: selector)
    footer?.stateLabel.textColor = .black
    footer?.stateLabel.font = UIFont.systemFont(ofSize: 12)
    footer?.setTitle("没有更多了", for: .noMoreData)
    return footer
}

//打开应用所在系统的设置页面
func OpenApplicationSetting() {
    let url = URL(string: UIApplicationOpenSettingsURLString)
    guard let settingUrl = url else {
        return;
    }
    
    if UIApplication.shared.canOpenURL(settingUrl) {
        UIApplication.shared.openURL(settingUrl)
    }
}

//相机权限
func AuthorizationCamera(_ method: @escaping () -> ()) {
    let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
    if status == .restricted || status == .denied {
        //无权限
    } else if status == .notDetermined {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (result) in
            if result {
                method()
            } else {
                //无权限
            }
        })
    } else {
        method()
    }
}

//相册权限
func AuthorizationAlbum(_ method: @escaping () -> ()) {
    let status = PHAuthorizationStatus.authorized
    if status == .restricted || status == .denied {
        //无权限
    } else if status == .notDetermined {
        PHPhotoLibrary.requestAuthorization({ (status) in
            if status == .authorized {
                method()
            } else {
                //无权限
            }
        })
    } else {
        method()
    }
}

//检测是否联网
func CheckNetworkStatus(netReback: @escaping (Bool) -> Void){
    let reachabilityManager = AFNetworkReachabilityManager.shared()
    
    reachabilityManager.setReachabilityStatusChange { (status) in
        switch status {
        case .unknown:
            netReback(true)
        case .reachableViaWiFi:
            netReback(true)
        case .reachableViaWWAN:
            netReback(true)
        default :
            netReback(false)
        }
    }
    
    reachabilityManager.startMonitoring()
}
