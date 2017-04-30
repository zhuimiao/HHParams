//
//  HHKeyChainTool.swift
//  HHParamsDemo
//
//  Created by boitx on 2017/4/29.
//  Copyright © 2017年 boitx. All rights reserved.
//

import Foundation

/*
 For information on App ID prefixes, see:
 https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/AppID.html
 and:
 https://developer.apple.com/library/ios/technotes/tn2311/_index.html
 */


 public class HHKeyChain: NSObject {
    
    /// 服务名称：比如登录服务，udid服务
    public var serviceName = "MyAppService"
    
    /// 格式： （App ID prefixes) + (bundle id)
    /// 示例： var  accessGroup = "574C886UUG.org.boitx.HHParamsDemo"
    /// （574C886UUG）app id  开发者账号-> app id 里面找
    ///  (org.boitx.HHParamsDemo) APP bundle id
    ///  默认不需要设置，只有当同一个开发者开发的APP之间需要传数据时使用
    public var accessGroup:String? = nil
    
    
    public func hh_setValue(_ value:String, _ key:String) {
        do {
            let passwordItem = KeychainPasswordItem(service: serviceName, account: key, accessGroup: accessGroup)
            // Save the password for the new item.
            try passwordItem.savePassword(value)
        }  catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    
    public func hh_valueForKey(_ key:String) -> String {
        var value = ""
        do {
            let array = try  KeychainPasswordItem.passwordItems(forService: serviceName, accessGroup: accessGroup)
            for item in array {
                if item.account == key {
                    value = try item.readPassword()
                }
            }
            
        }  catch {
            fatalError("Error updating keychain - \(error)")
        }
        return value
    }
    
    public func hh_deleteItems() {
        do {
            let array = try  KeychainPasswordItem.passwordItems(forService: serviceName, accessGroup: accessGroup)
            for item in array {
                try  item.deleteItem()
            }
        }  catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    
}
