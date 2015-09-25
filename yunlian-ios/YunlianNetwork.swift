//
//  File.swift
//  yunlian-ios
//
//  Created by zikang zou on 24/9/15.
//  Copyright © 2015年 yunlian. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum YunlianNetworkResult {
    case Success(JSON)
    case Not200(Int)
    case NetworkNotConnected
    case Timeout
    case ServerError(String)
}

enum Api: String {
    case Register = "register"
    case Login = "login"
    case AnswerQuestion = "question/sendanswer"
    case GetQuestion = "question/get"
    case VerifyCode = "verify"
}

class YunlianNetwork {
//    static let RootPath = "http://127.0.0.1:6600"
    static let RootPath = "http://www.baidu.com"
    
    static let YunlianEncoding = ParameterEncoding.Custom { (URLRequest, parameters) -> (NSMutableURLRequest, NSError?) in
        var mutableURLRequest = URLRequest.URLRequest
        guard let parameters = parameters else {
            return (mutableURLRequest, nil)
        }
        let str = NSString(data: YunlianNetwork.jsonfyData(parameters), encoding: NSUTF8StringEncoding)
        let encryptedStr = NSData.AES256EncryptWithPlainText(str as! String)
        let encryptedData = encryptedStr.dataUsingEncoding(NSUTF8StringEncoding)
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.HTTPBody = encryptedData
        return (mutableURLRequest, nil)
    }
    
    class func yunlianRequest(api: Api, parameters: [String: AnyObject]?, completionHandler: YunlianNetworkResult -> Void) {
        Alamofire.request(.POST, apiURL(api), parameters: parameters, encoding: YunlianNetwork.YunlianEncoding).responseString { response -> Void in
            completionHandler(yunlianResponse(response.0, response: response.1, result: response.2))
        }
    }
    
    class func apiURL(api: Api) -> String {
        return RootPath + "/" + api.rawValue
    }
    
    class func yunlianResponse(request: NSURLRequest?, response: NSHTTPURLResponse?, result: Result<String>) -> YunlianNetworkResult {
        switch result {
        case .Success(let value):
            if response?.statusCode == 200 {
                return YunlianNetworkResult.Success(decodeResponseString(value))
            } else {
                return YunlianNetworkResult.Not200(response!.statusCode)
            }
        case .Failure(_, let error as NSError):
            if error.code == -1009 {
                return YunlianNetworkResult.NetworkNotConnected
            } else if error.code == -1001 {
                return YunlianNetworkResult.Timeout
            }
            return YunlianNetworkResult.ServerError(error.userInfo.description)
        default:
            return YunlianNetworkResult.ServerError("连接遇到问题")
        }
    }
    
    class func decodeResponseString(str: String) -> JSON {
        let decryptedStr = NSData.AES256DecryptWithCiphertext(str)
        let json = JSON(data: decryptedStr.dataUsingEncoding(NSUTF8StringEncoding)!)
        return json
    }
    
    class func jsonfyData(obj: AnyObject) -> NSData {
        let data = try! NSJSONSerialization.dataWithJSONObject(obj, options: NSJSONWritingOptions(rawValue: 0))
        return data
    }
}
