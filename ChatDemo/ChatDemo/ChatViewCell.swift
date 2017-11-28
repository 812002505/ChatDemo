//
//  ChatViewCell.swift
//  ChatDemo
//
//  Created by zyc on 2017/11/28.
//  Copyright © 2017年 zyc. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {

    var imageV = UIImageView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageV.frame = CGRect(x: contentView.bounds.size.width - 45, y: 5, width: 40, height: 40)
        imageV.backgroundColor = UIColor.gray
        self.contentView.addSubview(imageV)
        
        titleLabel.frame = CGRect(x: 100, y: 5, width: contentView.bounds.size.width - 100 - 45, height: 40)
        titleLabel.backgroundColor = UIColor.gray
        self.contentView.addSubview(titleLabel)
    }
    
    func setData(message: Message) {
        titleLabel.text = message.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
