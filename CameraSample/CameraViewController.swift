//
//  CameraViewController.swift
//  CameraSample
//
//  Created by Mizugaki on 2015/08/10.
//  Copyright (c) 2015年 TAMA PROJECT. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIImagePickerController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    /*
     * カメラの回転を抑止するために、UIImagePickerControllerを継承した当サブクラスを作成し
     * 抑止処理を記述する
     * http://qiita.com/satoshi0212/items/764469910d63b5eedc9a
     * http://qiita.com/osamu1203/items/d175b93b3ada1486beda
     */

    // 向きの自動を許可するか？
    override func shouldAutorotate() -> Bool {
        return false
    }

    // サポートする向きを指定する（LandscapeRight：ホームボタンが右側）
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
    }

    // カメラに関する設定部分
    func setupCamera() {
        self.sourceType = UIImagePickerControllerSourceType.Camera
        self.mediaTypes = [kUTTypeMovie]
        self.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video
        self.videoQuality = UIImagePickerControllerQualityType.TypeHigh
        self.cameraDevice = UIImagePickerControllerCameraDevice.Rear
        self.allowsEditing = true
        self.showsCameraControls = true

        let overlayView: UIView = UINib(nibName: "OverlayView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        overlayView.frame = self.view.frame
        self.cameraOverlayView = overlayView
    }
}
