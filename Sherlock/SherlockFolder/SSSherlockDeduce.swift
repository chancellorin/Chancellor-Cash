//
//  SSSherlockDeduce.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/3.
//

import UIKit
import SVProgressHUD
import KKUtilsKitSwift

struct SSSherlockDeduce {
    public static func ss_deduce() {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }

    
    public static func ss_deduce(_ lock: String? = nil, delay: Double = 2, isbusy: Bool = false) {
        if isbusy == false, lock == nil {
            ss_deducemiss()
            return
        }
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setImageViewSize(.zero)
        SVProgressHUD.dismiss(withDelay: delay)
        SVProgressHUD.show(UIImage(), status: lock ?? "The system is busy. Please try again in 2 minutes.")
    }
    
    public static func ss_deducemiss() {
        SVProgressHUD.dismiss()
    }
}
