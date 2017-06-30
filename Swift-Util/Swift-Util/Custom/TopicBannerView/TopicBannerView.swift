//
//  TopicBannerView.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/14.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

@objc protocol TopicBannerDelegate: NSObjectProtocol {
    
    @objc optional func topicBannerView(_ bannerView: TopicBannerView, clickAtIndex index: Int)
    
    @objc optional func topicBannerView(_ bannerView: TopicBannerView, currentPage page: Int)
}

class TopicBannerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var errorImage: UIImage?
    
    var placeholderImage: UIImage?
    
    weak var delegate: TopicBannerDelegate?
    
    private var pics: [Any] = []
    
    private var collectionView: UICollectionView? = nil
    
    private let pageControl = UIPageControl()
    
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: frame.width, height: frame.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        addSubview(collectionView!)
        collectionView?.register(BannerCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        pageControl.frame = CGRect(x: 0, y: frame.height - 20, width: frame.width, height: 20)
        pageControl.hidesForSinglePage = true
        addSubview(pageControl)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = pics[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        if item is String {
            let url = item as! String
            cell.bannerImageView.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
        } else if item is UIImage {
            let image = item as! UIImage
            cell.bannerImageView.image = image
        } else {
            cell.bannerImageView.image = placeholderImage
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var index = indexPath.row
        
        if pics.count > 1 {
            if index >= 1 && index <= pics.count - 2 {
                index -= 1
            } else if (index < 1) {
                index = pics.count - 3
            } else {
                index = 0
            }
        }
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.topicBannerView(_:clickAtIndex:))))! {
            delegate?.topicBannerView!(self, clickAtIndex: index)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        var currentPage = index
        
        if index <= 0 {
            scrollView.setContentOffset(CGPoint(x: CGFloat(pics.count - 2) * scrollView.frame.width, y: 0), animated: false)
            currentPage = pics.count - 3
        } else if index >= pics.count - 1 {
            currentPage = 0
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: false)
        } else {
            currentPage = index - 1
        }
        
        if timer != nil {
            return
        }
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.topicBannerView(_:currentPage:))))! {
            delegate?.topicBannerView!(self, currentPage: currentPage)
        }
        
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        var currentPage = 0
        if index <= 0 {
            currentPage = pics.count - 3
        } else if index >= pics.count - 1 {
            currentPage = 0
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: false)
        } else {
            currentPage = index - 1
        }
        
        pageControl.currentPage = currentPage
        
        if delegate != nil && (delegate?.responds(to: #selector(delegate?.topicBannerView(_:currentPage:))))! {
            delegate?.topicBannerView!(self, currentPage: currentPage)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        releaseTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func upDate(_ images: [Any] ) {
        
        pics = images
        
        if pics.count <= 0 {
            return
        }
        
        pageControl.numberOfPages = pics.count
        
        if pics.count > 1 {
            var images: [Any] = []
            images.append(pics.last!)
            for value in pics {
                images.append(value)
            }
            images.append(pics.first!)
            
            pics = images
        }
        
        collectionView?.reloadData()
        
        if timer != nil {
            releaseTimer()
        }
        
        if pics.count > 1 {
            collectionView?.setContentOffset(CGPoint(x: frame.width, y: 0), animated: false)
            startTimer()
        } else {
            collectionView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            releaseTimer()
        }
    }
    
    @objc private func scrollTopic() {
        if pics.count > 1 && timer != nil {
            collectionView?.setContentOffset(CGPoint(x: collectionView!.contentOffset.x + frame.width, y: 0), animated: true)
        }
    }
    
    private func startTimer() {
        if pics.count > 1 {
            releaseTimer()
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollTopic), userInfo: nil, repeats: true)
        }
    }
    
    func releaseTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    deinit {
        releaseTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
