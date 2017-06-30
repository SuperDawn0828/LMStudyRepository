//
//  LMPickerView.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/26.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

@objc protocol LMPickerViewDelegate: NSObjectProtocol {
    
    @objc optional func pickerView(_ pickerView: LMPickerView, updateSourceArray selectedRow: Int, inComponent component: Int) -> [String]
    
    @objc func pickerView(_ pickerView: LMPickerView, certainSelected dataArray: [String])
    
    @objc optional func pickerView(cancelSelected pickerView: LMPickerView)
}

class LMPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: LMPickerViewDelegate?
    
    var pickerViewtitle     = "请选择"
    private let cancelButtonTitle   = "取消"
    private let certainButtonTitle  = "确定"
    
    private let viewWidth:          CGFloat = UIScreen.main.bounds.size.width
    private let viewHeight:         CGFloat = UIScreen.main.bounds.size.height
    private let contentHeight:      CGFloat = 260
    private let navigationHeight:   CGFloat = 44
    private let buttonWidth:        CGFloat = 46
    private let lineHeight:         CGFloat = 0.5
    
    private let contentView     = UIView()
    private let navigationView  = UIView()
    private let certainButton   = UIButton()
    private let cancelButton    = UIButton()
    private let titleLabel      = UILabel()
    private let lineView        = UIView()
    private let pickerView  = UIPickerView()
    
    private var sourceArray: [[String]] = []
    private var selectedResultArray: [String] = []
    
    convenience init(_ sourceArray: [[String]]) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.sourceArray = sourceArray
        for items in sourceArray {
            selectedResultArray.append(items.first!)
        }
        setupSubviews()
    }
    
    private func setupSubviews() {
        
        contentView.frame = CGRect(x: 0, y: viewHeight, width: viewWidth, height: contentHeight)
        contentView.backgroundColor = .white
        addSubview(contentView)
        
        navigationView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: navigationHeight)
        navigationView.backgroundColor = .white
        contentView.addSubview(navigationView)
        
        cancelButton.frame = CGRect(x: 15, y: 0, width: buttonWidth, height: navigationHeight)
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
        cancelButton.setTitleColor(.blue, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        navigationView.addSubview(cancelButton)
        
        certainButton.frame = CGRect(x: viewWidth - buttonWidth - 15, y: 0, width: buttonWidth, height: navigationHeight)
        certainButton.setTitle(certainButtonTitle, for: .normal)
        certainButton.setTitleColor(.blue, for: .normal)
        certainButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        certainButton.addTarget(self, action: #selector(certainAction(_:)), for: .touchUpInside)
        navigationView.addSubview(certainButton)
        
        let titleSize = (pickerViewtitle as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17)])
        titleLabel.center = navigationView.center
        titleLabel.bounds = CGRect(x: 0, y: 0, width: titleSize.width, height: titleSize.height)
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = .black
        titleLabel.text = pickerViewtitle
        navigationView.addSubview(titleLabel)
        
        lineView.backgroundColor = .gray
        lineView.frame = CGRect(x: 0, y: navigationHeight - lineHeight, width: viewWidth, height: lineHeight)
        navigationView.addSubview(lineView)
        
        pickerView.frame = CGRect(x: 0, y: navigationHeight, width: viewWidth, height: contentHeight - navigationHeight)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        contentView.addSubview(pickerView)
    }
    
    //MARK: - dataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return sourceArray.count
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sourceArray[component].count
    }
    
    //MARK: - delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sourceArray[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        DLog("(\(component), \(row))")
        
        selectedResultArray[component] = sourceArray[component][row]
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.pickerView(_:updateSourceArray:inComponent:))))! {
            if component == sourceArray.count - 1 {
                return
            }
            
            let array = delegate?.pickerView!(self, updateSourceArray: row, inComponent: component)
            sourceArray[component + 1] = array!
            pickerView.reloadComponent(component + 1)
            pickerView.selectRow(0, inComponent: component + 1, animated: true)
            
            self.pickerView(pickerView, didSelectRow: 0, inComponent: component + 1)
        }
    }
    
    //MARK: - action
    @objc private func cancelAction(_ sender: UIButton) {
        hide()
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.pickerView(cancelSelected:))))! {
            delegate?.pickerView!(cancelSelected: self)
        }
    }
    
    @objc private func certainAction(_ sender: UIButton) {
        hide()
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.pickerView(_:certainSelected:))))! {
            delegate?.pickerView(self, certainSelected: selectedResultArray)
        }
    }
    
    func show() {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            for tmpWindow in UIApplication.shared.windows {
                if tmpWindow.windowLevel == UIWindowLevelNormal {
                    window = tmpWindow
                    break
                }
            }
        }
        window?.addSubview(self)
        
        alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [unowned self] in
            self.alpha = 1
            self.contentView.frame = CGRect(x: 0, y: self.viewHeight - self.contentHeight, width: self.viewWidth, height: self.contentHeight)
            }, completion: nil)
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [unowned self] in
            self.alpha = 0
            self.contentView.frame = CGRect(x: 0, y: self.viewHeight, width: self.viewWidth, height: self.contentHeight)
        }) { [unowned self] (finish) in
            self.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hide()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
