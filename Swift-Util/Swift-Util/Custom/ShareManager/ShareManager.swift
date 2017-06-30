//
//  ShareManager.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/13.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

enum ShareType {
    case image, link
}

enum ShareScenc {
    case QQ, wechatSession, wechatTimeLine, link
    
    var scencShareItem: ShareItem {
        var item: ShareItem
        switch self {
        case .QQ:
            item = ShareItem(itemTitle: "QQ", itemImage: "qq")
        case .wechatSession:
            item = ShareItem(itemTitle: "微信", itemImage: "weixin")
        case .wechatTimeLine:
            item = ShareItem(itemTitle: "朋友圈", itemImage: "pengyouquan")
        case .link:
            item = ShareItem(itemTitle: "复制链接", itemImage: "link")
        }
        return item
    }
}

struct ShareItem {
    
    var itemTitle: String
    
    var itemImage: String
}

struct ShareContext {
    
    var title: String?
    
    var shareLink: String?
    
    var thumImage: UIImage?
    
    var shareImage: UIImage?
    
    var detail: String?
}

class ShareManager: NSObject {
    
    private var shareContext: ShareContext
    
    private var shareType: ShareType
    
    private var shareScencs: [ShareScenc]
    
    init(shareType: ShareType, shareContext: () -> ShareContext) {
        
        self.shareContext = shareContext()
        
        self.shareType = shareType
        
        self.shareScencs = [.QQ, .wechatSession, .wechatTimeLine, .link]
        
        super.init()
        
        showShareView()
    }
    
    init(shareType: ShareType, shareScencs: [ShareScenc], shareContext: () -> ShareContext) {
        
        self.shareContext = shareContext()
        
        self.shareType = shareType
        
        self.shareScencs = shareScencs
        
        super.init()
        
        showShareView()
    }
    
    private func showShareView() {
        var shareItems: [ShareItem] = []
        
        for shareScenc in shareScencs {
            shareItems.append(shareScenc.scencShareItem)
        }
        
        let shareView = ShareView(shareItems, shareAction: shareView(selectedIndex:))
        shareView.shareItems = shareItems
        shareView.show()
    }

    func shareView(selectedIndex index: Int) {
        let scenc = shareScencs[index]
        
        switch scenc {
        case .QQ:
            shareAction(kindType: .QQ)
        case .wechatSession:
            shareAction(kindType: .wechatSession)
        case .wechatTimeLine:
            shareAction(kindType: .wechatTimeLine)
        case .link: break
        }
    }
    
    func shareAction(kindType:UMSocialPlatformType) {
        let shareObject = UMShareWebpageObject()
        shareObject.webpageUrl = shareContext.shareLink
        shareObject.thumbImage = UIImage(named: "shareImage")
        shareObject.title = shareContext.title
        shareObject.descr = shareContext.detail
        
        let messageObject = UMSocialMessageObject()
        messageObject.title = "分享网页"
        messageObject.shareObject = shareObject
        
        UMSocialManager.default().share(to: kindType, messageObject: messageObject, currentViewController: GetCurrentViewController()) { (shareReponse, error) in
            
        }
    }
}
