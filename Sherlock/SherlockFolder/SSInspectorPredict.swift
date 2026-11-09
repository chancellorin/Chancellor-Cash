//
//  SSInspectorPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import PureLayout
import KKUtilsKitSwift
import KKDeviceInsightKitSwift

class SSInspectorPredict: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inspector_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        inspector_stepui()
    }
    
    func inspector_stepui() {
        let inspicon = UIImageView(image: UIImage(named: "Chancellor_icon"))
        addSubview(inspicon)
        inspicon.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
        inspicon.autoSetDimensions(to: CGSizeMake(88, 88))
        inspicon.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let inspname = UILabel()
        inspname.font = KKToolUtils.ubuntu_font(size: 22, weight: .bold)
        inspname.textColor = .white
        inspname.text = "Chancellor Cash"
        addSubview(inspname)
        inspname.autoPinEdge(.top, to: .bottom, of: inspicon, withOffset: 12)
        inspname.autoSetDimension(.height, toSize: 33)
        inspname.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let inspvs = SSLabel()
        inspvs.textInsets = UIEdgeInsets(top: 9, left: 17, bottom: 9, right: 9)
        inspvs.backgroundColor = KKToolUtils.color_from_hex("#30AAFF00")
        inspvs.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
        inspvs.textColor = KKToolUtils.color_from_hex("#AAFF00")
        
        inspvs.text = "Version V \(KKApplicationInfo.application_version)"
        inspvs.ss_cornerRadius = 18
        inspvs.ss_borderColor = KKToolUtils.color_from_hex("#12AAFF00")
        inspvs.ss_borderWidth = 1
        addSubview(inspvs)
        inspvs.autoPinEdge(.top, to: .bottom, of: inspname, withOffset: 12)
        inspvs.autoSetDimension(.height, toSize: 36)
        inspvs.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let inspintrod = SSLabel()
        inspintrod.textInsets = UIEdgeInsets(top: 17, left: 17, bottom: 17, right: 17)
        inspintrod.backgroundColor = KKToolUtils.color_from_hex("#161616")
        inspintrod.textColor = KKToolUtils.color_from_hex("#666666")
        inspintrod.ss_cornerRadius = 16
        inspintrod.ss_borderColor = KKToolUtils.color_from_hex("#222222")
        inspintrod.ss_borderWidth = 1
        inspintrod.numberOfLines = 0
        inspintrod.text = "Chancellor Cash is built for everyday financial convenience.We offer financial solutions that adapt to changing needs."
        addSubview(inspintrod)
        inspintrod.autoPinEdge(.top, to: .bottom, of: inspvs, withOffset: 42)
        inspintrod.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        inspintrod.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
        inspintrod.autoPinEdge(toSuperviewEdge: .bottom, withInset: 14)
    }

}
