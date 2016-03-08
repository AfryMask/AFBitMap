//
//  AFDemoTableViewController.swift
//  AFBitMapDemo
//
//  Created by Afry on 16/3/3.
//  Copyright © 2016年 Afry. All rights reserved.
//

import UIKit

class AFDemoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"demoCell")
        title = "DemoList"
        navigationItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("demoCell", forIndexPath: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel!.text = "Demo1: 取色器"
        }else if indexPath.row == 1 {
            cell.textLabel!.text = "Demo2: 图片拉伸"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            let demo1 = Demo1_ViewController()
            navigationController?.pushViewController(demo1, animated: true)
            
        }else if indexPath.row == 1 {
            let demo2 = Demo2_ViewController()
            navigationController?.pushViewController(demo2, animated: true)
        }
    }
}
