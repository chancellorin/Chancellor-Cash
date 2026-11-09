//
//  SSLaboratoryLabel.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSLaboratoryLabel: SSLabel {

    weak var laboratoryimv: UIImageView!
    
    var newspaperEvid = SSSherlockNewspaperEvidence() {
        didSet {
            if newspaperEvid.orderDetail?.orderStatus != 60, newspaperEvid.orderDetail?.orderStatus != 61 {
                isHidden = true
                text = ""
            }else {
                isHidden = false
                text = "The UPI payment link is valid for 10 minutes. In order to avoid potential losses, kindly complete repayment using the fresh link generated from the repayment button."
                laboratoryimv.image = newspaperEvid.orderDetail?.orderStatus == 60 ? .newspaperTanorange : .newspaperTanred
                SSSergeantNeed.sergeantColorstring(newspaperEvid.orderDetail?.orderStatus) { color, bgcolor in
                    self.backgroundColor = KKToolUtils.color_from_hex("14\(color)")
                    self.ss_borderColor = KKToolUtils.color_from_hex("36\(color)")
                }
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
        ss_borderWidth = 1
        ss_cornerRadius = 12
        text = "The UPI payment link is valid for 10 minutes. In order to avoid potential losses, kindly complete repayment using the fresh link generated from the repayment button."
        textInsets = UIEdgeInsets(top: 11, left: 38, bottom: 11, right: 13)
        textColor = KKToolUtils.color_from_hex("#FF666666")
        font = KKToolUtils.ubuntu_font(size: 12)
        numberOfLines = 0
        
        let laboratoryimv = UIImageView()
        addSubview(laboratoryimv)
        laboratoryimv.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        self.laboratoryimv = laboratoryimv
    }
}
