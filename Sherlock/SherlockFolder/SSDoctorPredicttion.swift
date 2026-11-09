//
//  SSDoctorPredicttion.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSDoctorPredicttion: UIView {
    
    weak var doctortv: SSDoctorTextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        doctor_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doctor_stepui()
    }
    
    func doctor_stepui() {
        let doctorti = UILabel()
        doctorti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        doctorti.text = "Your question"
        doctorti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(doctorti)
        doctorti.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let doctortv = SSDoctorTextView()
        addSubview(doctortv)
        doctortv.snp.makeConstraints { make in
            make.right.bottom.left.equalToSuperview()
            make.top.equalTo(doctorti.snp.bottom).offset(7)
        }
        self.doctortv = doctortv
    }

}
