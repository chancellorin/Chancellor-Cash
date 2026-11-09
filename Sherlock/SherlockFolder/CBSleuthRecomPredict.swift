//
//  CBSleuthRecomPredict.swift
//  Sherlock
//
//  Created by Alien on 2026/10/22.
//

import UIKit
import KKUtilsKitSwift
import SnapKit
import PureLayout

class CBSleuthRecomPredict: SSSherlockPredict {

    static func sleuth_loading() {
        let deduc = CBSleuthRecomPredict()
        KKToolUtils.key_window?.addSubview(deduc)
        deduc.autoPinEdgesToSuperviewEdges()
    }
    
    static func sleuth_dismiss() {
        for winsub in KKToolUtils.key_window?.subviews ?? [] {
            if winsub is CBSleuthRecomPredict {
                winsub.removeFromSuperview()
                break
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sleuth_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sleuth_stepui()
    }
    
    func sleuth_stepui() {
        sherlockliv.image = .sherlockTopgreen
        
        let sleuthti = UILabel()
        sleuthti.textColor = .white
        sleuthti.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        sleuthti.text = "Matching in progress..."
        sleuthti.textAlignment = .center
        sherlockbgv.addSubview(sleuthti)
        sleuthti.snp.makeConstraints { make in
            make.top.equalTo(sherlockliv.snp.bottom).offset(31)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(20)
        }
        
        let sleuthtip = UILabel()
        sleuthtip.textColor = KKToolUtils.color_from_hex("#666666")
        sleuthtip.font = KKToolUtils.ubuntu_font(size: 13)
        sleuthtip.numberOfLines = 0
        sleuthtip.text = "We are reviewing your profile to provide more suitable products. Priority matching in progress, estimated time: 10 seconds..."
        sleuthtip.lineSpace()
        sherlockbgv.addSubview(sleuthtip)
        sleuthtip.snp.makeConstraints { make in
            make.top.equalTo(sleuthti.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-13)
        }
        
    }
    
}
