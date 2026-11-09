//
//  SSWatsonPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import SnapKit
import KKCameraKitSwift

class SSWatsonPredict: UIView {
    
    var watsoncam = KKCameraView()
    var watsoncaimg: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        watson_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        watson_stepui()
    }
    
    func watson_stepui() {
        watsoncam.cameraPosition = .back
        addSubview(watsoncam)
        watsoncam.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        watsoncam.photoCaptureCompletion = { holm in
            self.watsoncaimg = holm
        }
        
        let watsonimv = UIImageView(image: .watsonBordimg.rotateRight90())
        addSubview(watsonimv)
        watsonimv.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
