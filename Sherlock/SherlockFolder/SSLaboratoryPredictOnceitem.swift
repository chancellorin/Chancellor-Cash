//
//  SSLaboratoryPredictOnceitem.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSLaboratoryPredictOnceitem: UIView {

    weak var laboratoryti: UILabel!
    weak var laboratorylue: UILabel!
    weak var laboratoryuni: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        
        let laboratoryti = UILabel()
        laboratoryti.textColor = KKToolUtils.color_from_hex("#FF555555")
        laboratoryti.font = KKToolUtils.ubuntu_font(size: 11)
        addSubview(laboratoryti)
        laboratoryti.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(11)
            make.height.equalTo(17)
        }
        self.laboratoryti = laboratoryti
        
        let laboratorylue = UILabel()
        laboratorylue.textColor = .white
        laboratorylue.font = KKToolUtils.ubuntu_font(size: 20, weight: .bold)
        addSubview(laboratorylue)
        laboratorylue.snp.makeConstraints { make in
            make.left.equalTo(laboratoryti)
            make.top.equalTo(laboratoryti.snp.bottom).offset(2)
            make.height.equalTo(30)
        }
        self.laboratorylue = laboratorylue
        
        let laboratoryuni = UILabel()
        laboratoryuni.isHidden = true
        laboratoryuni.textColor = KKToolUtils.color_from_hex("#FF555555")
        laboratoryuni.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        laboratoryuni.text = "Days"
        addSubview(laboratoryuni)
        laboratoryuni.snp.makeConstraints { make in
            make.left.equalTo(laboratorylue.snp.right).offset(2)
            make.bottom.equalTo(laboratorylue)
            make.height.equalTo(23)
        }
        self.laboratoryuni = laboratoryuni

    }

}
