//
//  SSSherlockImvPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/30.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

enum SherlockBtnType: Int {
    case sherlockout
    case sherlockdelete
    case sherlockdelsucc
    case sherlockdelfail
    case sherlockback
    case sherlockwithd
    case sherlockwithdsucc
    case sherlockup
    case sherlockmandup
}

class SSSherlockImvPredict: SSSherlockPredict {

    weak var sherlockimv: UIImageView!
    weak var sherlocktip: SSLabel!
    weak var sherlockti: UILabel!
    
    var sherlockmortip: String = ""
    var sherlockback: (() -> Void)?
    var sherlockwithdback: (() -> Void)?
    var sherlockwithdto: (() -> Void)?
    var sherlockwithdsucc: (() -> Void)?

    var sherlocktype: SherlockBtnType = .sherlockout {
        didSet {
            sherlockrefrash(sherlocktype)
        }
    }
    
    var sherlockupEvid = SSSherlockPublicsysedyEvidence()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sherlockimv_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sherlockimv_stepui()
    }
    
    func sherlockimv_stepui() {
        let sherlockimv = UIImageView()
        sherlockbgv.addSubview(sherlockimv)
        sherlockimv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 55, height: 55))
        }
        self.sherlockimv = sherlockimv
        
        let sherlockti = UILabel()
        sherlockti.textAlignment = .center
        sherlockti.textColor = .white
        sherlockti.font = KKToolUtils.ubuntu_font(size: 17, weight: .bold)
        sherlockbgv.addSubview(sherlockti)
        sherlockti.snp.makeConstraints { make in
            make.top.equalTo(sherlockimv.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(26)
        }
        self.sherlockti = sherlockti
        
        let sherlocktip = SSLabel()
        sherlocktip.textColor = KKToolUtils.color_from_hex("#666666")
        sherlocktip.font = KKToolUtils.ubuntu_font(size: 13)
        sherlocktip.numberOfLines = 0
        sherlocktip.ss_borderColor = .clear
        sherlocktip.ss_borderWidth = 1
        sherlocktip.ss_cornerRadius = 12
        sherlockbgv.addSubview(sherlocktip)
        sherlocktip.snp.makeConstraints { make in
            make.top.equalTo(sherlockimv.snp.bottom).offset(53)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-87)
        }
        self.sherlocktip = sherlocktip
    }

    
    override func sherlockbttap() {
        sherlockbttapd()
    }
    
    override func sherlocklebttap() {
        sherlocklebttapd()
    }
    
    override func sherlockribttap() {
        sherlockribttapd()
    }
    
}
