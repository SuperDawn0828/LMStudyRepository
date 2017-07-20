//
//  ViewController.swift
//  GCDDemo
//
//  Created by 黎明 on 2017/7/20.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        barrier()
        
//        after()
        
//        apply()
        
        group()
    }
    
    /// 并发队列
    /// 异步任务
    /// 开创多条分线程，同一时间一起执行任务
    private func asyncConcurrent() {
        
        let queueOne = DispatchQueue(label: "com.gcddemo.queueOne", attributes: .concurrent)
        for index in 1 ... 10 {
            queueOne.async {
                print("asyncIndex: \(index), currentThread: \(Thread.current)")
            }
        }
    }
    
    /// 并发队列
    /// 同步任务
    /// 不创建新的线程，任务一个接着一个执行
    private func syncConcurrent() {
        let queueTwo = DispatchQueue(label: "com.gcddemo.queueTwo", attributes: .concurrent)
        for index in 1 ... 10 {
            queueTwo.sync {
                print("syncIndex: \(index), currentThread: \(Thread.current)")
            }
        }
    }
    
    /// 串行队列
    /// 异步任务
    /// 创建一条新的线程，任务一个接着一个执行
    private func asyncSerial() {
        let queueThree = DispatchQueue(label: "com.gcddemo.queuethree")
        for index in 1 ... 10 {
            queueThree.async {
                print("asyncIndex: \(index), currentThread: \(Thread.current)")
            }
        }
    }
    
    /// 串行队列
    /// 同步任务
    /// 不创建新的线程，任务一个接着一个执行
    private func syncSerial() {
        let queueFour = DispatchQueue(label: "com.gcddemo.queueFour")
        for index in 1 ... 10 {
            queueFour.sync {
                print("syncIndex: \(index), currentThread: \(Thread.current)")
            }
        }
    }
    
    /// 全局并发队列
    /// 异步任务
    /// 开创多条分线程，同一时间一起执行任务
    private func asyncGloabl() {
        let globalQueue = DispatchQueue.global()
        for index in 1 ..< 10 {
            globalQueue.async {
                print("globalAsyncIndex: \(index), currentThread: \(Thread.current)")
            }
        }
    }
    
    /// 全局并发队列
    /// 同步任务
    /// 不创建新的线程，任务一个接着一个执行
    private func syncGloabl() {
        let globalQueue = DispatchQueue.global()
        for index in 1 ... 10 {
            globalQueue.sync {
                print("globalSyncIndex: \(index), currentThread: \(Thread.current)")
            }
        }
    }
    
    /// 主队列
    /// 异步任务
    /// 任务在主线程中按顺序执行
    private func asyncMain() {
        let mainQueue = DispatchQueue.main
        for index in 1 ... 10 {
            mainQueue.async {
                print("asyncMainQueueIndex: \(index), currentThread: \(Thread.current)")
            }
        }
    }
    
    /// 主队列
    /// 同步任务
    /// 会造成线程死锁，程序崩溃
    private func syncMain() {
        let mainQueue = DispatchQueue.main
        for index in 1 ... 10 {
            mainQueue.sync {
                print("syncMainQueueIndex: \(index), currentThread: \(Thread.current)")
            }
            
            print("currentIndex: \(index)")
        }
    }
    
    
    /// gcd栅栏函数
    /// 将任务进行分组执行，第一组完成操作后才执行第二组
    private func barrier() {
        let queue = DispatchQueue(label: "com.gcddemo.barrier", attributes: .concurrent)
        
        queue.async {
            print("index: 1; currentThread: \(Thread.current)")
        }
        
        queue.async {
            print("index: 2; currentThread: \(Thread.current)")
        }
        
        __dispatch_barrier_async(queue) {
            print("_____barrier_____; currentThread: \(Thread.current)")
        }
        
        queue.async {
            print("index: 3; currentThread: \(Thread.current)")
        }
        
        queue.async {
            print("index: 4; currentThread: \(Thread.current)")
        }
    }
    
    
    /// gcd延时函数
    private func after() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { 
            print("after 3s")
        }
    }
    
    
    /// 快速迭代
    private func apply() {
        __dispatch_apply(10, DispatchQueue.global()) { (index) in
            print("applyIndex: \(index), currentThread: \(Thread.current)")
        }
    }
    
    /// 队列组
    private func group() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        queue.async(group: group) {
            Thread.sleep(forTimeInterval: 3)
            print("groupIndex: \(1), currentThread: \(Thread.current)")
        }
        
        queue.async(group: group) {
            print("groupIndex: \(2), currentThread: \(Thread.current)")
        }
        
        group.notify(queue: DispatchQueue.main) { 
            print("groupNotify, currentThread: \(Thread.current)")
        }
    }
    
    private func once() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

