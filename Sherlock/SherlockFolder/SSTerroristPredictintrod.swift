//
//  SSTerroristPredictintrod.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSTerroristPredictintrod: UIView {

    weak var terrintrod: SSLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        terrorist_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        terrorist_stepui()
    }
    
    func terrorist_stepui() {
        let terrintrod = SSLabel()
        terrintrod.backgroundColor = KKToolUtils.color_from_hex("#0DE94057")
        terrintrod.textInsets = UIEdgeInsets(top: 17, left: 17, bottom: 17, right: 17)
        terrintrod.textColor = KKToolUtils.color_from_hex("#FFE94057")
        terrintrod.font = KKToolUtils.ubuntu_font(size: 11, weight: .bold)
        terrintrod.ss_cornerRadius = 14
        terrintrod.ss_borderWidth = 1
        terrintrod.ss_borderColor = KKToolUtils.color_from_hex("#1AE94057")
        terrintrod.numberOfLines = 0
        terrintrod.text = "For repayment, the preferred way is to fetch the repayment link on the app. You may log into our official website for repayment if the app is out of service: KT_WEBSITELINK. Be aware that repayment will not be accepted if you use a link differing from the one shown on the app or official website.\n\nKindly contact customer support immediately if any party asks you to divide the total repayment amount into multiple transactions, or provides a repayment link inconsistent with the official link on the app or website. We can remove the service fee for you after checking the details.\n\nIn the event of suspicious activity during repayment, kindly contact customer service via email initially. Our team will provide timely support to settle your issues."
        addSubview(terrintrod)
        terrintrod.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14))
        }
        self.terrintrod = terrintrod
    }

}
