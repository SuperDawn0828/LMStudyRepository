//
//  RequestCommand.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import Foundation
import AFNetworking

typealias RequestSuccessReback = (Any) -> ()

typealias RequestFailReback = (Any) -> ()

typealias UploadProgressReback = (Float) -> ()

func NetworkingSessionManager() -> AFHTTPSessionManager {
    let sessionManager = AFHTTPSessionManager()
    sessionManager.requestSerializer.timeoutInterval = 30
    sessionManager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/html"]
    return sessionManager
}

func PostRequestCommand(_ url: String, params: [String: Any]?, isShowWaiting: Bool, success: RequestSuccessReback, requestFail fail: RequestFailReback) {
    
    DLog("\nrequestUrl: \(url)\nparams:\(String(describing: params))")
    
    let manager = NetworkingSessionManager()
    manager.post(url, parameters: params, progress: nil,
                 success: { (task, response) in
                    if let data = (response as? Data) {
                        do {
                            let value = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let dict = (value as? [String: Any]) {
                                
                            } else {
                                
                            }
                        } catch {
                            
                        }
                    } else {
                        
                    }
                }, failure: { (task, error) in
                    
                })
}

func UploadRquestCommand(_ url: String, params: [String: Any]?, isShowWaiting: Bool, uploadProgress: UploadProgressReback?, fileConfigs: [FileConfig], success: RequestSuccessReback, requestFail fail: RequestFailReback) {
    
    DLog("\nrequestUrl: \(url)\nparams:\(String(describing: params))")
    
    let manager = NetworkingSessionManager()
    manager.post(url, parameters: params,
                 constructingBodyWith: { (formData) in
                    for config in fileConfigs {
                        formData.appendPart(withFileData: config.fileData, name: config.name, fileName: config.fileName, mimeType: config.fileType)
                    }
                }, progress: { (progress) in
                    let comptedpad = Float(progress.completedUnitCount)
                    let total = Float(progress.totalUnitCount)
                    uploadProgress?(comptedpad / total)
                }, success: { (task, response) in
                    if let data = (response as? Data) {
                        do {
                            let value = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let dict = (value as? [String: Any]) {
                                
                            } else {
                                
                            }
                        } catch {
                            
                        }
                    } else {
                        
                    }
                }, failure: { (task, error) in
    
                })
}

