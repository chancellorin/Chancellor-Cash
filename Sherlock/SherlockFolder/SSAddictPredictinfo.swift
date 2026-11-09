//
//  SSAddictPredictinfo.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/30.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSAddictPredictinfo: UIView {
    
    weak var addictimv: UIImageView!
    weak var addictinfo: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        addict_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addict_stepui()
    }
    
    func addict_stepui() {
        let addictimv = UIImageView()
        addSubview(addictimv)
        addictimv.autoPinEdge(toSuperviewEdge: .left, withInset: 22)
        addictimv.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        addictimv.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        addictimv.autoSetDimensions(to: CGSize(width: 80, height: 54))
        self.addictimv = addictimv
        
        let addictinfo = UILabel()
        addictinfo.font = KKToolUtils.ubuntu_font(size: 14, weight: .medium)
        addictinfo.textColor = KKToolUtils.color_from_hex("#FB2C36")
        addictinfo.numberOfLines = 0
        addSubview(addictinfo)
        addictinfo.autoPinEdge(.left, to: .right, of: addictimv, withOffset: 16)
        addictinfo.autoPinEdge(.top, to: .top, of: addictimv)
        addictinfo.autoPinEdge(.bottom, to: .bottom, of: addictimv)
        addictinfo.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
        self.addictinfo = addictinfo
    }

}
