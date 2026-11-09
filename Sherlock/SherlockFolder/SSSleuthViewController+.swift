//
//  SSSleuthViewController+.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/6.
//

import UIKit
import KKUtilsKitSwift

extension SSSleuthViewController {
    func sleuth_analysis() {
        self.sleuthuser_analysis()
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/user/suphome", logic: SSSherlockEvidence(dcUpFlag: "1")) { analy in
            let evid = analy?.kj.model(SSSherlockPublicsysedyEvidence.self)
            if self.sleuthdid {
                self.sleuthdid = false
                SSSherlockAnalysisPublic.ss_publicupg {
                    self.sleuthevid_analysis(evid)
                }
                self.sleuthSherlockid_analysis()
            }else {
                self.sleuthevid_analysis(evid)
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    func sleuthevid_analysis(_ evid: SSSherlockPublicsysedyEvidence?) {
        SSSherlockDeduce.ss_deducemiss()
        if let evid = evid {
            self.sleuthprom.evid = evid
            if evid.userStatus ?? 0 > 10 {
                self.sleuthlist_analysis()
            }
            self.sleuthtableH.constant = 190.0
            self.sleuthtable.evid = evid
        }
        sleuthment_analysis()
    }
    
    func sleuthSherlockid_analysis() {
        SSSherlockFireplace.sherlock.sherlock_adjstid()
    }
    
    func sleuthuser_analysis() {
        SSSherlockAnalysisPublic.ss_publicuser { evid in
            self.sleuthna.text = "Chancellor Cash"
            if let slename = evid?.name, !slename.isEmpty {
                self.sleuthna.text = slename
            }
        }
    }
    
    func sleuthlist_analysis() {
        if self.sleuthVeteran, self.sleuthCanauto() {
            self.sleuthwannauto_analysis()
        }else if self.sleuthCandrawal() {
            self.sleuth_showdrawal()
        }else {
            SSSherlockDeduce.ss_deducemiss()
        }
    }
    
    func sleuthwannauto_analysis() {
        sleuth_laboratory_analysis { [weak self] evidlabor in
            guard let self = self else { return }
            sleuthVeteran = false
            let resta = SSSherlockRestaurant()
            resta.laborEvid = evidlabor
            resta.sherlock_restaurantOrding()
            resta.restaurantNobook = {
                self.sleuth_analysis()
            }
            resta.restaurantFinished = { restaoids in
                self.navigationController?.pushViewController(SSFootprintViewController(restaoids, true), animated: true)
            }
        } resultfail: { _, _ in }
    }
        
    func sleuthment_analysis() {
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/mentation/findmentation") { analy in
            let evid = analy?.kj.model(SSSherlocklistEvidence.self)
            self.sleuthment.sleuthEvids = evid?.mentationInfoList ?? []
            self.sleuthcollvT.constant = self.sleuthment.sleuthEvids.isEmpty ? 2 : 152
            self.sleuthment.isHidden = self.sleuthment.sleuthEvids.isEmpty
        } resultfail: { analyerr in }
    }
    
    func sleuth_laboratory_analysis(resultsucc: @escaping (SSSherlocklistEvidence) -> Void, resultfail: @escaping ((Bool, Bool) -> Void)) {
        CBSleuthRecomPredict.sleuth_loading()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/product/dcRecommend") { analy in
            CBSleuthRecomPredict.sleuth_dismiss()
            guard var evid = analy?.kj.model(SSSherlocklistEvidence.self), var plist = evid.productInfoList, !plist.isEmpty else {
                resultfail(true, true)
                return
            }
            for i in plist.indices {
                guard var res = plist[i].productTermV3Response, var amoList = res.amountDetailList, !amoList.isEmpty else { continue }
                let lastIdx = amoList.count - 1
                res.amindex = lastIdx
                for j in amoList.indices {
                    var amoItem = amoList[j]
                    if let terList = amoItem.termDetailList, !terList.isEmpty {
                        amoItem.terindex = terList.count - 1
                        amoList[j] = amoItem
                    }
                }
                res.amountDetailList = amoList
                plist[i].productTermV3Response = res
            }
            evid.productInfoList = plist
            resultsucc(evid)
        } resultfail: { analyerr in
            CBSleuthRecomPredict.sleuth_dismiss()
            switch analyerr.errcode {
            case 4102007:
                resultfail(true, true)
            case -1:
                resultfail(true, false)
            default:
                resultfail(false, false)
            }
        }
    }
    
}

