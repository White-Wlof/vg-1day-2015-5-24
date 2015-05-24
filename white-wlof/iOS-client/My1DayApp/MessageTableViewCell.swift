//
//  MessageTableViewCell.swift
//  My1DayApp
//
//  Created by 清 貴幸 on 2015/04/24.
//  Copyright (c) 2015年 VOYAGE GROUP, inc. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak private var iconImageView: UIImageView!
    // Mission1-1 UILabel のインスタンス変数を追加
    @IBOutlet weak var created_atLabel: UILabel!
    
    @IBOutlet weak var messageimage: UIImageView!
    override func prepareForReuse() {
        self.iconImageView.image = nil
        self.messageimage.image = nil
        // Mission1-1 UILabel のインスタンス変数を初期化
        self.created_atLabel.text = nil
    }
    
    func setupComponentsWithMessage(message: Message) {
        self.iconImageView.image = message.icon
        self.messageimage.image = message.messageImage
        // Mission1-1 UILabel のインスタンス変数に created_at の値を代入
        self.created_atLabel.text = message.created_at
    }
}
