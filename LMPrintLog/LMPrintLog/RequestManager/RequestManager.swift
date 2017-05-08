//
//  RequestManager.swift
//  LMPrintLog
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
import AFNetworking

func RequestManager() -> AFHTTPSessionManager {
    let networkingManager = AFHTTPSessionManager()
    networkingManager.requestSerializer.timeoutInterval = 20
    networkingManager.responseSerializer.acceptableContentTypes = ["application/json","text/json","text/html"] as Set
    return networkingManager
}

func NetworkPostRequset(url: String, params: Dictionary<String,Any>, responseObject: @escaping (Any?) -> Void) {
    let networkMessage = NetworkMessage()
    networkMessage.urlString = url
    networkMessage.requestObject = params
    
    let networkManager = RequestManager()
    networkManager.post(url, parameters: params, progress: nil, success: { (task, response) in
        if let tmpResponse = response {
            let dict = tmpResponse as? Dictionary<String, Any>
            if let _ = dict {
                let code = dict?["code"] as? String
                if code == "000000" {
                    let data = dict?["data"] as? Dictionary<String, Any>
                    if let _ = data {
                        networkMessage.code = code!
                        networkMessage.responseObject = data
                        responseObject(data)
                    } else {

                    }
                } else {
                    if let _ = code {
                        networkMessage.code = code!
                        DLog(networkMessage)

                    } else {

                    }
                }
            } else {

            }
        } else {

        }
    }) { (task, error) in
        DLog("request error url is \(url)")
    }
}
