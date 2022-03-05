//
//  AlertService.swift
//  Remainder_Practice
//
//  Created by Ravikumar on 02/03/22.
//

import UIKit


class AlertService {
    
    private  init(){}
    static func actionSheet(in vc:UIViewController, title:String, completion: @escaping() -> Void) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
        completion()
        }
        alert.addAction(action)
        if let keyWindow = UIWindow.key {
            keyWindow.rootViewController?.present(alert, animated: true)
        }
    }
}
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}













































































