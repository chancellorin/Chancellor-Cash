//
//  SSLestradePredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/30.
//

import UIKit
import KKUtilsKitSwift
import SnapKit
import StoreKit


class SSLestradePredict: SSSherlockPredict {
    
    weak var lestradestack: UIStackView!
    var lestradetag = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        lestrade_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        lestrade_stepui()
    }
    
    func lestrade_stepui() {
        sherlockliv.image = .sherlockTopyellow
        sherlockribtt.isHidden = false
        sherlocklebtt.isHidden = false
        sherlockribtt.setTitle("Submit", for: .normal)
        sherlockribtt.backgroundColor = KKToolUtils.color_from_hex("#FFFFCC00")
        sherlockribtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#66FFCC00"))
        
        let lestradestack = UIStackView()
        lestradestack.axis = .horizontal
        lestradestack.spacing = 6
        lestradestack.distribution = .fill
        sherlockbgv.addSubview(lestradestack)
        lestradestack.snp.makeConstraints { make in
            make.top.equalTo(sherlockliv.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        for i in 0..<5 {
            let lestradebttn = UIButton(type: .custom, primaryAction: UIAction { [weak self] action in
                guard let subv = action.sender as? UIButton else { return }
                self?.lestradebttntap(subv.tag)
            })
            lestradebttn.setImage(.lestradeStarN, for: .normal)
            lestradebttn.setImage(.lestradeStarS, for: .selected)
            lestradebttn.tag = 800+i+1
            lestradebttn.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 24, height: 24))
            }
            lestradestack.addArrangedSubview(lestradebttn)
        }
        self.lestradestack = lestradestack
        
        let lestradetip = UILabel()
        lestradetip.textColor = KKToolUtils.color_from_hex("#666666")
        lestradetip.font = KKToolUtils.ubuntu_font(size: 13)
        lestradetip.numberOfLines = 0
        lestradetip.text = "If you like our app, please consider giving us a five-star rating, which would greatly support us!"
        lestradetip.lineSpace()
        sherlockbgv.addSubview(lestradetip)
        lestradetip.snp.makeConstraints { make in
            make.top.equalTo(sherlockliv.snp.bottom).offset(74)
            make.left.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-28)
            make.bottom.equalToSuperview().offset(-87)
        }
        
    }
    
    func lestradebttntap(_ taptag: Int) {
        for subv in lestradestack.subviews {
            guard let sar = subv as? UIButton else { continue }
            sar.isSelected = (sar.tag <= taptag)
        }
        lestradetag = taptag - 800
    }
    
    override func sherlockribttap() {
        switch lestradetag {
        case 0:
            SSSherlockDeduce.ss_deduce("Please rate before confirming. Thanks!")
            return
        case 1,2,3:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let lesult = SSLestradePredictult()
                lesult.lestradetag = self.lestradetag
                SSLestradePredictult.sherlock_alert(lesult)
            }
        default: if let scene = KKToolUtils.key_window?.windowScene { SKStoreReviewController.requestReview(in: scene) }
        }
        SSLestradePredict.sherlock_alertWinHidden(self)
    }
    
    override func sherlocklebttap() {
        SSLestradePredict.sherlock_alertWinHidden(self)
    }

}
