//
//  KeyChainConfig.swift
//  HHParamsDemo
//
//  Created by boitx on 2017/4/29.
//  Copyright © 2017年 boitx. All rights reserved.
//

import Foundation

class HHKeyChainConfig: NSObject {
    
    /// 服务名称：比如登录服务，uuid 服务
    var  serviceName = ""
    
    /// （574C886UUG） 开发者账号-> app id 里面找
    ///  (org.boitx.HHParamsDemo) APP bundle id
    ///   var  accessGroup = "574C886UUG.org.boitx.HHParamsDemo"
    ///  默认不需要设置，只有当同一个开发者开发的APP之间需要传数据时使用
    var  accessGroup:String? = nil
}
