//
//  LMAlbumListViewController.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/17.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

class LMAlbumListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var callBack: LMPhotoResult?
    
    var maxSelectedNumber = 0
        
    var tableView: UITableView? = nil
    
    private var dataArray: [PHAssetCollection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = GetPhotoListDatas()
        
        setupNavigationBar()
        setupSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    private func setUpNavigationBar() {
        let rightItem = UIBarButtonItem(title: "关闭", style: .done, target: self, action: #selector(rightItemAction(_:)))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func setupSubViews() {
        tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        tableView?.backgroundColor = .white
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = .none
        view.addSubview(tableView!)
        
        tableView?.register(LMAlbumListTableViewCell().classForCoder, forCellReuseIdentifier: "LMAlbumListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let assetCollection = dataArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LMAlbumListTableViewCell", for: indexPath) as! LMAlbumListTableViewCell
        cell.albumListData(assetCollection)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assetCollection = dataArray[indexPath.row]
        
        let imagePickerVC = LMImagePickerViewController()
        imagePickerVC.callBack = callBack
        imagePickerVC.maxSelectedNumber = maxSelectedNumber
        imagePickerVC.fetchResult = GetFetchResult(assetCollection)
        navigationController?.pushViewController(imagePickerVC, animated: true)
    }
    
    @objc private func rightItemAction(_ item: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
