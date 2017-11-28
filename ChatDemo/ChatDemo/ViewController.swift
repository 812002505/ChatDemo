//
//  ViewController.swift
//  ChatDemo
//
//  Created by zyc on 2017/11/24.
//  Copyright © 2017年 zyc. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView()
    lazy var dataSource = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.gray
        
        tableView.frame = CGRect(x: 0, y: 0, width: Values.SCREEN_WIDTH, height: Values.SCREEN_HEIGHT - 50)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatViewCell.self, forCellReuseIdentifier: Const.CELL_REUSE_ID)
//        self.view.addSubview(tableView)
        
        let array = ["wahaha", "sagsdgsd\ndf", "aefaesf"]
        for i in 0..<array.count {
            let msg = Message()
            msg.title = array[i]
            dataSource.append(msg)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.CELL_REUSE_ID, for: indexPath) as? ChatViewCell
        
        guard let msg = dataSource[indexPath.row] as? Message else {
            return cell!
        }
        
        cell?.setData(message: msg)
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

