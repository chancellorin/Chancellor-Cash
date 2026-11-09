//
//  SSNewspaperViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift

class SSNewspaperViewController: UIViewController {
    
    @IBOutlet weak var newspaperPredict: SSNewspaperPredict!
    @IBOutlet weak var newspaperbttv: SSNewspaperPredictbtnv!
    @IBOutlet weak var newspaperBttvheight: NSLayoutConstraint!
    
    var newsoid = "1"
    var newspid: String?
    var newsdid = true

    init() {
        super.init(nibName: "SSNewspaperViewController", bundle: nil)
        self.navigationItem.title = "Credit information"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newspaperbttv.lebttselect = {
            SSSherlockDeduce.ss_deduce()
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/repay/extension", silogic: SSSherlockEvidence(orderId: self.newsoid), logic: SSSherlockEvidence(orderId: self.newsoid, periodNoList: [1])) { analy in
                SSSherlockDeduce.ss_deducemiss()
                if let envelope = analy?.kj.model(SSSherlockPublicsysedyEvidence.self) {
                    self.navigationController?.pushViewController(SSAristocratViewController(envelope.connect, "Deferment"), animated: true)
                }
            } resultfail: { analyerr in
                SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
            }
        }
        newspaperbttv.ribttselect = { newst in
            switch newst {
            case 10:
                let resta = SSSherlockRestaurant()
                resta.sherEvid.orderId = self.newsoid
                resta.sherlock_restaurantDishes()
                resta.restaurantFinished = { restaoids in
                    self.navigationController?.pushViewController(SSFootprintViewController(restaoids), animated: true)
                }
            case 36:
                let diplomat = SSDiplomatViewController(dipti: "Update Bank Account")
                diplomat.dipchange = true
                self.navigationController?.pushViewController(diplomat, animated: true)
            case 60, 61:
                SSSherlockDeduce.ss_deduce()
                SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/repay/connect", silogic: SSSherlockEvidence(orderId: self.newsoid), logic: SSSherlockEvidence(orderId: self.newsoid, periodNoList: [1])) { analy in
                    SSSherlockDeduce.ss_deducemiss()
                    if let envelope = analy?.kj.model(SSSherlockPublicsysedyEvidence.self) {
                        self.navigationController?.pushViewController(SSAristocratViewController(envelope.connect, "Repayment"), animated: true)
                    }
                } resultfail: { analyerr in
                    SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
                }
            default: break
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/order/detailV2", silogic: SSSherlockEvidence(orderId: newsoid), logic: SSSherlockEvidence(orderId: newsoid, productId: newspid, appType: "DC")) { analy in
            SSSherlockDeduce.ss_deducemiss()
            if let envelope = analy?.kj.model(SSSherlockNewspaperEvidence.self) {
                self.newsoid = envelope.orderDetail?.orderId ?? "1"
                self.newspid = envelope.product?.productId

                self.newspaperPredict.newspaperEvid = envelope
                self.newspaperbttv.newspaperEvid = envelope
                switch envelope.orderDetail?.orderStatus {
                case 10, 36, 60, 61:
                    self.newspaperBttvheight.constant = 90
                default:
                    self.newspaperBttvheight.constant = 0
                }
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    func sleuth_laboratory_analysis() {
        CBSleuthRecomPredict.sleuth_loading()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/product/dcRecommend") { analy in
            CBSleuthRecomPredict.sleuth_dismiss()
            guard var evid = analy?.kj.model(SSSherlocklistEvidence.self), var plist = evid.productInfoList, !plist.isEmpty else {
                return
            }
            for i in plist.indices {
                guard var res = plist[i].productTermV3Response, var amoList = res.amountDetailList, !amoList.isEmpty else { continue }
                let lastIdx = amoList.count - 1
                res.amindex = lastIdx
                for j in amoList.indices {
                    var amoItem = amoList[j]
                    if let terList = amoItem.termDetailList, !terList.isEmpty {
                        amoItem.terindex = terList.count - 1
                        amoList[j] = amoItem
                    }
                }
                res.amountDetailList = amoList
                plist[i].productTermV3Response = res
            }
            evid.productInfoList = plist
            let laboratory = SSLaboratoryViewController()
            laboratory.isLaborawithd = false
            laboratory.laborEvid = evid
            self.navigationController?.pushViewController(laboratory, animated: true)
        } resultfail: { analyerr in
            CBSleuthRecomPredict.sleuth_dismiss()
            self.navigationController?.pushViewController(SSSleuthRecomViewController(), animated: true)
        }
    }

}
