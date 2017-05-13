//
//  BaseUrl.swift
//  LMPrintLog
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

enum NetworkRequestEnv {
    case test
    case release
}

struct NetworkRequestBase {

    var baseUrl: String
    
    var requestEnv: NetworkRequestEnv
    
    init(_ env: NetworkRequestEnv) {
        requestEnv = env
        
        switch env {
        case .test:
            baseUrl = "http://10.19.10.107:8081/"
        case .release:
            baseUrl = "https://sslapi.shoushangmeijia.com/"
        }
    }
    
    func getFullUrl(_ apiName: String) -> String {
        return baseUrl + apiName
    }
}

func GetFullUrlWithApiName(_ apiName: String) -> String {
    
    let networkBase = NetworkRequestBase(.release)
    return networkBase.getFullUrl(apiName)
}

