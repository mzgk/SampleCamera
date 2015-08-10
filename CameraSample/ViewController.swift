//
//  ViewController.swift
//  CameraSample
//
//  Created by Mizugaki on 2015/08/07.
//  Copyright (c) 2015年 TAMA PROJECT. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var overlayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     * カメラの上に独自のViewを乗せる
     * http://chicketen.blog.jp/archives/7404852.html
     * .xibは背景を透明にする
     * 画像はalphaを0.5などに指定し、背景（カメラファインダー）が透けるようにする
     */

    // カメラが回転する版
    @IBAction func runCamera(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeMovie]
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video
//            picker.videoQuality = UIImagePickerControllerQualityType.TypeIFrame1280x720
            picker.videoQuality = UIImagePickerControllerQualityType.TypeHigh
            picker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            picker.allowsEditing = true
            picker.showsCameraControls = true   // 完全にカスタム画面を使う場合はfalseにする

            // カメラ上にViewを表示させる
            let overlayView: UIView = UINib(nibName: "OverlayView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
            overlayView.frame = picker.view.frame
            picker.cameraOverlayView = overlayView

            self.presentViewController(picker, animated: true, completion: nil)
        }
        else {
            println("カメラは使えません")
        }

    }

    // UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)

        if let url = info[UIImagePickerControllerMediaURL] as? NSURL {
            UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, "finishSaveVideo:didFinishSavingWithError:contextInfo:", nil)
        }
    }

    // 保存の結果判定
    func finishSaveVideo(videoPath: String, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if (error != nil) {
            println("動画の保存に失敗しました。")
        } else {
            println("動画の保存に成功しました。")
        }
    }

    // カメラの回転を許さない版
    // 回転固定のカメラ起動（カメラの回転を抑止するためには、UIImagePickerControllerを継承したサブクラスを作成し、そこに抑止処理を記述する必要あり）
    @IBAction func fixedCamera(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            // 回転抑止のために作成したサブクラスを呼び出す
            let picker = CameraViewController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeMovie]
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video
            picker.videoQuality = UIImagePickerControllerQualityType.TypeHigh
            picker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            picker.allowsEditing = true
            picker.showsCameraControls = true

            // OverlayViewを作成し、セットする
            let overlayView: UIView = UINib(nibName: "OverlayView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
            overlayView.frame = picker.view.frame
            picker.cameraOverlayView = overlayView

            self.presentViewController(picker, animated: true, completion: nil)
        }
        else {
            println("カメラは使えません")
        }
    }

    
}

