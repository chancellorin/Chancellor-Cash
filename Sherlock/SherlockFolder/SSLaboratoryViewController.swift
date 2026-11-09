//
//  SSLaboratoryViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKUtilsKitSwift

let laboratoryColor = KKToolUtils.color_from_hex("#FFAAFF00")
let laboratorywithdColor = KKToolUtils.color_from_hex("#FF00CCBB")
let laboratorywithdColorshadow = KKToolUtils.color_from_hex("#5400CCBB")

class SSLaboratoryViewController: UIViewController {
    
    @IBOutlet weak var laboratoryPredict: SSLaboratoryPredict!
    
    @IBOutlet weak var laboratoryTotlbtt: UIButton!
    @IBOutlet weak var laboratoryArbtt: UIButton!
    @IBOutlet weak var laboratorybtt: UIButton!
    @IBOutlet weak var laboratorybttop: NSLayoutConstraint!
    
    var laboroid = "1"
    var laborpid: String?
    
    var laborEvid = SSSherlocklistEvidence() {
        didSet {
            if let evids = laborEvid.productInfoList {
                laboroid = evids.first?.orderId ?? "1"
                laborpid = evids.first?.productId
            }else {
                laborEvid.amountDetailList?.sort {
                    let v1 = Float($0.loanAmount ?? "") ?? 0
                    let v2 = Float($1.loanAmount ?? "") ?? 0
                    return v1 > v2
                }
                laboroid = laborEvid.orderId ?? "1"
                laborpid = laborEvid.productId
            }
        }
    }

    var isLaborawithd = false
    
    init() {
        super.init(nibName: "SSLaboratoryViewController", bundle: nil)
        self.navigationItem.title = "Credit information"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLaborawithd {
            laboratorybtt.setTitle("Get loan", for: .normal)
            laboratorybtt.backgroundColor = laboratorywithdColor
            laboratorybtt.ss_layerShadow(shadowColor: laboratorywithdColorshadow)
            laboratorybttop.constant = 10
            SSSherlockDeduce.ss_deduce()
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/withdrawn/detail", silogic: SSSherlockEvidence(orderId: laboroid), logic: SSSherlockEvidence(orderId: laboroid, productId: laborpid)) { analy in
                SSSherlockDeduce.ss_deducemiss()
                if let envelope = analy?.kj.model(SSSherlocklistEvidence.self) {
                    self.laborEvid = envelope
                    self.laboratoryPredictadd()
                }
            } resultfail: { analyerr in
                SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
            }
        }else {
            laboratorybtt.setTitle("Apply Now", for: .normal)
            laboratorybtt.backgroundColor = laboratoryColor
            laboratorybtt.ss_layerShadow()
            laboratorybttop.constant = 48
            laboratoryTotlbtt.setTitle("Terms of the Loan", for: .normal)
            laboratoryTotlbtt.ss_underline()
            laboratoryPredictadd()
        }
        
        if let navc = navigationController as? SherlockNavigationController  {
            navc.navback = {
                self.sherlock_wanapop()
            }
        }
    }
    
    func laboratoryPredictadd() {
        laboratoryPredict.isLaborawithd = isLaborawithd
        laboratoryPredict.laborEvid = laborEvid
        laboratoryPredict.laboratory_stepui()
    }
    
    @IBAction func arbttselect(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func totlbttselect(_ sender: Any) {
        self.navigationController?.pushViewController(SSAristocratViewController("https://privacy.chancellorin.com/privacy/loanContract.html", "Terms of the Loan"), animated: true)
    }
    
    @IBAction func bttselect(_ sender: Any) {
        if isLaborawithd {
            let resta = SSSherlockRestaurant()
            resta.sherEvid.orderId = laboroid
            resta.sherEvid.loanAmount = laboratoryPredict.laborEvid.amountDetailList?[laboratoryPredict.laborEvid.amindex].loanAmount
            if let evid = laboratoryPredict.laborEvid.amountDetailList?[laboratoryPredict.laborEvid.amindex] {
                resta.sherEvid.loanTerm = evid.termDetailList?[evid.terindex].loanTerm
            }
            resta.sherlock_restaurantWFinished()
            resta.restaurantWFinished = {
                let sher = SSSherlockImvPredict()
                sher.sherlocktype = .sherlockwithdsucc
                SSSherlockImvPredict.sherlock_alert(sher)
                sher.sherlockwithdsucc = {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }else {
            if !laboratoryArbtt.isSelected {
                SSSherlockDeduce.ss_deduce("Please read and accept Terms of the Loan")
                return
            }
            let resta = SSSherlockRestaurant()
            resta.laborEvid = laboratoryPredict.laborEvid
            resta.sherlock_restaurantOrding()
            resta.restaurantNobook = {
                self.navigationController?.popToRootViewController(animated: true)
            }
            resta.restaurantFinished = { restaoids in
                self.navigationController?.pushViewController(SSFootprintViewController(restaoids), animated: true)
            }
        }
    }
    
    func sherlock_wanapop() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
