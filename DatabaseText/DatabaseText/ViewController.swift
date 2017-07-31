//
//  ViewController.swift
//  DatabaseText
//
//  Created by 黎明 on 2017/7/19.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var messageDB: MessageCenterDatabase!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func createTableAction(_ sender: UIButton) {
        messageDB = MessageCenterDatabase()
        messageDB.createTable()
    }
    
    
    @IBAction func insertTableAction(_ sender: UIButton) {
        let values: [[String: Any]] = [["title": "2",
                                      "type": 1,
                                      "uuid": "0",
                                      "content": "2",
                                      "createDate": 1500255290000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "1",
                                      "content": "2",
                                      "createDate": 1500255291000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "5",
                                      "content": "2",
                                      "createDate": 1500255295000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "9",
                                      "content": "2",
                                      "createDate": 1500255299000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "10",
                                      "content": "2",
                                      "createDate": 1500255300000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "11",
                                      "content": "2",
                                      "createDate": 1500255301000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "2",
                                      "content": "2",
                                      "createDate": 1500255292000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "12",
                                      "content": "2",
                                      "createDate": 1500255302000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "16",
                                      "content": "2",
                                      "createDate": 1500255306000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "17",
                                      "content": "2",
                                      "createDate": 1500255307000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "8",
                                      "content": "2",
                                      "createDate": 1500255298000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "13",
                                      "content": "2",
                                      "createDate": 1500255303000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "14",
                                      "content": "2",
                                      "createDate": 1500255304000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "15",
                                      "content": "2",
                                      "createDate": 1500255305000],
                                     ["title": "2",
                                      "type": 1,
                                      "uuid": "18",
                                      "content": "2",
                                      "createDate": 1500255308000],
                                    ["title": "2",
                                    "type": 1,
                                    "uuid": "3",
                                    "content": "2",
                                    "createDate": 1500255293000],
                                    ["title": "2",
                                    "type": 1,
                                    "uuid": "4",
                                    "content": "2",
                                    "createDate": 1500255294000],
                                    ["title": "2",
                                    "type": 1,
                                    "uuid": "6",
                                    "content": "2",
                                    "createDate": 1500255296000],
                                    ["title": "2",
                                    "type": 1,
                                    "uuid": "7",
                                    "content": "2",
                                    "createDate": 1500255297000]]
        
        for value in values {
            messageDB.writeValue(value, with: value["uuid"] as! String)
        }
        
    }
    
    @IBAction func selectTableAction(_ sender: UIButton) {
        let values = messageDB.readValues(by: 0)
        DLog(values)
    }
    
    @IBAction func selectCountAction(_ sender: UIButton) {
        let count = messageDB.countIsRead()
        DLog(count)
    }
    
    @IBAction func deleteTableAction(_ sender: UIButton) {
        messageDB.deleteOverflowValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

