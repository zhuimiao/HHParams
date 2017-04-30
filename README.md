# HHParams

[![CI Status](http://img.shields.io/travis/zhuimiao/HHParams.svg?style=flat)](https://travis-ci.org/zhuimiao/HHParams)
[![Version](https://img.shields.io/cocoapods/v/HHParams.svg?style=flat)](http://cocoapods.org/pods/HHParams)
[![License](https://img.shields.io/cocoapods/l/HHParams.svg?style=flat)](http://cocoapods.org/pods/HHParams)
[![Platform](https://img.shields.io/cocoapods/p/HHParams.svg?style=flat)](http://cocoapods.org/pods/HHParams)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

ios9.0 swift3.0

## Installation

HHParams is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HHParams"
```

## use

### 1. 通用参数
* 运营商名称

``` swift
   let carriername = HHParams.carriername()
        print("获取运营商名称：\(carriername)")
```
* 客户端版本

```swift
 let client_v = HHParams.client_v()
        print("获取客户端版本号：\(client_v)")
```
* 手机用户名称

```swift
       let phoneUserName = HHParams.phoneUserName()
        print("获取手机用户名称：\(phoneUserName)")
```
* ios版本

```swift
        let osversion = HHParams.osversion()
        print("获取ios版本号：\(osversion)")```
* 手机型号

```swift
    let phoneModel = HHParams.phoneModel()
        print("获取手机型号：\(phoneModel)")
```
* 广告商id (advertisingIdentifier)

```swift
   let idfa = HHParams.getIDFA()
        print("广告商id：\(idfa)")
```
* 供应商id (identifierForVendor)

```swift
    let idfv = HHParams.getIDFV()
        print("供应商id：\(idfv)")
```

### 2.使用钥匙串保存登录密码
> 用 UserDefault 存储敏感信息，是不安全的
好在 ios 为我们提供了更安全的工具：钥匙串。很多 APP 用钥匙串存储敏感信息，比如用户的密码，银行卡信息等。

```swift
  //创建钥匙串管理对象
        let tool = HHKeyChain()
        //设置服务名称
        tool.serviceName = "loginService"
        //设置 key ，value
        let key = "username"
        let value = "password"
        
        // 保存 value 到 KeyChain
        tool .hh_setValue(value, key)
        // 从 KeyChain 读取 value
        let keyChainPassword:String = tool.hh_valueForKey(key)
        print("从 KeyChain 中获取的登录密码：\(keyChainPassword)")
```

### 3.使用钥匙串保存设备唯一标示符

iOS 设备唯一标示符（udid）有两种方案

* 广告商id 作为设备唯一标示符
* 供应商id 设备唯一标示符

缺陷：

* App 卸载重装后广告商id、供应商id 都会发生改变

解决方案：

1. 先从钥匙串里找udid， 找到就用这个
2. 找不到就获取手机udid，并保存到钥匙串

```flow
st=>start: 开始
e=>end: 结束
e1=>end: 结束
op=>operation: 从钥匙串里查找udid
op1=>operation: 获取 App udid
op2=>operation: 存储到钥匙串
cond=>condition: 找到？
st->op->cond
cond(yes)->e
cond(no)->op1->op2->e1

```


```swift
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
```

#### 4. 使用钥匙串获取其它 App 保存的数据
>钥匙串可以分组共享数据。

要求：

* 两个App 必须同属于一个开发者账号下

步骤：
1. project->target->capabilities->KeychainSharing 设置成 on
2. 添加要共享数据的 bundle id，这里不只是添加自己的bundle id、也要添加要共享的 bundle id
3. .entitlements ->Keychain Access Groups-> 添加App id前缀。eg：574C886U7L.org.boitx.mimamiao
574C886U7L.vpn.boitx.org
4. 添加代码

```swift
        let tool = HHKeyChain()
        tool.serviceName = "shareDataService"
        tool.accessGroup = "574C886U7L.org.boitx.mimamiao"
        let groupShareDataKey = "ShareDataKey"
        let groupShareDataValue = tool.hh_valueForKey(groupShareDataKey)
        print("groupShareDataValue:\(groupShareDataValue)")
```


## Author

zhuimiao, 776052494@qq.com

## License

HHParams is available under the MIT license. See the LICENSE file for more info.


