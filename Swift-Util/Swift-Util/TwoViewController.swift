//
//  TwoViewController.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/14.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController, TopicBannerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let bannerView = TopicBannerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 150))
        bannerView.delegate = self
        view.addSubview(bannerView)
        
        let images = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497421927887&di=cd84ec5f05ea35db4075f320dc19c095&imgtype=0&src=http%3A%2F%2Fbbsatt.yineitong.com%2Fforum%2F2011%2F03%2F25%2F110325164993a2105258f0d314.jpg",
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497421976401&di=0286686305a9c24a8c5e29edd9d3693f&imgtype=0&src=http%3A%2F%2Fimage.elegantliving.ceconline.com%2F320000%2F320100%2F20110815_03_52.jpg",
                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1497422003138&di=7536cf345036b1af7678b07f2e36d8b5&imgtype=0&src=http%3A%2F%2Fuploads.jy135.com%2Fallimg%2F201705%2F13-1F5260TA1.jpg"]
        bannerView.upDate(images)
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func topicBannerView(_ bannerView: TopicBannerView, clickAtIndex index: Int) {
        DLog(index)
    }
    
    func topicBannerView(_ bannerView: TopicBannerView, currentPage page: Int) {
//        DLog(page)
    }
    
    deinit {
//        bannerView?.releaseTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
