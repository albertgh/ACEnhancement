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
        
        ace_delay(by: 0.5) {
            
            UIAlertController.ace.showAlert(
                inVC: self,
                darkStyle: true,
                titleText: "test",
                messageText: "some msg",
                cancelTuple: ("cancel", { (action) in
                    debugPrint("cancel")
                }),
                normalActionTuples:  [
                    ("ok", { (action) in
                        debugPrint("ok")
                    })
                ]
            )
            
        }
    }


}

