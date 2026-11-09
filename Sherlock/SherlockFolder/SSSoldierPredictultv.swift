//
//  SSSoldierPredictultv.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSSoldierPredictultv: UIView {

    var soldti: String = "" {
        didSet {
            soldierti.text = soldti
        }
    }
    
    var soldvel: String = "" {
        didSet {
            soldiervel.text = "₹\(KKToolUtils.format_amount(soldvel))"
        }
    }
    
    weak var soldierti: UILabel!
    weak var soldiervel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        soldier_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        soldier_stepui()
    }
    
    func soldier_stepui() {
        let soldierti = UILabel()
        soldierti.textColor = KKToolUtils.color_from_hex("#FF666666")
        soldierti.font = KKToolUtils.ubuntu_font(size: 13)
        addSubview(soldierti)
        soldierti.autoPinEdge(toSuperviewEdge: .top)
        soldierti.autoPinEdge(toSuperviewEdge: .bottom)
        soldierti.autoPinEdge(toSuperviewEdge: .left, withInset: 18)
        soldierti.autoSetDimension(.height, toSize: 27)
        self.soldierti = soldierti
        
        let soldiervel = UILabel()
        soldiervel.textColor = KKToolUtils.color_from_hex("#FFAAAAAA")
        soldiervel.text = "₹"
        soldiervel.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        addSubview(soldiervel)
        soldiervel.autoPinEdge(toSuperviewEdge: .top)
        soldiervel.autoPinEdge(toSuperviewEdge: .bottom)
        soldiervel.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        self.soldiervel = soldiervel
    }

}
