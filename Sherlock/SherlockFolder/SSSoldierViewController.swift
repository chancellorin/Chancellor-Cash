//
//  SSSoldierViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import KKUtilsKitSwift

class SSSoldierViewController: UIViewController {
    
    @IBOutlet weak var soldierpredict: SSSoldierPredict!
    @IBOutlet weak var soldierpredictult: SSSoldierPredictult!
    @IBOutlet weak var soldierultheight: NSLayoutConstraint! //185
    
    var soldierevid: SSSoldierPredictEvidence = SSSoldierPredictEvidence()
    
    @IBOutlet weak var soldierbtt: UIButton!
    
    var soldierult = false
    
    init() {
        super.init(nibName: "SSSoldierViewController", bundle: nil)
        self.navigationItem.title = "EMI Calculator"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soldierpredict.soldierultblock = { rult in
            self.soldierevid = rult
        }
        soldierpredict.soldierult = soldierevid
        if soldierult {
            soldierpredict.isUserInteractionEnabled = false
            soldierbtt.isHidden = true
            soldierbtt.setTitle("Apply Now", for: .normal)
            soldierpredictult.isHidden = false
            soldierultheight.constant = 185
            soldierpredict.soldierult = soldierevid
            soldierpredictult.soldierult = soldierevid
            SSSherlockDeduce.ss_deduce()
            SSSherlockAnalysisPublic.ss_publicuser { evid in
                SSSherlockDeduce.ss_deducemiss()
                if evid?.userStatus == 10 || evid?.userStatus == 20 {
                    self.soldierbtt.isHidden = false
                    self.soldierbtt.tag = (evid?.userStatus ?? 0) + 600
                }
            } resultfail: { analyerr in
                SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
            }
        }else {
            soldierbtt.setTitle("Submit", for: .normal)
        }
    }
    
    @IBAction func soldierbttselect(_ sender: Any) {
        if soldierult {
            if self.soldierbtt.tag == 610 {
                SSSherlockAnalysisPublic.ss_publickyc { sher in
                    self.navigationController?.pushViewController(sher, animated: true)
                }
            }else {
                navigationController?.popToRootViewController(animated: true)
            }
        }else {
            if soldierevid.soldieram.isEmpty {
                SSSherlockDeduce.ss_deduce("Please provide a valid value for \"Total loan amount\".")
                return
            }
            let soldier = SSSoldierViewController()
            soldier.soldierevid = soldierevid
            soldier.soldierult = true
            navigationController?.pushViewController(soldier, animated: true)
        }
    }

}
