//
//  SSLaboratoryPredictMoreinfo.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSLaboratoryPredictMoreinfo: UIView {
    
    weak var laboratoryimv: UIImageView!
    weak var laboratoryna: UILabel!

    var laborEvid = SSSherlocklistEvidence()
    
    func laboratoryAddmoreinfo() {
        SSSherlockAnalysis.ss_sherlockimgv(lock: laborEvid.productLogo, on: laboratoryimv)
        laboratoryna.text = laborEvid.productName
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
        ss_cornerRadius = 16
        
        let laboratoryimv = UIImageView()
        laboratoryimv.contentMode = .scaleAspectFill
        laboratoryimv.ss_cornerRadius = 12
        addSubview(laboratoryimv)
        laboratoryimv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(14)
            make.width.height.equalTo(40)
        }
        self.laboratoryimv = laboratoryimv
        
        let laboratoryna = UILabel()
        laboratoryna.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        laboratoryna.textColor = .white
        addSubview(laboratoryna)
        laboratoryna.snp.makeConstraints { make in
            make.top.bottom.equalTo(laboratoryimv)
            make.left.equalTo(laboratoryimv.snp.right).offset(12)
        }
        self.laboratoryna = laboratoryna
    }

}
