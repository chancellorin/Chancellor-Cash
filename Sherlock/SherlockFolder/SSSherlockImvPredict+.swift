//
//  SSSherlockImvPredict+.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/30.
//

import UIKit
import KKUtilsKitSwift
import SnapKit
import KKDeviceInsightKitSwift

extension SSSherlockImvPredict {
    
    func sherlockrefrash(_ shertype: SherlockBtnType) {
        switch shertype {
        case .sherlockout:
            sherlockliv.image = .sherlockTopred
            sherlockimv.image = .alertOutimg
            sherlockti.text = "Sign out"
            sherlocklebtt.isHidden = false
            sherlockribtt.isHidden = false
            sherlocklebtt.setTitle("Confirm", for: .normal)
            sherlockribtt.setTitle("Cancel", for: .normal)
            sherlockribtt.backgroundColor = KKToolUtils.color_from_hex("#FFFF4444")
            sherlockribtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#66FF4444"))
            sherlocktip.text = "Confirm sign out of your account?"
            sherlocktip.textAlignment = .center
            
        case .sherlockdelete:
            sherlockliv.image = .sherlockTopred
            sherlockimv.image = .alertDelimg
            sherlockti.text = "Delete Account"
            sherlocklebtt.isHidden = false
            sherlockribtt.isHidden = false
            sherlocklebtt.setTitle("Confirm", for: .normal)
            sherlockribtt.setTitle("Cancel", for: .normal)
            sherlockribtt.backgroundColor = KKToolUtils.color_from_hex("#FFFF4444")
            sherlockribtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#66FF4444"))
            sherlocktip.text = "Account cancellation is unavailable when your loan order is in review or processing status, or when you still have outstanding loan obligations. Account cancellation is irreversible upon confirmation. Please exercise caution before proceeding."
            sherlocktip.textInsets = UIEdgeInsets(top: 13, left: 15, bottom: 13, right: 15)
            sherlocktip.backgroundColor = KKToolUtils.color_from_hex("#0DFF4444")
            sherlocktip.ss_borderColor = KKToolUtils.color_from_hex("#2EFF4444")
            
        case .sherlockdelsucc:
            sherlockimv.image = .alertSuccimg
            sherlockti.text = "Success"
            sherlockbtt.isHidden = false
            sherlocktip.text = "Your account has been cancelled successfully."
            sherlocktip.textAlignment = .center
            
        case .sherlockdelfail:
            sherlockliv.image = .sherlockTopred
            sherlockimv.image = .alertFailimg
            sherlockti.text = "Failed"
            sherlockbtt.isHidden = false
            sherlockbtt.backgroundColor = KKToolUtils.color_from_hex("#FFFF4444")
            sherlockbtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#66FF4444"))
            sherlocktip.text = "Account cancellation unsuccessful. Please check your order."
            sherlocktip.textAlignment = .center
            
        case .sherlockback:
            sherlockliv.image = .sherlockToporange
            sherlockimv.image = .alertBackimg
            sherlockti.text = "Confirm to return?"
            sherlocklebtt.isHidden = false
            sherlockribtt.isHidden = false
            sherlocklebtt.setTitle("Confirm", for: .normal)
            sherlockribtt.setTitle("Cancel", for: .normal)
            sherlockribtt.backgroundColor = KKToolUtils.color_from_hex("#FFFFAA00")
            sherlockribtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#4FFFAA00"))
            sherlocktip.text = "Are you sure you want to suspend the ongoing authentication procedure and navigate back to the homepage?"
            sherlocktip.textInsets = UIEdgeInsets(top: 13, left: 15, bottom: 13, right: 15)
            sherlocktip.backgroundColor = KKToolUtils.color_from_hex("#0FFFAA00")
            sherlocktip.ss_borderColor = KKToolUtils.color_from_hex("#2EFFAA00")
            
        case .sherlockwithd:
            sherlockliv.image = .sherlockTopblue
            sherlockimv.image = .alertWithdimg
            sherlockti.text = "Pending"
            sherlocklebtt.isHidden = false
            sherlockribtt.isHidden = false
            sherlockribtt.setTitle("Get loan", for: .normal)
            sherlockribtt.backgroundColor = KKToolUtils.color_from_hex("#FF00CCBB")
            sherlockribtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#4F00CCBB"))
            sherlocktip.text = "You have a loan order pending confirmation. After entering the page to confirm, the funds will be transferred to your bank account immediately."
            sherlocktip.textInsets = UIEdgeInsets(top: 13, left: 15, bottom: 13, right: 15)
            sherlocktip.backgroundColor = KKToolUtils.color_from_hex("#0800CCBB")
            sherlocktip.ss_borderColor = KKToolUtils.color_from_hex("#2100CCBB")
            
        case .sherlockwithdsucc:
            sherlockliv.image = .sherlockTopblue
            sherlockimv.image = .alertWithdsuccimg
            sherlockti.text = "Success!"
            sherlockbtt.isHidden = false
            sherlockbtt.backgroundColor = KKToolUtils.color_from_hex("#FF00CCBB")
            sherlockbtt.ss_layerShadow(cornerRadius: 22, shadowColor: KKToolUtils.color_from_hex("#4F00CCBB"))
            sherlocktip.text = "Your loan application has been approved. Funds will be sent to your bank account. Please check your account later."
            sherlocktip.textInsets = UIEdgeInsets(top: 13, left: 15, bottom: 13, right: 15)
            sherlocktip.backgroundColor = KKToolUtils.color_from_hex("#0800CCBB")
            sherlocktip.ss_borderColor = KKToolUtils.color_from_hex("#2100CCBB")
            
        case .sherlockup:
            sherlockimv.image = .sherlockUpAlert
            sherlockti.text = "Upgrade"
            sherlocklebtt.isHidden = false
            sherlockribtt.isHidden = false
            sherlockribtt.setTitle("Upgrade", for: .normal)
            sherlocktip.textAlignment = .center
            sherlockupstr(sherlocktip, shersion: sherlockupEvid.latestVersion ?? "1.0.0")

        case .sherlockmandup:
            sherlockimv.image = .sherlockUpalertF
            sherlockimv.snp.updateConstraints { make in
                make.size.equalTo(CGSize(width: 65, height: 65))
            }
            sherlockti.text = "Upgrade"
            sherlockbtt.isHidden = false
            sherlockbtt.setTitle("Upgrade", for: .normal)
            sherlocktip.textAlignment = .center
            sherlockupstr(sherlocktip, shersion: sherlockupEvid.latestVersion ?? "1.0.0")
        }
        sherlocktip.lineSpace()
        
        func sherlockupstr(_ label: UILabel, shersion: String = "") {
            let fulltext = "New version found V \(shersion)"
            let attrstr = NSMutableAttributedString(string: fulltext)
            let fullrange = NSRange(location: 0, length: fulltext.count)
            attrstr.addAttribute(.foregroundColor, value: KKToolUtils.color_from_hex("#FF666666"), range: fullrange)
            attrstr.addAttribute(.font, value: KKToolUtils.ubuntu_font(size: 14), range: fullrange)
            let verprefix = "V \(shersion)"
            let versindex = fulltext.count - verprefix.count
            let verrange = NSRange(location: versindex, length: verprefix.count)
            attrstr.addAttribute(.foregroundColor, value: KKToolUtils.color_from_hex("#FFAAFF00"), range: verrange)
            attrstr.addAttribute(.font, value: KKToolUtils.ubuntu_font(size: 14, weight: .bold), range: verrange)
            label.attributedText = attrstr
        }
        
    }



}
