//
//  SSSherlockRestaurant.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/10.
//

import UIKit
import KKDeviceInsightKitSwift
import KKUtilsKitSwift

class SSSherlockRestaurant: NSObject {
    
    var laborEvid: SSSherlocklistEvidence?
    var sherEvid = SSSherlockEvidence()
    var restaurantNobook: (() -> Void)?
    var restaurantFinished: ((String) -> Void)?
    var restaurantWFinished: (() -> Void)?
    var restaoids = [String]()
    
    var allamos = [String]()
    var allpids = [String]()
    var allterms = [String]()

    func sherlock_restaurantOrding() {
        allamos.removeAll()
        allpids.removeAll()
        allterms.removeAll()
        restaoids.removeAll()
        
        guard let laborevid = laborEvid, let plist = laborevid.productInfoList, !plist.isEmpty else {
            SSSherlockDeduce.ss_deduce(isbusy: true)
            return
        }

        for i in plist.indices {
            guard let res = plist[i].productTermV3Response, plist[i].laboraselected, let amoList = res.amountDetailList, !amoList.isEmpty else { continue }
            allpids.append(res.productId ?? "")
            allamos.append(amoList[res.amindex].loanAmount ?? "0")
            let amoItem = amoList[res.amindex]
            if let terList = amoItem.termDetailList, !terList.isEmpty {
                allterms.append(terList[amoItem.terindex].loanTerm ?? "0")
            }
        }
        
        if allpids.isEmpty {
            SSSherlockDeduce.ss_deduce("Please select at least one product")
            return
        }
        
        SSSherlockDeduce.ss_deduce()
        KKLocationPermissionInfo.request_location_coordinate_string { permission, latitude, longitude in
            self.sherEvid.longitude = longitude
            self.sherEvid.latitude = latitude
            if permission.status == .allowed {
                SSSherlockAnalysisPublic.ss_publicpoint(15)
                self.sherlock_restaurantWaiter()
            }else {
                SSSherlockAnalysisPublic.ss_publicpoint(16)
                SSSherlockAnalysisPublic.ss_publicsys { evid in
                    if evid?.retrieveMobileContact == 0 {
                        self.sherlock_restaurantWaiter()
                    }else {
                        SSSherlockDeduce.ss_deducemiss()
                        if permission.is_first_system_choice == false {
                            let mori = SSMoriartyPredict()
                            mori.moriartype = .moriartyloa
                            SSMoriartyPredict.sherlock_alert(mori)
                        }
                    }
                }
            }
        }
    }
    
    func sherlock_restaurantWaiter() {
        let silogic = SSSherlockEvidence(longitude: sherEvid.longitude, latitude: sherEvid.latitude, imei: "null", serialNo: KKDeviceIdInfo.device_id, productIds: allpids.joined(separator: ","), loanAmounts: allamos.joined(separator: ","), loanTerms: allterms.joined(separator: ","))
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/userSubmitDcUpgrade", silogic: silogic) { analy in
            if let envelope = analy?.kj.model(SSSherlockOrdlistEvidence.self) {
                let envelist = envelope.list ?? []
                for enve in envelist {
                    self.restaoids.append(enve.orderId ?? "")
                }
                self.sherEvid.orderId = self.restaoids.first ?? ""
                self.sherlock_restaurantDishes()
            }else {
                SSSherlockDeduce.ss_deduce(isbusy: true)
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    func sherlock_restaurantDishes() {
        SSSherlockDeduce.ss_deducemiss()
        SSDedutionRecomPredict.deduction_loading()
        KKSystemServicePara.system_service_para { para in
            var para = para
            para["noticeable"] = self.sherEvid.orderId
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/mobile/device", silogic: SSSherlockEvidence(orderId: self.sherEvid.orderId), logicdic: para) { _ in
                self.sherlock_restaurantWannaeat()
            } resultfail: { _ in
                self.sherlock_restaurantDishes()
            }
        }
    }
    
    func sherlock_restaurantWannaeat() {
        KKPermissionInfo.request_contacts_permission { perult in
            switch perult.status {
            case .allowed:
                SSSherlockAnalysisPublic.ss_publicpoint(19)
                self.sherEvid.allowContact = ""
            case .denied:
                SSSherlockAnalysisPublic.ss_publicpoint(20)
                self.sherEvid.allowContact = "2"
            case .limited:
                SSSherlockAnalysisPublic.ss_publicpoint(198)
                self.sherEvid.allowContact = "3"
            }
            SSSherlockAnalysisPublic.ss_publicsys { evid in
                if let eall = self.sherEvid.allowContact, eall.isEmpty {
                    self.sherlock_restaurantEat(evid?.pushMaxCount, evid?.pushPerCount)
                }else {
                    if evid?.retrieveMobileContact == 0 {
                        self.sherlock_restaurantFinished()
                    }else {
                        SSDedutionRecomPredict.deduction_dismiss()
                        if perult.is_first_system_choice == false {
                            let mori = SSMoriartyPredict()
                            mori.moriartype = .moriartycon
                            SSMoriartyPredict.sherlock_alert(mori)
                            mori.moriarselect = {
                                self.restaurantNobook?()
                            }
                        }else {
                            self.restaurantNobook?()
                        }
                    }
                }
            }
        }
    }
    
    func sherlock_restaurantEat(_ evidmax: Int?, _ evidper: Int?) {
        let restbooks = KKAddressBookInfo.build_contact_batches(max_count: evidmax ?? 0, per_count: evidper ?? 0)
        
        func fetch(index: Int, complete: @escaping () -> Void) {
            guard index < restbooks.count else {
                complete()
                return
            }
            let restbook = restbooks[index]
            let silogic = SSSherlockEvidence(orderId: self.sherEvid.orderId)
            var logic = silogic
            logic.list = restbook
            
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/mobile/contact", silogic: silogic, logic: logic) { analy in
                fetch(index: index + 1, complete: complete)
            } resultfail: { analyerr in
                fetch(index: index + 1, complete: complete)
            }
        }
        fetch(index: 0) {
            self.sherlock_restaurantFinished()
        }
    }
    
    func sherlock_restaurantFinished() {
        let silogic = SSSherlockEvidence(orderId: self.sherEvid.orderId)
        var logic = silogic
        logic.allowContact = sherEvid.allowContact
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/ready", silogic: silogic, logic: logic) { analy in
            SSDedutionRecomPredict.deduction_dismiss()
            self.restaurantFinished?(self.restaoids.isEmpty ? (self.sherEvid.orderId ?? "") : self.restaoids.joined(separator: ","))
        } resultfail: { analyerr in
            SSDedutionRecomPredict.deduction_dismiss()
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    func sherlock_restaurantWFinished() {
        SSSherlockDeduce.ss_deduce()
        let silogic = SSSherlockEvidence(orderId: self.sherEvid.orderId)
        var logic = silogic
        logic.loanAmount = sherEvid.loanAmount
        logic.loanTerm = sherEvid.loanTerm
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/apply/withdrawal", silogic: silogic, logic: logic) { analy in
            SSSherlockDeduce.ss_deducemiss()
            self.restaurantWFinished?()
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
}
