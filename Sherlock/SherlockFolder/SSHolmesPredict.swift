//
//  SSHolmesPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKUtilsKitSwift
import KKCameraKitSwift
import PureLayout

class SSHolmesPredict: UIView {
    
    var holmescam = KKCameraView()
    var holmesface: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        holmes_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        holmes_stepui()
    }
    
    func holmes_stepui() {
        backgroundColor = KKToolUtils.color_from_hex("#FF0A0E05")
        ss_borderColor = KKToolUtils.color_from_hex("#61AAFF00")
        ss_borderWidth = 2
        ss_cornerRadius = (UIScreen.main.bounds.width - 28)*0.5
        
        addSubview(holmescam)
        holmescam.autoPinEdgesToSuperviewEdges()
        holmescam.photoCaptureCompletion = { holm in
            self.holmesface = holm
        }
    }

}
