//
//  SSWitnessViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import KKUtilsKitSwift

class SSWitnessViewController: UIViewController {

    @IBOutlet weak var witnessbv: UIView!
    @IBOutlet weak var witnessbav: SSWitnessPredict!
    
    init() {
        super.init(nibName: "SSWitnessViewController", bundle: nil)
        self.navigationItem.title = "Bank Account"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        witnessbav.witnesselect = {
            let diplomat = SSDiplomatViewController(dipti: "Update Bank Account")
            diplomat.dipchange = true
            self.navigationController?.pushViewController(diplomat, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/bankcard/list") { analy in
            SSSherlockDeduce.ss_deducemiss()
            let envelope = analy?.kj.model(SSSherlocklistEvidence.self)
            self.witnessbv.isHidden = !(envelope?.bankCardList?.count ?? 0 > 0)
            if let evid = envelope?.bankCardList?.first {
                self.witnessbav.evid = evid
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
        
        SSSherlockAnalysisPublic.ss_publicuser { evid in
            if let evid = evid {
                self.witnessbav.eviduser = evid
            }
        }
    }


}
