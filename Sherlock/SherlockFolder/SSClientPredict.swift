//
//  SSClientPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSClientPredict: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        client_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        client_stepui()
    }
    
    func client_stepui() {

        let clientimv = UIImageView(image: .clientTopimg)
        addSubview(clientimv)
        clientimv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSizeMake(121, 121))
        }
        
        let clientintrod = SSLabel()
        clientintrod.textInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        clientintrod.text = "In the event of malfunctions within the application, loan applications and repayment services can be accessed through the official website. We recommend retaining the official website URL, click to copy."
        clientintrod.textColor = KKToolUtils.color_from_hex("#FF777788")
        clientintrod.font = KKToolUtils.ubuntu_font(size: 13)
        clientintrod.backgroundColor = KKToolUtils.color_from_hex("#08AAFF00")
        clientintrod.ss_borderColor = KKToolUtils.color_from_hex("#21AAFF00")
        clientintrod.ss_borderWidth = 1
        clientintrod.ss_cornerRadius = 14
        clientintrod.numberOfLines = 0
        addSubview(clientintrod)
        clientintrod.snp.makeConstraints { make in
            make.top.equalTo(clientimv.snp.bottom).offset(23)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalTo(-4)
        }
    }

}
