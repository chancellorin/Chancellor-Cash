//
//  SSDiplomatPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSDiplomatPredict: UIView {

    weak var diplomatti: UILabel!
    weak var diplomatopt: UILabel!
    
    weak var diplomatap: SSDiplomatPredictfd!
    
    var diplomatEvid: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            diplomatti.text = diplomatEvid.itemName
            diplomatopt.isHidden = diplomatEvid.isRequired == 1
            diplomatap.diplomatEvid = diplomatEvid
        }
    }
    
    var diplomatchange: ((SSSherlockDiplomatEvidence) -> Void)?
    var diplomatff: (() -> Void)?
    var diplomatffind: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        diplomat_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        diplomat_stepui()
    }
    
    func diplomat_stepui() {
        let diplomatti = UILabel()
        diplomatti.textColor = .white
        diplomatti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        diplomatti.adjustsFontSizeToFitWidth = true
        diplomatti.minimumScaleFactor = 0.5
        addSubview(diplomatti)
        diplomatti.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.height.equalTo(20)
        }
        self.diplomatti = diplomatti
        
        let diplomatopt = SSLabel()
        diplomatopt.backgroundColor = KKToolUtils.color_from_hex("#FF222222")
        diplomatopt.isHidden = true
        diplomatopt.text = "Optional"
        diplomatopt.textColor = KKToolUtils.color_from_hex("#FF444444")
        diplomatopt.font = KKToolUtils.ubuntu_font(size: 11)
        diplomatopt.textInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        diplomatopt.ss_cornerRadius = 5
        addSubview(diplomatopt)
        diplomatopt.snp.makeConstraints { make in
            make.left.equalTo(diplomatti.snp.right).offset(6)
            make.centerY.equalTo(diplomatti)
            make.height.equalTo(19)
        }
        self.diplomatopt = diplomatopt
        
        let diplomatap = SSDiplomatPredictfd()
        addSubview(diplomatap)
        diplomatap.snp.makeConstraints { make in
            make.top.equalTo(diplomatti.snp.bottom).offset(7)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        self.diplomatap = diplomatap
        diplomatap.diplomatchange = { evid in
            self.diplomatchange?(evid)
        }
        diplomatap.diplomatff = {
            self.diplomatff?()
        }
        diplomatap.diplomatffind = {
            self.diplomatffind?()
        }
    }
    

}
