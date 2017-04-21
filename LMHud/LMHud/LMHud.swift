//
//  LMHud.swift
//  LMHud
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

let HUDSCALE = UIScreen.main.bounds.width / 375.0

let HUD_LEFT_INSET = 15 * HUDSCALE
let HUD_INNER_INSET = 10 * HUDSCALE
let HUD_CUSTOMVIEW_WIDTH = 18 * HUDSCALE
let HUD_MAX_WIDTH = 200 * HUDSCALE
let HUD_MINI_WIDTH = 135 * HUDSCALE
let HUD_MAX_HEIGHT = 42 * HUDSCALE
let HUD_CORNERRADIUS = 5 * HUDSCALE

class LMHud: UIView {
    
    var customView: UIView?
    var titleLabel: UILabel?
    var title: String?
    
    convenience init(title: String) {
        self.init(title: title, customView: nil)
    }
    
    init(title: String, customView: UIView?) {
        
        let viewFrame = CGRect(x: 0, y: 0, width: HUD_MAX_WIDTH, height: HUD_MAX_HEIGHT)
        super.init(frame: viewFrame)
        self.title = title
        self.customView = customView
        
        initViews()
        setupViews()
    }
    
    private func initViews() {
        backgroundColor = .black
        layer.cornerRadius = HUD_CORNERRADIUS
        layer.masksToBounds = true
        
        if let tmpView = customView {
            self.addSubview(tmpView)
        }
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.systemFont(ofSize: 14 * HUDSCALE)
        titleLabel?.textColor = .white
        titleLabel?.textAlignment = .center
        self.addSubview(titleLabel!)
    }
    
    private func setupViews() {
        var viewWidth = bounds.width
        let viewHeight = bounds.height
        
        var innerInset: CGFloat = 0
        var customX: CGFloat = HUD_LEFT_INSET
        var customY: CGFloat = 0
        var customWidth: CGFloat = 0
        var customFrame: CGRect = .zero
        
        if let _ = customView {
            customWidth = HUD_CUSTOMVIEW_WIDTH
            customX = HUD_LEFT_INSET
            customY = (viewHeight - customWidth) / 2.0
            customFrame.size = CGSize(width: customWidth, height: customWidth)
            customFrame.origin.x = customX
            customFrame.origin.y = customY
            innerInset = HUD_INNER_INSET
            
        } else {
            customFrame = .zero
            innerInset = 0
            customWidth = 0
        }
        
        customView?.frame = customFrame
        
        titleLabel?.text = title!
        titleLabel?.sizeToFit()
        var titleFrame = titleLabel?.frame
        
        var totalWidth = customFrame.size.width + titleFrame!.size.width
        if totalWidth > (viewWidth - 2 * HUD_LEFT_INSET - innerInset) {
            titleFrame?.size.width = viewWidth - 2 * HUD_LEFT_INSET - innerInset - customFrame.size.width
        } else if totalWidth < HUD_MINI_WIDTH - 2 * HUD_LEFT_INSET - innerInset {
            viewWidth = HUD_MINI_WIDTH
        } else {
            viewWidth = totalWidth + 2 * HUD_LEFT_INSET + innerInset
        }
        
        totalWidth = customFrame.size.width + titleFrame!.size.width + innerInset
        customX = (viewWidth - totalWidth) / 2.0
        customFrame.origin.x = customX
        customView?.frame = customFrame
        
        titleFrame?.origin.x = customX + customWidth + innerInset
        titleFrame?.origin.y = (viewHeight - titleFrame!.height) / 2.0
        titleLabel?.frame = titleFrame!
        
        frame.size = CGSize(width: viewWidth, height: viewHeight)
    }
    
    open func showInView(view: UIView?) {
        guard let tempView = view else {
            return;
        }
        
        let viewFrame = tempView.frame
        var hudFrame = frame
        
        hudFrame.origin.x = (viewFrame.size.width - hudFrame.size.width) / 2.0
        hudFrame.origin.y = (viewFrame.size.height - hudFrame.size.height) / 2.0
        
        tempView.addSubview(self)
        frame = hudFrame
    }
    
    open func dismiss() {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
