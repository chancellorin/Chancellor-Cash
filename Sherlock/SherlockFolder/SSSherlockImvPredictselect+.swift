//
//  SSSherlockImvPredictselect+.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/6.
//

import UIKit
import KKUtilsKitSwift

extension SSSherlockImvPredict {
    
    func sherlockbttapd() {
        switch sherlocktype {
        case .sherlockdelsucc:
            KKToolUtils.clear_local_namespace()
            KKToolUtils.key_window?.rootViewController = SherlockNavigationController(rootViewController: SSDetectiveViewController())
            self.removeFromSuperview()
        case .sherlockdelfail:
            self.removeFromSuperview()
        case .sherlockwithdsucc:
            self.sherlockwithdsucc?()
            self.removeFromSuperview()
        case .sherlockmandup:
            if let upurl = URL(string: sherlockupEvid.latestVersionUrl ?? "") {
                if UIApplication.shared.canOpenURL(upurl) {
                    UIApplication.shared.open(upurl)
                }
            }
        default:
            break
        }
    }
    
    func sherlocklebttapd() {
        switch sherlocktype {
        case .sherlockout:
            SSSherlockDeduce.ss_deduce()
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/auth/logout") { analy in
                SSSherlockDeduce.ss_deducemiss()
                KKToolUtils.clear_local_namespace()
                KKToolUtils.key_window?.rootViewController = SherlockNavigationController(rootViewController: SSDetectiveViewController())
                self.removeFromSuperview()
            } resultfail: { analyerr in
                SSSherlockDeduce.ss_deduce(analyerr.errmsg)
                self.removeFromSuperview()
            }
        case .sherlockdelete:
            SSSherlockDeduce.ss_deduce()
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/auth/close") { analy in
                SSSherlockDeduce.ss_deducemiss()
                let sher = SSSherlockImvPredict()
                sher.sherlocktype = .sherlockdelsucc
                SSSherlockImvPredict.sherlock_alert(sher)
                self.removeFromSuperview()
            } resultfail: { analyerr in
                SSSherlockDeduce.ss_deducemiss()
                let sher = SSSherlockImvPredict()
                sher.sherlocktype = .sherlockdelfail
                SSSherlockImvPredict.sherlock_alert(sher)
                self.removeFromSuperview()
            }
        case .sherlockback:
            sherlockback?()
            self.removeFromSuperview()
        case .sherlockwithd:
            sherlockwithdback?()
            self.removeFromSuperview()
        case .sherlockup:
            SSSherlockImvPredict.sherlock_alertWinHidden(self)
        default:
            break
        }
    }
    
    func sherlockribttapd() {
        switch sherlocktype {
        case .sherlockout, .sherlockdelete, .sherlockback:
            self.removeFromSuperview()
        case .sherlockwithd:
            sherlockwithdto?()
            self.removeFromSuperview()
        case .sherlockup:
            if let upurl = URL(string: sherlockupEvid.latestVersionUrl ?? "") {
                if UIApplication.shared.canOpenURL(upurl) {
                    UIApplication.shared.open(upurl)
                }
            }
        default:
            break
        }
    }
}
