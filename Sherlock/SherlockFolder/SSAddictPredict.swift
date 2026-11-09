//
//  SSTerroristPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/30.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSAddictPredict: SSSherlockImvPredict {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addict_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addict_stepui()
    }
    
    func addict_stepui() {
        sherlockliv.image = .sherlockTopred
        sherlockimv.image = .alertFailimg
        sherlockti.text = "Verification failed"
        sherlocktip.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-320)
        }
        sherlockbtt.isHidden = false
        sherlockbtt.backgroundColor = KKToolUtils.color_from_hex("#FF4444")
        sherlockbtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#66FF4444"))
        
        let addictip = UILabel()
        addictip.text = "Verification failed. Please upload the photo again."
        addictip.textColor = .white
        addictip.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        addictip.textAlignment = .center
        sherlockbgv.addSubview(addictip)
        addictip.snp.makeConstraints { make in
            make.left.right.equalTo(sherlockti)
            make.top.equalTo(sherlockti.snp.bottom)
            make.height.equalTo(27)
        }
        
        let addictstack = UIStackView()
        addictstack.axis = .vertical
        addictstack.spacing = 0
        addictstack.distribution = .fill
        sherlockbgv.addSubview(addictstack)
        addictstack.snp.makeConstraints { make in
            make.top.equalTo(addictip.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
        
        let addictims: [UIImage] = [.addictInfo1, .addictInfo2, .addictInfo3]
        let addicttis = ["The ID photo is too small.", "The ID is partially covered.", "Clear and unobstructed"]

        for i in 0..<3 {
            let addictinfo = SSAddictPredictinfo()
            addictinfo.addictimv.image = addictims[i]
            addictinfo.addictinfo.text = addicttis[i]
            if i == 2 {
                addictinfo.addictinfo.textColor = KKToolUtils.color_from_hex("#00A63E")
            }
            addictstack.addArrangedSubview(addictinfo)
        }

    }
    
    override func sherlockbttap() {
        self.removeFromSuperview()
    }

}
