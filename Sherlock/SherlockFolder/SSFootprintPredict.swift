//
//  SSFootprintPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

class SSFootprintPredict: UIScrollView {
    
    var footpEvids = [SSSherlockNewspaperEvidence]() {
        didSet {
            for evid in footpEvids {
                let footprintablv = SSFootprintPredictablev()
                footprintablv.footpEvid = evid
                footprinstack.addArrangedSubview(footprintablv)
            }
        }
    }
    
    weak var footprinstack: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        footprint_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        footprint_stepui()
    }
    
    func footprint_stepui() {
        let footprintimv = UIImageView(image: .footprintSuccimg)
        addSubview(footprintimv)
        footprintimv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 87, height: 87))
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        let footprintip = UILabel()
        footprintip.text = "Your loan application is undergoing assessment. Disbursement to your bank account will take effect once the application is approved."
        footprintip.textColor = KKToolUtils.color_from_hex("#FF777788")
        footprintip.font = KKToolUtils.ubuntu_font(size: 13)
        footprintip.numberOfLines = 0
        footprintip.textAlignment = .center
        footprintip.lineSpace()
        addSubview(footprintip)
        footprintip.snp.makeConstraints { make in
            make.top.equalTo(footprintimv.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
            make.centerX.equalToSuperview()
        }
        
        let footprinstack = UIStackView()
        footprinstack.distribution = .equalSpacing
        footprinstack.axis = .vertical
        footprinstack.spacing = 15
        addSubview(footprinstack)
        footprinstack.snp.makeConstraints { make in
            make.top.equalTo(footprintip.snp.bottom).offset(28)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
        self.footprinstack = footprinstack
    }
}
