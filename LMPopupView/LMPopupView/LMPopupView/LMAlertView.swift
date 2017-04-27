//
//  LMAlertView.swift
//  LMPopupView
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMAlertView: LMPopupView {
    
    open var maxInputLength: Int = 15
    
    private var titleLabel: UILabel?
    
    private var detailLabel: UILabel?
    
    private var inputTextField: UITextField?
    
    private var actions: Array<LMPopupAction>?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String?, detail: String?) {
        
        let config = LMPopupConfig()
        
        let cancelAction = LMPopupAction(config.defaultCancel, .normal) { (index) in }
        let confirmAction = LMPopupAction(config.defaultConfirm, .normal) { (index) in }
        
        self.init(title: title, detail: detail, actions: [cancelAction, confirmAction])
    }
    
    convenience init(title: String?, detail: String?, actions: Array<LMPopupAction>) {
        self.init(title: title, detail: detail, placeholder: nil, actions: actions, inputhandler: nil)
    }
    
    convenience init(title: String?, detail: String?, placeholder: String?, actions: Array<LMPopupAction>, inputhandler: InputHandler?) {
        self.init(frame: .zero)
        
        self.animationType = .alert
        self.isWithKeyboard = (inputhandler != nil) ? true : false
        self.animationDuration = 0.3
        self.actions = actions
        
        let config = LMPopupConfig()
        
        backgroundColor = config.backgroundColor
        layer.cornerRadius = config.cornerRadius
        layer.masksToBounds = true
        layer.borderWidth = config.splitWidth
        layer.borderColor = config.splitColor.cgColor
        
        let width = config.width
        var lastY: CGFloat = 0.0
        
        if let text = title {
            titleLabel = UILabel()
            titleLabel?.textColor = config.titleColor
            titleLabel?.textAlignment = .center
            titleLabel?.font = UIFont.systemFont(ofSize: config.titleFontSize)
            titleLabel?.numberOfLines = 0
            titleLabel?.backgroundColor = config.backgroundColor
            titleLabel?.text = text
            addSubview(titleLabel!)
            
            let titleWidth = width - 2 * config.innerMargin
            let titleSize = StringOfSize(text, config.titleFontSize, titleWidth)
            titleLabel?.frame = CGRect(x: config.innerMargin, y: config.innerMargin, width: titleWidth, height: titleSize.height)
            
            lastY += (config.innerMargin + titleSize.height)
        }
        
        if let text = detail {
            detailLabel = UILabel()
            detailLabel?.text = text
            detailLabel?.textAlignment = .center
            detailLabel?.font = UIFont.systemFont(ofSize: config.detailFontSize)
            detailLabel?.numberOfLines = 0
            detailLabel?.backgroundColor = config.backgroundColor
            detailLabel?.textColor = config.detailColor
            addSubview(detailLabel!)
            
            let detailWidth = width - 2 * config.innerMargin
            let detailSize = StringOfSize(text, config.detailFontSize, detailWidth)
            detailLabel?.frame = CGRect(x: config.innerMargin, y: lastY + config.innerMargin, width: detailWidth, height: detailSize.height)
            
            lastY += (config.innerMargin + detailSize.height)
        }
        
        if let _ = inputhandler {
            inputTextField = UITextField()
            inputTextField?.textAlignment = .left
            inputTextField?.placeholder = placeholder
            inputTextField?.backgroundColor = config.backgroundColor
            inputTextField?.layer.borderWidth = config.splitWidth
            inputTextField?.layer.borderColor = config.splitColor.cgColor
            inputTextField?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
            inputTextField?.leftViewMode = .always
            inputTextField?.clearButtonMode = .whileEditing
            addSubview(inputTextField!)
            
            let textFieldWidth = width - 2 * config.innerMargin
            let textFieldHeight: CGFloat = 40.0
            inputTextField?.frame = CGRect(x: config.innerMargin, y: lastY + config.innerMargin, width: textFieldWidth, height: textFieldHeight)
            
            lastY += (config.innerMargin + textFieldHeight)
        }
        
        lastY += config.innerMargin
        
        var buttonWidth: CGFloat = width
        var buttonX: CGFloat = 0.0
        var buttonY: CGFloat = lastY
        
        for (index, value) in actions.enumerated() {
            let button = UIButton()
            button.layer.borderWidth = config.splitWidth
            button.layer.borderColor = config.splitColor.cgColor
            button.titleLabel?.font = UIFont.systemFont(ofSize: config.buttonFontSize)
            button.setTitle(value.title, for: .normal)
            button.setTitle(value.title, for: .highlighted)
            button.setTitleColor(value.actionType == .highlight ? config.actionHighlightColor : config.actionNormalColor, for: .normal)
            button.setBackgroundImage(UIImageWithColor(config.backgroundColor), for: .normal)
            button.setBackgroundImage(UIImageWithColor(config.actionPressedColor), for: .highlighted)
            button.tag = index
            button.addTarget(self, action: #selector(actionButton(sender:)), for: .touchUpInside)
            addSubview(button)

            if actions.count == 2 {
                buttonWidth = width / 2.0
                buttonX += CGFloat(index) * buttonWidth
                
                button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: config.buttonHeight)
                lastY += CGFloat(index) * config.buttonHeight
            } else {
                buttonWidth = width
                buttonX = 0.0
                buttonY += CGFloat(index) * config.buttonHeight
                
                button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: config.buttonHeight)
                lastY += config.buttonHeight
            }
        }
        
        let height = lastY
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationTextChange(notification:)), name: .UITextFieldTextDidChange, object: nil)
    }
    
    override func showKeyboard() {
        inputTextField?.becomeFirstResponder()
    }
    
    override func hideKeyboard() {
        inputTextField?.resignFirstResponder()
    }
    
    @objc private func actionButton(sender: UIButton) {
        
        guard let action = actions?[sender.tag] else {
            return
        }
        
        if action.actionType == .disable {
            return
        }
        
        hide()
        
        if inputHandler != nil && sender.tag > 0 {
            inputHandler!(inputTextField?.text)
        } else {
            action.action(sender.tag)
        }
    }
    
    @objc private func notificationTextChange(notification: Notification) {
        if maxInputLength == 0 {
            return
        }
        
        let object = notification.object as! UITextField
        
        if object != inputTextField {
            return
        }
        
        let toBeString = inputTextField?.text
        let selectedRange = inputTextField?.markedTextRange
        let position = inputTextField?.position(from: selectedRange!.start, offset: 0)
        
        if position != nil {
            if toBeString!.characters.count > maxInputLength {
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
