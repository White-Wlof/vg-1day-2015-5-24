//
//  PostViewController.swift
//  My1DayApp
//
//  Created by 清 貴幸 on 2015/05/04.
//  Copyright (c) 2015年 VOYAGE GROUP, inc. All rights reserved.
//

import UIKit

protocol PostViewControllerDelagate : NSObjectProtocol {
    func postViewController(viewController : PostViewController, didTouchUpCloseButton: AnyObject)
}

class PostViewController: UIViewController, UIImagePickerControllerDelegate {
    @IBOutlet weak private var messageTextView: UITextView!
    weak var delegate: PostViewControllerDelagate?
    // Mission1-2 Storyboard から UITextField のインスタンス変数を追加
    @IBOutlet weak var textfild: UITextField!
    var selectImage: UIImage!
    var myImagePicker: UIImagePickerController!
//    var myImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    private var myButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextView.becomeFirstResponder()
        myImageView = UIImageView(frame: self.view.bounds)
        
        // Buttonを生成する.
        myButton = UIButton()
        
        // サイズを設定する.
        myButton.frame = CGRectMake(0,0,160,30)
        
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.blackColor()
        
        // 枠を丸くする.
        myButton.layer.masksToBounds = true
        
        // タイトルを設定する(通常時).
        myButton.setTitle("画像取り込み", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 5.0
        
        // ボタンの位置を指定する.
        myButton.layer.position = CGPoint(x: self.view.frame.width/2 + 100, y:80)
        
        // タグを設定する.
        myButton.tag = 1
        
        // イベントを追加する.
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
        
        // インスタンス生成
        myImagePicker = UIImagePickerController()
        
//        // デリゲート設定
//        myImagePicker.delegate = self
        
        // 画像の取得先はフォトライブラリ
        myImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // 画像取得後の編集を不可に
        myImagePicker.allowsEditing = false
    }
    
//    /* 画像をライブラリから取得*/
//    override func viewDidAppear(animated: Bool) {
//        self.presentViewController(myImagePicker, animated: true, completion: nil)
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    ボタンのアクション時に設定したメソッド.
    */
    internal func onClickMyButton(sender: UIButton){
        self.presentViewController(myImagePicker, animated: true, completion: nil)
        
    }

    /**
    画像が選択された時に呼ばれる.
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        //選択された画像を取得.
        var myImage: AnyObject?  = info[UIImagePickerControllerOriginalImage]
        
        //選択された画像を表示するViewControllerを生成.
        let imageViewController = PostViewController()
        
        //選択された画像を表示するViewContorllerにセットする.
        selectImage = myImage as! UIImage
        myImageView.image = selectImage
        myImagePicker.pushViewController(imageViewController, animated: true)
        
        
        
    }
    
    /**
    画像選択がキャンセルされた時に呼ばれる.
    */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        // モーダルビューを閉じる
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - IBAction
    
    @IBAction func didTouchUpCloseButton(sender: AnyObject) {
        self.messageTextView.resignFirstResponder()
        self.delegate?.postViewController(self, didTouchUpCloseButton: sender)
    }
    
    @IBAction func didTouchUpSendButton(sender: AnyObject) {
        self.messageTextView.resignFirstResponder()
        
        let message: String = self.messageTextView.text ?? ""
        // Mission1-2 UITextField のインスタンス変数から値を取得
        let textfild: String = self.textfild.text ?? ""
        
        // Mission1-2 posetMessage の第2引数に 任意の値を渡す
        APIRequest.postMessage(message, username: textfild) {
            [weak self] (data, response, error) -> Void in
            
            self?.delegate?.postViewController(self!, didTouchUpCloseButton: sender)
            
            if error != nil {
                // TODO: エラー処理
                println(error)
                return
            }
            
            var decodeError: NSError?
            let responseBody: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &decodeError)
            if decodeError != nil{
                println(decodeError)
                return
            }
        }
        
    }
}
