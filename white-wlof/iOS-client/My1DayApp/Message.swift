//
//  Message.swift
//  My1DayApp
//
//  Created by 清 貴幸 on 2015/05/15.
//  Copyright (c) 2015年 VOYAGE GROUP, inc. All rights reserved.
//

import UIKit

class Message {
    let messageImage: UIImage!
    let icon: UIImage?
    // Mission1-1. created_at 用のインスタンス変数を追加
    let created_at: String!
    init?(dictionary: [String: AnyObject]) {
        // Mission1-1 Dictionary から key:created_at の値を取得
        if let messageImage: UIImage = dictionary["messageImage"] as? UIImage, let icon: String = dictionary["icon"] as? String ,let created_at: String = dictionary["created_at"] as? String{
            self.messageImage = messageImage
            self.icon = ImageHelper.imageWithBase64EncodedString(icon)
            // Mission1-1 Dictionary から取得した値を created_at 用のインスタンス変数に追加
            self.created_at = created_at
        } else {
            self.messageImage = nil
            self.icon = nil
            // Mission1-1 インスタンス変数を nil で初期化
            self.created_at = nil
            return nil
        }
    }
}
