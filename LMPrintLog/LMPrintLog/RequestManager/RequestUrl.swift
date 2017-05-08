//
//  RequestUrl.swift
//  LMPrintLog
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

func GetUserRoomInfo() -> String {
    let apiName = "ssmj-soa/ws/rest/shop/getQRCode"
    return GetFullUrlWithApiName(apiName)
}
