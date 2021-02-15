//
//  UIViewControllerExtension.swift
//  E-commerce App
//
//  Created by taima on 9/28/19.
//  Copyright © 2019 mac air. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
import SVProgressHUD

func digitsCode(numOfDigits: Int) -> String {
    let arrletters = Array("0123456789")
    var code = ""
    for _ in  1...numOfDigits {
        code += String(arrletters.randomElement() ?? " ")
    }
    return code
}
extension UIViewController {
    
    
    
    
    func showAlert(title: String, message: String,button1title: String = "ok", button2title: String = "cansel",button1style: UIAlertAction.Style = .default, button2style: UIAlertAction.Style = .default, button1action: @escaping (()->Void), button2action: @escaping (()->Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let button1 = UIAlertAction.init(title: button1title, style: button1style) { (action) in
            button1action()
        }
        let button2 = UIAlertAction.init(title: button2title, style: button2style) { (action) in
            button2action()
        }
        alert.addAction(button1)
        alert.addAction(button2)
        self.present(alert, animated:true, completion: nil)
    }
    func showErrorAlert (message: String){
        showAlert(title: "Error", message: message, button1action: {
            
        }) {
            
        }
    }
    
    func SuccessMessage(title:String? , successbody:String?){
        let Successview = MessageView.viewFromNib(layout: .messageView)
        Successview.configureTheme(.success)
        Successview.configureContent(title: title!, body: successbody!)
        Successview.button?.isHidden = true
        SwiftMessages.show(view: Successview)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            SwiftMessages.hideAll()
        }
    }
    
    func ErrorMessage(title:String? , errorbody:String?){
        let Errorview = MessageView.viewFromNib(layout: .cardView)
        Errorview.configureTheme(.error)
//        Errorview.configureContent(title: "", body: errorbody, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: NSLocalizedString("Hide", comment: ""), buttonTapHandler: { _ in SwiftMessages.hide() })
        Errorview.configureContent(title: title!, body: errorbody!)
        SwiftMessages.show(view: Errorview)
        Errorview.button?.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            SwiftMessages.hideAll()
        }
    }
    
    func NoticMessage(title:String? , noticbody:String?){
        let Noticview = MessageView.viewFromNib(layout: .centeredView)
        Noticview.configureTheme(.warning)
        Noticview.configureContent(title: title, body: noticbody, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: NSLocalizedString("Hide", comment: ""), buttonTapHandler: { _ in SwiftMessages.hide() })
        SwiftMessages.show(view: Noticview)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            SwiftMessages.hideAll()
        }
    }
    
    func SuccessOrderMessage(title:String? , successbody:String?){
        let SuccessRview = MessageView.viewFromNib(layout: .centeredView)
        SuccessRview.configureTheme(.success)
        SuccessRview.configureContent(title: title!, body: successbody!)
        SuccessRview.button?.isHidden = true
        SwiftMessages.show(view: SuccessRview)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            SwiftMessages.hideAll()
            //self.GoToHome()
        }
    }
    
    func reloadButton() {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
          button.backgroundColor = .green
          button.setTitle("Test Button", for: .normal)
          button.addTarget(self, action: #selector(reloadAction), for: .touchUpInside)
          self.view.addSubview(button)
    }
    
    @objc func reloadAction() {
        
    }
    
     func showLoader(_ isShowLoader: Bool) {
        if isShowLoader {
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setForegroundColor("1E92C4".color_)
            SVProgressHUD.setBackgroundColor(UIColor.white)
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }

    
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


import SystemConfiguration

public class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}
