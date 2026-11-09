//
//  SSDiplomatPredictLabel.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSDiplomatPredictLabel: SSLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        diplomat_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        diplomat_stepui()
    }
    
    func diplomat_stepui() {
        text = "To receive the loan disbursement, kindly provide accurate, active and unfrozen bank account details."
        textInsets = UIEdgeInsets(top: 13, left: 39, bottom: 13, right: 15)
        numberOfLines = 0
        
        let diplomatimv = UIImageView(image: .diplomatImp)
        addSubview(diplomatimv)
        diplomatimv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
    }

}
