//
//  NetworkMessage.swift
//  LMPrintLog
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class NetworkMessage: NSObject {
    var urlString: String = ""
    
    var code: String?
    
    var requestObject: Any?
    
    var responseObject: Any?
    
    override var description: String {
        return "\n urlString: \(urlString) \n code: \(code!) \n requestObject: \(requestObject!) \n responseObject:"
    }
}
