//
//  SSFootprintViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKUtilsKitSwift

class SSFootprintViewController: UIViewController {
    
    @IBOutlet weak var footprintpredict: SSFootprintPredict!
    
    var fooids = [String]()
    var footpEvids = [SSSherlockNewspaperEvidence]()
    var poproot = false
    
    init(_ fooids: String, _ poproot: Bool? = false) {
        super.init(nibName: "SSFootprintViewController", bundle: nil)
        self.navigationItem.title = "Success!"
        self.fooids = fooids.components(separatedBy: ",")
        self.poproot = poproot ?? false
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        footprint_sherlock()
        if let navc = navigationController as? SherlockNavigationController  {
            navc.navback = {
                self.sherlock_wannaLestrade()
            }
        }
    }
    
    func footprint_sherlock(footindex: Int = 0) {
        SSSherlockDeduce.ss_deduce()
        if footindex >= fooids.count {
            SSSherlockDeduce.ss_deducemiss()
            footprint_predict()
            return
        }
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/detailV2", silogic: SSSherlockEvidence(orderId: fooids[footindex]), logic: SSSherlockEvidence(orderId: fooids[footindex], appType: "DC")) { analy in
            if let envelope = analy?.kj.model(SSSherlockNewspaperEvidence.self) {
                self.footpEvids.append(envelope)
            }
            self.footprint_sherlock(footindex: footindex+1)
        } resultfail: { analyerr in
            self.footprint_sherlock(footindex: footindex+1)
        }
    }
    
    func footprint_predict() {
        self.footprintpredict.footpEvids = self.footpEvids
    }
    
    @IBAction func sherlock_doctor(_ sender: Any) {
        let doctor = SSDoctorViewController()
        doctor.poproot = poproot
        navigationController?.pushViewController(doctor, animated: true)
    }
    
    @IBAction func sherlock_wannapop(_ sender: Any) {
        sherlock_wannaLestrade()
    }
    
    func sherlock_wannaLestrade() {
        NotificationCenter.default.post(name: Notification.Name("Sleuthtop"), object: nil)
        if KKToolUtils.thanks != nil {
            sherlock_pop()
            return
        }
        SSSherlockAnalysisPublic.ss_publicsysdeduce { evid in
            SSSherlockDeduce.ss_deduce()
            if evid?.feedbackGuidance == "2" {
                SSSherlockAnalysisPublic.ss_publicuser { eviduser in
                    SSSherlockDeduce.ss_deducemiss()
                    if eviduser?.appUserType == "2" {
                        self.sherlock_lestrade()
                    }else {
                        self.sherlock_pop()
                    }
                } resultfail: { analyerr in
                    self.sherlock_pop()
                }
            }else if evid?.feedbackGuidance == "1" {
                self.sherlock_lestrade()
            }else {
                self.sherlock_pop()
            }
        }
    }
    
    func sherlock_lestrade() {
        KKToolUtils.thanks = "1"
        SSLestradePredict.sherlock_alertWin(SSLestradePredict())
        sherlock_pop()
    }
    
    func sherlock_pop() {
        if poproot {
            NotificationCenter.default.post(name: Notification.Name("ConsultantHiddenMenue"), object: nil)
            navigationController?.popToRootViewController(animated: true)
            return
        }
        if let navs = navigationController?.viewControllers {
            for shervc in navs {
                if let soldier = shervc as? SSNewspaperViewController {
                    self.navigationController?.popToViewController(soldier, animated: true)
                    return
                }
            }
        }
        NotificationCenter.default.post(name: Notification.Name("ConsultantHiddenMenue"), object: nil)
        navigationController?.popToRootViewController(animated: true)
    }

}
