//
//  LMSheetView.swift
//  LMPopupView
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

typealias LMSheetCancelHandler = () -> ()

class LMSheetView: LMPopupView {
    
    private var titleView: UIView?
    
    private var titleLabel: UILabel?
    
    private var cancelButton: UIButton?
    
    private var actions: Array<LMPopupAction>?
    
    private var cancelHandler: LMSheetCancelHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(title: String?, actions: Array<LMPopupAction>, cancelHandler: LMSheetCancelHandler?) {
        self.init(frame: .zero)
        
        let config = LMPopupConfig()
        
        self.animationType = .sheet
        self.actions = actions
        self.animationDuration = 0.3
        self.backgroundColor = config.splitColor
        
        let width = UIScreen.main.bounds.width
        var lastY: CGFloat = 0.0
        
        if let text = title {
            titleView = UIView()
            titleView?.backgroundColor = config.backgroundColor
            addSubview(titleView!)
            
            titleLabel = UILabel()
            titleLabel?.textColor = config.titleColor
            titleLabel?.font = UIFont.systemFont(ofSize: config.titleFontSize)
            titleLabel?.textAlignment = .center
            titleLabel?.numberOfLines = 0
            titleLabel?.text = text
            titleView?.addSubview(titleLabel!)
            
            let titleWidth = width - 2 * config.innerMargin
            let titleSize = SizeOfString(text, config.titleFontSize, titleWidth)
            let titleX = (width - titleSize.width) / 2.0
            
            titleLabel?.frame = CGRect(x: titleX, y: config.innerMargin, width: titleSize.width, height: titleSize.height)
            
            let titleViewHeight = 2 * config.innerMargin + titleSize.height
            
            titleView?.frame = CGRect(x: 0, y: 0, width: width, height:titleViewHeight)
            lastY += (config.innerMargin + titleSize.height)
        }
        
        lastY += config.innerMargin
        
        for (index, value) in actions.enumerated() {
            let button = UIButton()
            button.setBackgroundImage(UIImageWithColor(config.backgroundColor), for: .normal)
            button.setBackgroundImage(UIImageWithColor(config.backgroundColor), for: .disabled)
            button.setBackgroundImage(UIImageWithColor(config.actionPressedColor), for: .highlighted)
            button.setTitle(value.title, for: .normal)
            button.setTitleColor(value.actionType == .highlight ? config.actionHighlightColor : config.actionNormalColor, for: .normal)
            button.tag = index
            button.titleLabel?.font = UIFont.systemFont(ofSize: config.buttonFontSize)
            button.layer.borderWidth = config.splitWidth
            button.layer.borderColor = config.splitColor.cgColor
            button.addTarget(self, action: #selector(actionButton(sender:)), for: .touchUpInside)
            self.addSubview(button)
            
            
            let buttonWidth = width
            let buttonY = lastY + CGFloat(index) * config.buttonHeight
            
            button.frame = CGRect(x: 0, y: buttonY, width: buttonWidth, height: config.buttonHeight)
        }
        
        lastY += config.innerMargin + CGFloat(actions.count) * config.buttonHeight
        
        cancelButton = UIButton()
        cancelButton?.setBackgroundImage(UIImageWithColor(config.backgroundColor), for: .normal)
        cancelButton?.setBackgroundImage(UIImageWithColor(config.actionPressedColor), for: .highlighted)
        cancelButton?.setTitle(config.defaultCancel, for: .normal)
        cancelButton?.setTitleColor(config.actionCancelColor, for: .normal)
        cancelButton?.addTarget(self, action: #selector(actionCancel(sender:)), for: .touchUpInside)
        self.addSubview(cancelButton!)
        
        let cancelButtonWidth = width
        cancelButton?.frame = CGRect(x: 0, y: lastY, width: cancelButtonWidth, height: config.buttonHeight)
        
        lastY += config.buttonHeight
        
        let height = lastY
        frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    @objc private func actionButton(sender: UIButton) {
        let action = actions?[sender.tag]
        
        hide()
        action?.action(sender.tag)
    }
    
    @objc private func actionCancel(sender: UIButton) {
        hide()
        
        if self.cancelHandler != nil {
            self.cancelHandler?()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
