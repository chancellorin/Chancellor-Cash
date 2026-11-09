//
//  SSSherlockAnalysisPublic.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/3.
//

import UIKit

struct SSSherlockAnalysisPublic {
    
    static func ss_publicsysdeduce(resultsucc: @escaping (SSSherlockPublicsyseEvidence?) -> Void) {
        SSSherlockDeduce.ss_deduce()
        ss_publicsys { evid in
            SSSherlockDeduce.ss_deducemiss()
            resultsucc(evid)
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    static func ss_publicsys(resultsucc: @escaping (SSSherlockPublicsyseEvidence?) -> Void, resultfail: ((SSSherlockAnalysisError) -> Void)? = nil) {
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/app/config") { analy in
            let envelope = analy?.kj.model(SSSherlockPublicsyseEvidence.self)
            resultsucc(envelope)
        } resultfail: { analyerr in
            resultfail?(analyerr)
        }
    }
    
    
    static func ss_publicuser(sheradid: String? = nil, resultsucc: @escaping (SSSherlockPublicsysedyEvidence?) -> Void, resultfail: ((SSSherlockAnalysisError) -> Void)? = nil) {
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/user/info", logic: SSSherlockEvidence(adid: sheradid)) { analy in
            let envelope = analy?.kj.model(SSSherlockPublicsysedyEvidence.self)
            resultsucc(envelope)
        } resultfail: { analyerr in
            resultfail?(analyerr)
        }
    }
    
    static func ss_publickyc(resultsucc: @escaping (UIViewController) -> Void) {
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/kyc/status") { analy in
            SSSherlockDeduce.ss_deducemiss()
            let envelope = analy?.kj.model(SSSherlocklistEvidence.self)
            for evid in envelope?.kycList ?? [] {
                if evid.kycStatus == "0" {
                    switch evid.kycId {
                    case "personal": resultsucc(SSDiplomatViewController(dipti: "Personal Information", dipid: evid.kycId))
                    case "work": resultsucc(SSDiplomatViewController(dipti: "Work information", dipid: evid.kycId))
                    case "questionnaire": resultsucc(SSDiplomatViewController(dipti: "Credit Standing", dipid: evid.kycId))
                    case "pay_account": resultsucc(SSDiplomatViewController(dipti: "Bank Account", dipid: evid.kycId))
                    case "liveness": resultsucc(SSHolmesViewController(holmid: evid.kycId))
                    case "identity": resultsucc(SSJournalistViewController(jourid: evid.kycId))
                    case "tax": resultsucc(SSLandladyViewController(landid: evid.kycId))
                    case "urgent_contact": resultsucc(SSVeteranViewController(veteid: evid.kycId))
                    default: break
                    }
                    break
                }
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    static func ss_publickycinit(pubid: String, resultsucc: @escaping ([SSSherlockDiplomatEvidence]) -> Void) {
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/kyc/init", silogic: SSSherlockEvidence(kycId: pubid)) { analy in
            SSSherlockDeduce.ss_deducemiss()
            if let envelope = analy?.kj.model(SSSherlocklistEvidence.self) {
                var envlist = envelope.kycItemList?.sorted { ($0.itemSort ?? Int.min) < ($1.itemSort ?? Int.min) } ?? []
                for i in envlist.indices {
                    let item = envlist[i]
                    envlist[i].buttonList = item.buttonList?.sorted { ($0.buttonSort ?? Int.min) < ($1.buttonSort ?? Int.min) }
                }
                resultsucc(envlist)
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    static func ss_publicupg(resultsucc: @escaping () -> Void) {
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/app/versionV2") { analy in
            SSSherlockDeduce.ss_deducemiss()
            if let evid = analy?.kj.model(SSSherlockPublicsysedyEvidence.self) {
                switch evid.updateType {
                case "1":
                    let sher = SSSherlockImvPredict()
                    sher.sherlockupEvid = evid
                    sher.sherlocktype = .sherlockup
                    SSSherlockImvPredict.sherlock_alertWin(sher)
                case "2":
                    let sher = SSSherlockImvPredict()
                    sher.sherlockupEvid = evid
                    sher.sherlocktype = .sherlockmandup
                    SSSherlockImvPredict.sherlock_alertWin(sher)
                default: break
                }
            }
            resultsucc()
        } resultfail: { analyerr in
            resultsucc()
        }
    }
    
    static func ss_publicpoint(_ sher: Int) {
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/bury/record", silogic: SSSherlockEvidence(eventCode: "\(sher)", eventContent: "NULL", remark1: "NULL", remark2: "NULL", remark3: "NULL")) { _ in } resultfail: { _ in }
    }
    
}
