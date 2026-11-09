//
//  SSDetectiveViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/24.
//

import UIKit
import KKUtilsKitSwift
import KKDeviceInsightKitSwift
import KakaJSON
import SideMenuSwift

class SSDetectiveViewController: UIViewController {

    var detecAgselect = true
    
    @IBOutlet weak var detectiveline: UIView!
    @IBOutlet weak var detectivebutt: UIButton!
    @IBOutlet weak var detectivePrpo: UIButton!
    @IBOutlet weak var detectiveSeag: UIButton!
    @IBOutlet weak var detectiveArbtt: UIButton!
    @IBOutlet weak var detectivepredict: SSDetectivePredict!
    
    init() {
        super.init(nibName: "SSDetectiveViewController", bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectiveline.ss_layerShadow(cornerRadius: 1.5, shadowOffset: CGSize(width: 0, height: 0.5), shadowColor: KKToolUtils.color_from_hex("#54AAFF00"))
        detectivebutt.ss_layerShadow(cornerRadius: 26, shadowOffset: CGSize(width: 0, height: 4), shadowColor: KKToolUtils.color_from_hex("#54AAFF00"))
        detectivePrpo.ss_underline()
        detectiveSeag.ss_underline()
    }

    @IBAction func detectiveselect(_ sender: UIButton) {
        switch sender.tag {
        case 101:
            sender.isSelected = !sender.isSelected
            detecAgselect = sender.isSelected
        case 102:
            self.navigationController?.pushViewController(SSAristocratViewController("https://privacy.chancellorin.com/privacy/PrivacyPolicy.html", "Privacy Policy"), animated: true)
        case 103:
            self.navigationController?.pushViewController(SSAristocratViewController("https://privacy.chancellorin.com/privacy/ServiceAgreement.html", "Service Agreement"), animated: true)
        default:
            if !KKAddressBookInfo.is_valid_mobile_phone(self.detectivepredict.detmob.dettextfd.text ?? "") {
                SSSherlockDeduce.ss_deduce("Please enter correct phone number")
                return
            }
            if self.detectivepredict.detotp.text?.count != 6 {
                SSSherlockDeduce.ss_deduce("Please enter correct OTP")
                return
            }
            if !self.detectiveArbtt.isSelected {
                SSSherlockDeduce.ss_deduce("Please read and accept Privacy Policy and Service Agreement")
                return
            }
            detective_analysis()
        }
    }
    
    func detective_analysis() {
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/auth/registerOrLogin", silogic: SSSherlockEvidence(mobile: self.detectivepredict.detmob.dettextfd.text ?? "", verifyCode: self.detectivepredict.detotp.text ?? "", longitude: "-360", latitude: "-360", imei: "null", serialNo: KKDeviceIdInfo.device_id)) { evid in
            let analy = evid?.kj.model(SSSherlockPublicsysedyEvidence.self)
            KKToolUtils.user_id = analy?.userId
            KKToolUtils.token = analy?.token
            KKToolUtils.mobile = KKAddressBookInfo.normalize_india_local_prefix(self.detectivepredict.detmob.dettextfd.text ?? "")
            KKSystemServicePara.system_service_para { para in
                SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/mobile/registerDevice", logicdic: para) { _ in } resultfail: { _ in }
            }
            self.detective_gosleuth()
        } resultfail: { eviderr in
            SSSherlockDeduce.ss_deduce(eviderr.errmsg, isbusy: true)
        }
    }
    
    func detective_gosleuth() {
        let contentViewController = SherlockNavigationController(rootViewController: SSSleuthViewController())
        let menuViewController = SherlockNavigationController(rootViewController: SSConsultantViewController())
        KKToolUtils.key_window?.rootViewController = SideMenuController(contentViewController: contentViewController,
        menuViewController: menuViewController)
    }
    
}
