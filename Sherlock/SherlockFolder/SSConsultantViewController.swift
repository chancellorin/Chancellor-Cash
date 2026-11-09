//
//  SSConsultantViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/24.
//

import UIKit
import SideMenuSwift
import KKUtilsKitSwift

class SSConsultantViewController: UIViewController {

    @IBOutlet weak var consultantmob: UILabel!
    
    init() {
        super.init(nibName: "SSConsultantViewController", bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysisPublic.ss_publicuser { evid in
            SSSherlockDeduce.ss_deducemiss()
            self.consultantmob.text = "+91 \(evid?.phone ?? "")"
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(consultant_closelect), name: Notification.Name("ConsultantHiddenMenue"), object: nil)
    }

    @IBAction func consultant_closelect(_ sender: Any) {
        sideMenuController?.hideMenu()
    }
    
    @IBAction func consultant_othselect(_ sender: UIButton) {
        switch sender.tag {
        case 201: navigationController?.pushViewController(SSSergeantViewController(), animated: true)
        case 202:
            self.navigationController?.pushViewController(SSAristocratViewController("https://privacy.chancellorin.com/privacy/PrivacyPolicy.html", "Privacy Policy"), animated: true)
        case 203:
            self.navigationController?.pushViewController(SSAristocratViewController("https://privacy.chancellorin.com/privacy/loanContract.html", "Terms of the Loan"), animated: true)
        case 204: navigationController?.pushViewController(SSTerroristViewController(), animated: true)
        case 205: navigationController?.pushViewController(SSClientViewController(), animated: true)
        default: break
        }
    }
    
    @IBAction func consultant_outselect(_ sender: Any) {
        let sherlockal = SSSherlockImvPredict()
        sherlockal.sherlocktype = .sherlockout
        SSSherlockImvPredict.sherlock_alert(sherlockal)
    }
    
}
