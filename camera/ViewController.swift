//
//  ViewController.swift
//  camera
//
//  Created by 小野瀬萌 on 2018/08/02.
//  Copyright © 2018年 小野瀬萌. All rights reserved.
//

import UIKit
import Photos
//☁️なんでnavigationcontrollerdelegateが必要かわからない
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userに許可を促す
        //ここのcase文はもし認証が弾かれたときにもう一度アラート出したりとかの設定にも使える
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized:
                print("authorized")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            }
        }
    }
    
    
    //カメラもアルバムも構造はほぼ一緒
    @IBAction func camera(_ sender: Any) {
        //カメラを利用することを定義
        let sourceType: UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        //カメラが利用できるかチェック
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            //カメラ起動画面初期化
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.sourceType = sourceType
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
  
    @IBAction func album(_ sender: Any) {
        //アルバムを利用することを定義
        let sourceType: UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        //アルバムが利用できるかチェック
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            //アルバム起動画面初期化
            let albumPicker = UIImagePickerController()
            albumPicker.delegate = self
            albumPicker.sourceType = sourceType
            self.present(albumPicker, animated: true, completion: nil)
    }
    }
    
    //アルバムやカメラで画像が選択されたり撮影されたときに呼び出されるメソッド
    func imagePickerController(_ pickedImage: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            //<#T##completionTarget: Any?##Any?#>, <#T##completionSelector: Selector?##Selector?#>, <#T##contextInfo: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
        }
        //カメラの起動画面を閉じる
        pickedImage.dismiss(animated: true, completion: nil)
        }
    //撮影中にキャンセルされるときの挙動
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

