//
//  ViewController.swift
//  NotificationStartSample
//
//  Created by 藤井陽介 on 2019/02/10.
//  Copyright © 2019 touyou. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // アプリが終了していた場合
        if appDelegate.isLocalStart {
            performSegue(withIdentifier: "toLocal", sender: nil)
            appDelegate.isLocalStart = false
        } else {
            // 起動する度enteredForegroundが呼ばれるようにする
            NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        }
    }

    // アプリが終了した時に解除しておく
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // アプリが再びアクティブになった時
    @objc func didBecomeActive() {
        if appDelegate.isLocalStart {
            performSegue(withIdentifier: "toLocal", sender: nil)
            appDelegate.isLocalStart = false
        }
    }

    @IBAction func tappedSetNotificationButton(_ sender: Any) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Test"
        content.body = "タップするとアプリを起動"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: "notification_start_sample", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        let alertController = UIAlertController(title: "Set Notification", message: "You set notification.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

