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
        
//        UIWindow.ace.showLoading(darkStyle: true)
        
//        ace_delay(by: 3.5) {
//            UIWindow.ace.showLoading(message: "正在测试...",
//                                     darkStyle: true)
//        }
        
//        ace_delay(by: 8.5) {
//
//            UIWindow.ace.showLoading(message: "继续在测试...Created by ac_m1a on 2020/12/20Created by ac_m1a on 2020/12/20Created by ac_m1a on 2020/12/20Created by ac_m1a on 2020/12/20",
//                                     darkStyle: true)
//            debugPrint("check blink")
//
////            UIAlertController.ace.showAlert(
////                inVC: self,
////                darkStyle: true,
////                titleText: "test",
////                messageText: "some msg",
////                cancelTuple: ("cancel", { (action) in
////                    debugPrint("cancel")
////                }),
////                normalActionTuples:  [
////                    ("ok", { (action) in
////                        debugPrint("ok")
////                    })
////                ]
////            )
//
//        }
        
//        ace_delay(by: 1.5) {
//            UIAlertController.ace.showInputAlert(
//                inVC: self,
//                darkStyle: true,
//                titleText: "test input",
//                messageText: "input sth",
//                inputInfoTuples: [("tf1", UIKeyboardType.numberPad),
//                                  ("tf2", UIKeyboardType.default)],
//                confirmTuple: ("add", { (action, results) in
//                    debugPrint(results)
//                }),
//                cancelTuple: ("cancel", { (action) in
//                    debugPrint("did cancel")
//                })
//            )
//
//        }
        
        
        ace_delay(by: 1.0) {
            UIAlertController.ace.showToast(messageText: "find top and show")
        }
    }


}


extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))

        self.present(alert, animated: true, completion: nil)
    }
}

