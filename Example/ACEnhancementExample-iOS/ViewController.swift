//
//  ViewController.swift
//  ACEnhancementExample-iOS
//
//  Created by ac_m1a on 2020/12/20.
//

import UIKit

import ACEnhancement

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UIWindow.ace.showLoading(darkStyle: true)
        
        ace_delay(by: 3.5) {
            UIWindow.ace.showLoading(message: "正在测试...",
                                     darkStyle: true)
        }
        
        ace_delay(by: 8.5) {
            
            UIWindow.ace.showLoading(message: "继续在测试...Created by ac_m1a on 2020/12/20Created by ac_m1a on 2020/12/20Created by ac_m1a on 2020/12/20Created by ac_m1a on 2020/12/20",
                                     darkStyle: true)
            debugPrint("check blink")

//            UIAlertController.ace.showAlert(
//                inVC: self,
//                darkStyle: true,
//                titleText: "test",
//                messageText: "some msg",
//                cancelTuple: ("cancel", { (action) in
//                    debugPrint("cancel")
//                }),
//                normalActionTuples:  [
//                    ("ok", { (action) in
//                        debugPrint("ok")
//                    })
//                ]
//            )
            
        }
    }


}

