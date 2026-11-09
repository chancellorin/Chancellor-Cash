//
//  SSWitnessPredictLabel.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import KKUtilsKitSwift

class SSWitnessPredictLabel: SSLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        witness_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        witness_stepui()
    }
    
    func witness_stepui() {
        text = "Bank card information is editable via the bank card logo. Bank account modification will be unavailable as long as your loan order is in review status."
        textInsets = UIEdgeInsets(top: 17, left: 59, bottom: 17, right: 17)
        font = KKToolUtils.ubuntu_font(size: 13)
        
        let witnessimv = UIImageView(image: .witnessImp)
        addSubview(witnessimv)
        witnessimv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
    }
}
