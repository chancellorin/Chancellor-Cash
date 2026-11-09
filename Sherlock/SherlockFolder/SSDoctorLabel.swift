//
//  SSDoctorLabel.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift

class SSDoctorLabel: SSLabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doctor_stepui()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doctor_stepui()
    }
    
    func doctor_stepui() {
        textInsets = UIEdgeInsets(top: 13, left: 15, bottom: 13, right: 15)
        text = "You may describe your issue in detail here, or email us your problem along with your contact details. We will get back to you promptly!"
    }
    
    
}
