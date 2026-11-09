//
//  SSDetectivePredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/24.
//

import UIKit
import KKUtilsKitSwift
import SnapKit
import CHIOTPField
import KKDeviceInsightKitSwift

class SSDetectivePredict: UIView {
    
    weak var detgetbutt: UIButton!
    weak var detmob: SSDetectivePredictmob!
    weak var detotp: CHIOTPFieldTwo!

    private var detgettimer: Timer?
    private var detgettime = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        detective_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        detective_stepui()
    }
    
    func detective_stepui() {
        let detmobtt = UILabel()
        detmobtt.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        detmobtt.textColor = .white
        detmobtt.text = "MOBILE NUMBER"
        self.addSubview(detmobtt)
        detmobtt.snp.makeConstraints { make in
            make.top.equalTo(23)
            make.left.equalTo(18)
            make.height.equalTo(18)
        }
        
        let detmob = SSDetectivePredictmob()
        self.addSubview(detmob)
        detmob.snp.makeConstraints { make in
            make.top.equalTo(detmobtt.snp.bottom).offset(8)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(50)
        }
        self.detmob = detmob
        
        let detotptt = UILabel()
        detotptt.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        detotptt.textColor = .white
        detotptt.text = "OTP VERIFICATION"
        self.addSubview(detotptt)
        detotptt.snp.makeConstraints { make in
            make.top.equalTo(detmob.snp.bottom).offset(14)
            make.left.height.equalTo(detmobtt)
        }
        
        let detotp = CHIOTPFieldTwo()
        detotp.numberOfDigits = 6
        detotp.spacing = 8
        detotp.cornerRadius = 12
        detotp.boxBackgroundColor = KKToolUtils.color_from_hex("#1C1C1C")
        detotp.activeBoxBackgroundColor = KKToolUtils.color_from_hex("#1C1C1C")
        detotp.filledBoxBackgroundColor = KKToolUtils.color_from_hex("#1C1C1C")
        detotp.borderColor = .clear
        detotp.activeBorderColor = KKToolUtils.color_from_hex("#AAFF00")
        detotp.filledBorderColor = KKToolUtils.color_from_hex("#AAFF00")
        detotp.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        detotp.boxPlaceholderColor = KKToolUtils.color_from_hex("#AAFF00")
        detotp.tintColor = KKToolUtils.color_from_hex("#AAFF00")
        self.addSubview(detotp)
        detotp.snp.makeConstraints { make in
            make.top.equalTo(detotptt.snp.bottom).offset(8)
            make.left.right.equalTo(detmob)
            make.height.equalTo(50)
        }
        self.detotp = detotp
        
        let detgetbutt = UIButton(type: .custom, primaryAction: UIAction { _ in
            if !KKAddressBookInfo.is_valid_mobile_phone(self.detmob.dettextfd.text ?? "") {
                SSSherlockDeduce.ss_deduce("Please enter correct phone number")
                return
            }
            self.detective_analysis()
        })
        detgetbutt.setTitle("Get OTP", for: .normal)
        detgetbutt.setTitleColor(KKToolUtils.color_from_hex("#AAFF00"), for: .normal)
        detgetbutt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 20, weight: .bold)
        self.addSubview(detgetbutt)
        detgetbutt.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        self.detgetbutt = detgetbutt
    }
    
    func detective_analysis() {
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/sms/sendVerifySms", silogic: SSSherlockEvidence(mobile: self.detmob.dettextfd.text ?? "", verifyType: "1")) { [weak self] analy in
            SSSherlockDeduce.ss_deduce("OTP has been sent")
            self?.detective_timerstart()
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    func detective_timerstart() {
        detgettime = 60
        detgetbutt.isUserInteractionEnabled = false
        detgettimer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            guard let self = self else { return }
            detgettime -= 1
            if detgettime <= 0 {
                detective_timerstop()
                detgetbutt.setTitle("Reacquire", for: .normal)
                detgetbutt.isUserInteractionEnabled = true
            } else {
                detgetbutt.setTitle("\(detgettime)s", for: .normal)
            }
        }
    }
    
    func detective_timerstop() {
        detgettimer?.invalidate()
        detgettimer = nil
    }
    
    deinit {
        detective_timerstop()
    }

    
}
