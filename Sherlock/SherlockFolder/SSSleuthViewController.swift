//
//  SSSleuthViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/24.
//

import UIKit
import SideMenuSwift

class SSSleuthViewController: UIViewController, SideMenuControllerDelegate {
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuSwift.SideMenuController) {
        sleuth_analysis()
    }
    
    @IBOutlet weak var sleuthna: UILabel!
    
    @IBOutlet weak var sleuthscoll: UIScrollView!
    @IBOutlet weak var sleuthment: SSSleuthPredictment!
    @IBOutlet weak var sleuthcollv: SSSleuthCollection!
    @IBOutlet weak var sleuthprom: SSSleuthLabel!
    @IBOutlet weak var sleuthtable: SSSleuthTable!
    
    @IBOutlet weak var sleuthcollvT: NSLayoutConstraint!
    @IBOutlet weak var sleuthtableH: NSLayoutConstraint!
    
    var shererror: SSSherlockImvPredict?
    
    var sleuthVeteran = false
    var sleuthdid = true
    var sleuthdidaga = false

    init() {
        super.init(nibName: "SSSleuthViewController", bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        sleuth_analysis()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(veteransucc), name: Notification.Name("Veteransucc"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sleuthtop), name: Notification.Name("Sleuthtop"), object: nil)
        sideMenuController?.delegate = self
        sleuthcollv.sleuthcollselect = { [weak self] slevc in
            self?.navigationController?.pushViewController(slevc, animated: true)
        }
        sleuthprom.sleuthlabeltap = { [weak self] sleu in
            switch sleu {
            case 10:
                SSSherlockAnalysisPublic.ss_publickyc { sher in
                    self?.navigationController?.pushViewController(sher, animated: true)
                }
            case 51: self?.sleuthJl()
            default: self?.navigationController?.pushViewController(SSSergeantViewController(), animated: true)
            }
        }
        sleuthtable.sleuthcellselect = { [weak self] in
            guard let self = self else { return }
            if sleuthCanauto() {
                self.sleuthwannauto_analysis()
                return
            }
            switch sleuthprom.evid.userStatus {
            case 10:
                SSSherlockAnalysisPublic.ss_publickyc { [weak self] sher in
                    self?.navigationController?.pushViewController(sher, animated: true)
                }
            case 81, 41, 32, 30: self.navigationController?.pushViewController(SSSergeantViewController(), animated: true)
            default: sleuthtableRecom()
            }
        }
    }
    
    func sleuthtableRecom() {
        sleuth_laboratory_analysis() { evidlabor in
            let laboratory = SSLaboratoryViewController()
            laboratory.isLaborawithd = false
            laboratory.laborEvid = evidlabor
            self.navigationController?.pushViewController(laboratory, animated: true)
        } resultfail: { norecom, jl in
            if norecom {
                if jl {
                    self.sleuthJl(needrecom: true)
                }else {
                    self.navigationController?.pushViewController(SSSleuthRecomViewController(), animated: true)
                }
            }else {
                self.navigationController?.pushViewController(SSSleuthRecomViewController(stext: self.sleuthprom.text, bttHid: self.sleuthprom.evid.userStatus != 80), animated: true)
            }
        }
    }
    
    func sleuthJl(needrecom: Bool = false) {
        SSSherlockAnalysisPublic.ss_publicsysdeduce { [weak self] evid in
            if let evidrej = evid?.dynamicParameter?.rejectH5, !evidrej.isEmpty {
                self?.navigationController?.pushViewController(SSAristocratViewController(evidrej, "Accurate Recommendation", isaplis: true), animated: true)
            }else if needrecom {
                self?.navigationController?.pushViewController(SSSleuthRecomViewController(), animated: true)
            }
        }
    }
    
    @objc func veteransucc() {
        sleuthVeteran = true
    }
    
    @objc func sleuthtop() {
        self.sleuthscoll.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    func sleuthCanauto() -> Bool {
        if self.sleuthprom.evid.hasOrder == 0, self.sleuthprom.evid.userStatus == 20, self.sleuthprom.evid.firstLoanOptionLine == "system" {
            return true
        }
        return false
    }
    
    func sleuthCandrawal() -> Bool {
        if self.sleuthprom.evid.userStatus == 32, let slewith = self.sleuthprom.evid.withdrawalOrderId, !slewith.isEmpty {
            return true
        }
        return false
    }

    @IBAction func sleuth_menuselect(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    func sleuth_showdrawal() {
        SSSherlockDeduce.ss_deducemiss()
        let sher = SSSherlockImvPredict()
        sher.sherlocktype = .sherlockwithd
        SSSherlockImvPredict.sherlock_alert(sher)
        sher.sherlockwithdback = {}
        sher.sherlockwithdto = {
            let laboratory = SSLaboratoryViewController()
            laboratory.laboroid = self.sleuthprom.evid.withdrawalOrderId ?? ""
            laboratory.isLaborawithd = true
            self.navigationController?.pushViewController(laboratory, animated: true)
        }
    }
    

}
