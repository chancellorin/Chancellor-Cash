//
//  SSSergeantViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift

class SSSergeantViewController: UIViewController {
    
    @IBOutlet weak var sergeantable: SSSergeantTable!
    

    init() {
        super.init(nibName: "SSSergeantViewController", bundle: nil)
        self.navigationItem.title = "Order history"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sergeantable.sergeantselect = { sersta, serid in
            if sersta == 32 {
                let laboratory = SSLaboratoryViewController()
                laboratory.laboroid = serid ?? ""
                laboratory.isLaborawithd = true
                self.navigationController?.pushViewController(laboratory, animated: true)
            }else if (sersta == 31) {
                SSSherlockAnalysisPublic.ss_publicsysdeduce { evid in
                    if let evidrej = evid?.dynamicParameter?.rejectH5, !evidrej.isEmpty {
                        self.navigationController?.pushViewController(SSAristocratViewController(evidrej, "Accurate Recommendation", isaplis: true), animated: true)
                    }else {
                        self.sergeantNewspaper(serid)
                    }
                }
            } else {
                self.sergeantNewspaper(serid)
            }
        }
    }
    
    func sergeantNewspaper(_ serid: String?) {
        let news = SSNewspaperViewController()
        news.newsoid = serid ?? ""
        self.navigationController?.pushViewController(news, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/list", logicdic: ["orderStatus": "66"]) { analy in
            SSSherlockDeduce.ss_deducemiss()
            let envelope = analy?.kj.model(SSSherlocklistEvidence.self)
            self.sergeantable.sergeantst = envelope?.orderList ?? []
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }


}
