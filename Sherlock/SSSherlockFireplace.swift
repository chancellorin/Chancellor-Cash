//
//  SSSherlockFireplace.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/10.
//

import UIKit
import AdjustSdk
import AppTrackingTransparency
import Alamofire
import KKDeviceInsightKitSwift

class SSSherlockFireplace: NSObject {
    
    static let sherlock = SSSherlockFireplace()
    private override init() {}
    
    var sherreach = NetworkReachabilityManager()
    var sheradj = ADJConfig(appToken: "tm99jj61dc74", environment: ADJEnvironmentProduction)
    
    func sherlock_netchek() {
        sherreach?.stopListening()
        sherreach?.startListening(onUpdatePerforming: { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .reachable:
                sherlock_hasnet()
            default: break
            }
        })
    }
    
    func sherlock_hasnet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            ATTrackingManager.requestTrackingAuthorization { _ in
                Adjust.initSdk(self.sheradj)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                Adjust.initSdk(self.sheradj)
            }
        }

    }
    
    func sherlock_adjstid() {
        Adjust.adid { sleadid in
            SSSherlockAnalysisPublic.ss_publicuser(sheradid: sleadid) { _ in }
        }
    }

}
