//
//  SSSleuthTableCellmv.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSSleuthTableCellmv: UIView {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        sleuth_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sleuth_stepui()
    }
    
    func sleuth_stepui() {
        
        ss_cornerRadius = 12
        backgroundColor = KKToolUtils.color_from_hex("#1A1A1A")
        
        let sleuthrir = UILabel()
        sleuthrir.text = "Daily Rate"
        sleuthrir.textColor = KKToolUtils.color_from_hex("#555555")
        sleuthrir.font = KKToolUtils.ubuntu_font(size: 11)
        addSubview(sleuthrir)
        sleuthrir.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        sleuthrir.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        sleuthrir.autoSetDimension(.height, toSize: 17)
        
        
        let sleuthrirm = UILabel()
        sleuthrirm.textColor = KKToolUtils.color_from_hex("#AAFF00")
        sleuthrirm.text = "0.04%"
        sleuthrirm.font = KKToolUtils.ubuntu_font(size: 18, weight: .bold)
        addSubview(sleuthrirm)
        sleuthrirm.autoPinEdge(.left, to: .left, of: sleuthrir)
        sleuthrirm.autoPinEdge(.top, to: .bottom, of: sleuthrir)
        sleuthrirm.autoSetDimension(.height, toSize: 27)
        
        let sleuthline = UIView()
        sleuthline.backgroundColor = KKToolUtils.color_from_hex("#252525")
        addSubview(sleuthline)
        sleuthline.autoPinEdge(toSuperviewEdge: .top)
        sleuthline.autoPinEdge(toSuperviewEdge: .bottom)
        sleuthline.autoSetDimension(.width, toSize: 1)
        sleuthline.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let sleuthqr = UILabel()
        sleuthqr.textColor = KKToolUtils.color_from_hex("#555555")
        sleuthqr.text = "Max Term"
        sleuthqr.font = KKToolUtils.ubuntu_font(size: 11)
        addSubview(sleuthqr)
        sleuthqr.autoPinEdge(.left, to: .right, of: sleuthline, withOffset: 14)
        sleuthqr.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        sleuthqr.autoSetDimension(.height, toSize: 17)


        let sleuthqrm = UILabel()
        sleuthqrm.textColor = KKToolUtils.color_from_hex("#CCCCCC")
        sleuthqrm.text = "360 days"
        sleuthqrm.font = KKToolUtils.ubuntu_font(size: 18, weight: .bold)
        addSubview(sleuthqrm)
        sleuthqrm.autoPinEdge(.left, to: .left, of: sleuthqr)
        sleuthqrm.autoPinEdge(.top, to: .bottom, of: sleuthqr)
        sleuthqrm.autoSetDimension(.height, toSize: 27)

    }

}
