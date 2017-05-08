//
//  RequestApi.swift
//  LMPrintLog
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

func GetUserRoomInfoRequest(_ params: Dictionary<String, Any>, responseObject: @escaping (Any?) -> Void) {
    let urlString = GetUserRoomInfo()
    NetworkPostRequset(url: urlString, params: params) { (response) in
        responseObject(response)
    }
}
