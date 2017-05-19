//
//  ViewController.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/16.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.frame = CGRect.init(x: 100, y: 100, width: 150, height: 50)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        let albumManager = LMAlbumManager(maxSelectedNumber: 2)
        albumManager.showAlbum { (imageArray) in
            print(imageArray)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

