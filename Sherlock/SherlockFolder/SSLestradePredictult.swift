//
//  SSLestradePredictult.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/30.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

class SSLestradePredictult: SSSherlockImvPredict {

    weak var lestradestack: UIStackView!
    var lestradetag = 0 {
        didSet {
            for subv in lestradestack.subviews {
                guard let sar = subv as? UIButton else { continue }
                sar.isSelected = (sar.tag < lestradetag+900)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        lestrade_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        lestrade_stepui()
    }
    
    func lestrade_stepui() {
        sherlockimv.image = .alertSuccimg
        sherlockbtt.isHidden = false
        sherlockti.text = "Thank you very much!"
        sherlocktip.text = "Your comment has been sent!"
        sherlocktip.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-126)
        }
        sherlocktip.lineSpace()
        
        let lestradestack = UIStackView()
        lestradestack.axis = .horizontal
        lestradestack.spacing = 3
        lestradestack.distribution = .fill
        sherlockbgv.addSubview(lestradestack)
        lestradestack.snp.makeConstraints { make in
            make.top.equalTo(sherlocktip.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        
        for i in 0..<5 {
            let lestradebttn = UIButton(type: .custom)
            lestradebttn.setImage(.lestradeStarN, for: .normal)
            lestradebttn.setImage(.lestradeStarS, for: .selected)
            lestradebttn.tag = 900+i
            lestradebttn.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 18, height: 18))
            }
            lestradestack.addArrangedSubview(lestradebttn)
        }
        self.lestradestack = lestradestack
    }
    
    override func sherlockbttap() {
        SSLestradePredict.sherlock_alertWinHidden(self)
    }

}
