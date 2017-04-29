//
//  HHParams.swift
//  HHParamsDemo
//
//  Created by boitx on 2017/4/28.
//  Copyright © 2017年 boitx. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony
import AdSupport


/// 运营商
///
/// - Returns: 中国移动，中国联通，中国电信，wifi
public    func carriername() -> String{
    let telephonyNetworkInfo = CTTelephonyNetworkInfo()
    let carrier = telephonyNetworkInfo.subscriberCellularProvider
    if carrier == nil {
        return "WiFi"
    }else{
        return carrier!.carrierName!
    }
}


/// 客户端版本号
///
/// - Returns: 1.0  2.0
public    func client_v() -> String{
    return  (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
}

/// 手机用户名称
///
/// - Returns: 老王的iphone
public    func phoneUserName() -> String{
    return UIDevice.current.name
}

/// ios版本号
///
/// - Returns: ios 10.0
public    func osversion() -> String{
    return  UIDevice.current.systemVersion
}

/// 手机型号
///
/// - Returns: iphone7 plus
public func phoneModel() -> String{
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
    case "iPod5,1":                                 return "iPod Touch 5"
    case "iPod7,1":                                 return "iPod Touch 6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
    case "iPhone4,1":                               return "iPhone 4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
    case "iPhone7,2":                               return "iPhone 6"
    case "iPhone7,1":                               return "iPhone 6 Plus"
    case "iPhone8,1":                               return "iPhone 6s"
    case "iPhone8,2":                               return "iPhone 6s Plus"
    case "iPhone8,4":                               return "iPhone SE"
    case "iPhone9,1":                               return "iPhone 7"
    case "iPhone9,2":                               return "iPhone 7 Plus"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,7", "iPad6,8":                      return "iPad Pro"
    case "AppleTV5,3":                              return "Apple TV"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
}

/// 获取：广告商id
///
/// - Returns: advertisingIdentifier.uuidString
public   func getIDFA() -> String {
    return ASIdentifierManager.shared().advertisingIdentifier.uuidString
}

/// 获取：供应商id
///
/// - Returns: advertisingIdentifier.uuidString
public        func getIDFV() -> String {
    return ASIdentifierManager.shared().advertisingIdentifier.uuidString
}

