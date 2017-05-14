//
//  ViewController.swift
//  CommonParams
//
//  Created by boitx on 2017/4/29.
//  Copyright © 2017年 boitx. All rights reserved.
//

import UIKit
import HHParams

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction  func getCommonParams() {
        // 获取运营商名称
        var alertMessage = String()
        let carriername = HHParams.carriername()
        print("获取运营商名称：\(carriername)")
        alertMessage.append("获取运营商名称："+carriername + "\n")
        
        
        // 获取客户端版本号：
        let client_v = HHParams.client_v()
        print("获取客户端版本号：\(client_v)")
        alertMessage.append("获取客户端版本号："+client_v + "\n")
        
        
        // 获取手机用户名称
        let phoneUserName = HHParams.phoneUserName()
        print("获取手机用户名称：\(phoneUserName)")
        alertMessage.append("获取手机用户名称："+phoneUserName + "\n")
        
        
        
        // ios版本号
        let osversion = HHParams.osversion()
        print("获取ios版本号：\(osversion)")
        alertMessage.append("获取ios版本号："+osversion + "\n")
        
        // 手机型号
        let phoneModel = HHParams.phoneModel()
        print("获取手机型号：\(phoneModel)")
        alertMessage.append("获取手机型号："+phoneModel + "\n")
        
        
        //获取广告商id
        let idfa = HHParams.getIDFA()
        print("广告商id：\(idfa)")
        alertMessage.append("广告商id:"+idfa + "\n")
        
        
        //获取供应商id
        let idfv = HHParams.getIDFV()
        print("供应商id：\(idfv)")
        alertMessage.append("供应商id"+idfv + "\n")
        showAlert("常用参数", alertMessage)
    }
    
    /// 钥匙串保存密码
    @IBAction  func passwordSaveWithKeyChain() {
        //创建钥匙串管理对象
        let tool = HHKeyChain()
        //设置服务名称
        tool.serviceName = "loginService"
        //设置 key ，value
        let key = "username"
        let value = "password"
        
        // 保存 value 到 KeyChain
        tool .hh_setValue(value, key)
        // 从 KeyChain 读取密码
        let keyChainPassword:String = tool.hh_valueForKey(key)
        print("从 KeyChain 中获取的登录密码：\(keyChainPassword)")
        let alertMessage = ("从 KeyChain 中获取的登录密码：\(keyChainPassword)")
        showAlert("钥匙串保存密码", alertMessage)
    }
    
    
    /// 从钥匙串清除密码
    func clearPasswordFromKeyChain()
    {
        let tool = HHKeyChain()
        tool.serviceName = "loginService"
        
        tool.hh_deleteItems()
    }
    
    
    
    /// 使用 KeyChain 保存和获取 udid
    /// udid 可用 广告商id（idfa）或 供应商id（idfv）代替
    /// 为了解决这个问题：App 卸载重新安装后udid 发生改变
    @IBAction  func udidWithKeyChain() {
        var alertMessage = String()

        let tool = HHKeyChain()
        tool.serviceName = "udidService"
        
        // 保存 广告商id
        var idfa:String = ""
        let idfaKey = "idfa"
        
        idfa = tool.hh_valueForKey(idfaKey)
        if idfa == "" {
            idfa = HHParams.getIDFA()
            tool.hh_setValue(idfa, idfaKey)
        }
        print("广告商id为:\(idfa)")
        alertMessage.append("广告商id："+idfa + "\n")
        
        
        // 保存 供应商id
        var idfv:String = ""
        let idfvKey = "idfv"
        
        idfv = tool.hh_valueForKey(idfvKey)
        if idfv == "" {
            idfv = HHParams.getIDFA()
            tool.hh_setValue(idfv, idfvKey)
        }
        print("供应商id为:\(idfv)")
        alertMessage.append("供应商id："+idfv + "\n")
        showAlert("从钥匙串读取udid", alertMessage)
    }
    
    /// 获取其它 App 的内容， App间通讯的一种方式
    /// 即：获取其它 App 保存在 KeyChain 中的内容
    @IBAction func getDataFromOtherApp() {
        let tool = HHKeyChain()
        tool.serviceName = "shareDataService"
        tool.accessGroup = "574C886U7L.org.boitx.mimamiao"
        let groupShareDataKey = "ShareDataKey"
        let groupShareDataValue = tool.hh_valueForKey(groupShareDataKey)
        print("groupShareDataValue:\(groupShareDataValue)")
        showAlert("从钥匙串读取到的数据", groupShareDataValue)
        
    }
    
    @IBAction func getRAMROM(_ sender: UIButton) {
        
        var alertMessage = String()
        let neicun = HHParams.getRAMTotal()
        print("总内存大小：\(neicun)")
        alertMessage.append("总内存大小：\(neicun)" + "\n")

        
        let keyongneicun = HHParams.getRAMAvailable()
        print("可用内存大小：\(keyongneicun)")
        alertMessage.append("可用内存大小：\(keyongneicun)" + "\n")

        
        let cipan = HHParams.getROMTotal()
        print("总磁盘大小：\(cipan)")
        alertMessage.append("总磁盘大小：\(cipan)" + "\n")

        
        let keyongcipan = HHParams.getROMAvailable()
        print("可用磁盘大小：\(keyongcipan)")
        alertMessage.append("可用磁盘大小：\(keyongcipan)" + "\n")

        
        let dianliang = HHParams.getBatteryQuantity()
        print("电量：\(dianliang)")
        alertMessage.append("电量：\(dianliang)" + "\n")
        showAlert("电量RAMROM", alertMessage)
    }
    
    
    func showAlert(_ title:String, _ message:String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "确定", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

