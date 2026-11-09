//
//  SSLaboratoryPredictbank.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

class SSLaboratoryPredictbank: UIView {
    
    weak var laboratorycode: UILabel!
    
    var evid = SSSherlockPublicsysedyEvidence() {
        didSet {
            laboratorycode.text = KKToolUtils.format_card(evid.accountNo)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        backgroundColor = KKToolUtils.color_from_hex("#FF161616")
        ss_cornerRadius = 14
        
        let laboratoryimv = UIImageView(image: .laboratoryBankimg)
        addSubview(laboratoryimv)
        laboratoryimv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 18, height: 18))
            make.left.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        let laboratoryti = UILabel()
        laboratoryti.text = "Bank Account"
        laboratoryti.textColor = KKToolUtils.color_from_hex("#FF888888")
        laboratoryti.font = KKToolUtils.ubuntu_font(size: 13)
        addSubview(laboratoryti)
        laboratoryti.snp.makeConstraints { make in
            make.left.equalTo(laboratoryimv.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
        }
        
        let laboratorycode = UILabel()
        laboratorycode.textColor = KKToolUtils.color_from_hex("#FFCCCCCC")
        laboratorycode.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        addSubview(laboratorycode)
        laboratorycode.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        self.laboratorycode = laboratorycode
    }

}
