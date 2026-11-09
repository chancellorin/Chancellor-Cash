//
//  SSDiplomatViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift

class SSDiplomatViewController: UIViewController {
    
    @IBOutlet weak var diptableH: NSLayoutConstraint!
    @IBOutlet weak var diplomatable: SSDiplomatTable!
    @IBOutlet weak var diplomatbtt: UIButton!
    @IBOutlet weak var diplomatip: SSDiplomatPredictLabel!
    
    var dipid: String = ""
    var dipchange = false
    
    var diplomatffind: ((String) -> Void)?

    
    init(dipti: String, dipid: String? = nil) {
        super.init(nibName: "SSDiplomatViewController", bundle: nil)
        self.navigationItem.title = dipti
        self.dipid = dipid ?? ""
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        diplomatbtt.setTitle("Continue", for: .normal)
        diplomatbtt.ss_layerShadow()
        
        diplomatable.diplomatff = { [weak self] in
            let diplomat = SSDiplomatViewController(dipti: "Find IFSC")
            diplomat.diplomatffind = {  [weak self] dffind in
                self?.diplomatable.diplomatEvids[1].diptant = dffind
                self?.diplomatable.reloadData()
            }
            self?.navigationController?.pushViewController(diplomat, animated: true)
        }
        diplomatable.diplomatffind = { [weak self] dffind in
            self?.diplomatffind?(dffind)
            self?.navigationController?.popViewController(animated: true)
        }
        
        if dipchange {
            dipid = "pay_account"
        }
        if dipid.isEmpty {
            diplomatable.diplomatEvids = SSDiplomatAlibi.diplomat_alibifind()
            diptableH.constant = CGFloat(diplomatable.diplomatEvids.count * 92 + 20)
            diplomatable.reloadData()
            return
        }
        SSSherlockAnalysisPublic.ss_publickycinit(pubid: dipid) { evids in
            self.diplomatable.diplomatEvids = evids
            self.diptableH.constant = CGFloat(evids.count * 92 + 20)
            self.diplomatable.reloadData()
            if self.dipchange {
                self.diplomatip.isHidden = false
                SSSherlockDeduce.ss_deduce()
                SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/bankcard/list") { analy in
                    SSSherlockDeduce.ss_deducemiss()
                    let envelope = analy?.kj.model(SSSherlocklistEvidence.self)
                    if let evid = envelope?.bankCardList?.first {
                        self.diplomatable.diplomatEvids[0].diptant = evid.accountName
                        self.diplomatable.diplomatEvids[1].diptant = evid.bankCode
                        self.diplomatable.diplomatEvids[2].diptant = evid.accountNo
                        if let ccd = evid.creditCard, !ccd.isEmpty {
                            self.diplomatable.diplomatEvids[4].diptant = ccd
                        }
                        self.diplomatable.reloadData()
                    }
                } resultfail: { analyerr in
                    SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
                }
            }else if self.dipid.contains("pay") {
                self.diplomatip.isHidden = false
                SSSherlockDeduce.ss_deduce()
                SSSherlockAnalysisPublic.ss_publicuser { evid in
                    SSSherlockDeduce.ss_deducemiss()
                    self.diplomatable.diplomatEvids[0].diptant = evid?.name
                    self.diplomatable.reloadData()
                } resultfail: { analyerr in
                    SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
                }
            }
        }
    }
    
    @IBAction func diplomatbttselect(_ sender: Any) {
        if dipid.isEmpty {
            diplomatable.diplomatfind(dipdex: 5)
            return
        }
        if dipchange {
            SSSherlockDeduce.ss_deduce()
            SSDiplomatAlibi.diplomat_alibi(diplomatEvids: diplomatable.diplomatEvids) { evidsult in
                let silogic = SSSherlockEvidence(accountType: "unknown", bankCode: self.diplomatable.diplomatEvids[1].diptant, accountNo: self.diplomatable.diplomatEvids[2].diptant)
                var logic = silogic
                logic.accountNoVerify = self.diplomatable.diplomatEvids[3].diptant
                logic.creditCard = self.diplomatable.diplomatEvids[4].diptant
                SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/bankcard/modify", silogic: silogic, logic: logic) { analy in
                    SSSherlockDeduce.ss_deducemiss()
                    self.navigationController?.popViewController(animated: true)
                } resultfail: { analyerr in
                    SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
                }
            }
            return
        }
        SSSherlockDeduce.ss_deduce()
        SSDiplomatAlibi.diplomat_alibi(diplomatEvids: diplomatable.diplomatEvids) { evidsult in
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/kyc/commit", silogic: SSSherlockEvidence(kycId: self.dipid), logic: SSSherlockEvidence(kycId: self.dipid, kycCommitItemList: evidsult)) { analy in
                SSSherlockDeduce.ss_deducemiss()
                SSSherlockAnalysisPublic.ss_publickyc { sher in
                    self.navigationController?.pushViewController(sher, animated: true)
                }
            } resultfail: { analyerr in
                SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
            }
        }
    }
    
}
