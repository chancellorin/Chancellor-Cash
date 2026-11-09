//
//  SSSleuthLabel.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import SnapKit

class SSSleuthLabel: SSLabel {
    
    var evid: SSSherlockPublicsysedyEvidence = SSSherlockPublicsysedyEvidence() {
        didSet {
            text = evid.promptCopy
            sleuthimv.isHidden = !([10, 80, 81, 30, 32, 41, 50, 70].contains(evid.userStatus))
            if evid.userStatus == 51 {
                SSSherlockAnalysisPublic.ss_publicsys { evid in
                    if let evirej = evid?.dynamicParameter?.rejectH5, !evirej.isEmpty {
                        self.sleuthimv.isHidden = false
                    }
                }
            }
        }
    }
    
    weak var sleuthimv: UIImageView!
    
    var sleuthlabeltap: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        sleuth_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sleuth_stepui()
    }
    
    func sleuth_stepui() {
        textInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 38)
        let sleuthimv = UIImageView(image: .sleuthGo)
        sleuthimv.isHidden = true
        addSubview(sleuthimv)
        sleuthimv.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        self.sleuthimv = sleuthimv
        
        isUserInteractionEnabled = true
        let sleuthtap = UITapGestureRecognizer(target: self, action: #selector(sleuthdidtap))
        addGestureRecognizer(sleuthtap)
    }
    
    @objc func sleuthdidtap() {
        if sleuthimv.isHidden {
            return
        }
        sleuthlabeltap?(evid.userStatus ?? 0)
    }

}
