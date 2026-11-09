//
//  SSSoldierPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

struct SSSoldierPredictEvidence {
    var soldieram: String = "50000"
    var soldierdu: Float = 5
    var soldierir: Float = 3
}

class SSSoldierPredict: UIView {
    
    var soldierultblock: ((SSSoldierPredictEvidence) -> Void)?
    
    weak var soldieramv:SSSoldierPredictField!
    weak var soldierduv:SSSoldierPredictsli!
    weak var soldierirv:SSSoldierPredictsli!

    var soldierult: SSSoldierPredictEvidence = SSSoldierPredictEvidence() {
        didSet {
            soldieramv.text = soldierult.soldieram
            soldierduv.slivel = soldierult.soldierdu
            soldierirv.slivel = soldierult.soldierir
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        soldier_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        soldier_stepui()
    }
    
    func soldier_stepui() {
        let soldieramti = UILabel()
        soldieramti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        soldieramti.text = "Total loan amount"
        soldieramti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(soldieramti)
        soldieramti.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(20)
        }
        
        let soldieramv = SSSoldierPredictField()
        addSubview(soldieramv)
        soldieramv.snp.makeConstraints { make in
            make.top.equalTo(soldieramti.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(17)
            make.right.equalToSuperview().offset(-17)
            make.height.equalTo(48)
        }
        self.soldieramv = soldieramv
        soldieramv.soldierult = { rult in
            self.soldierult.soldieram = rult
            self.soldierultblock?(self.soldierult)
        }
        
        let soldieramli = UIView()
        soldieramli.backgroundColor = KKToolUtils.color_from_hex("#FF202020")
        addSubview(soldieramli)
        soldieramli.snp.makeConstraints { make in
            make.top.equalTo(soldieramv.snp.bottom).offset(11)
            make.left.right.equalTo(soldieramv)
            make.height.equalTo(1)
        }
        
        let soldierduv = SSSoldierPredictsli()
        soldierduv.slimax = 25
        addSubview(soldierduv)
        soldierduv.snp.makeConstraints { make in
            make.top.equalTo(soldieramli.snp.bottom)
            make.left.right.equalTo(soldieramv)
        }
        soldierduv.soldierult = { rult in
            self.soldierult.soldierdu = Float(rult)
            self.soldierultblock?(self.soldierult)
        }
        self.soldierduv = soldierduv
        
        let soldieramduli = UIView()
        soldieramduli.backgroundColor = KKToolUtils.color_from_hex("#FF202020")
        addSubview(soldieramduli)
        soldieramduli.snp.makeConstraints { make in
            make.top.equalTo(soldierduv.snp.bottom)
            make.left.right.equalTo(soldierduv)
            make.height.equalTo(1)
        }
        
        let soldierirv = SSSoldierPredictsli()
        soldierirv.slimax = 22
        addSubview(soldierirv)
        soldierirv.snp.makeConstraints { make in
            make.top.equalTo(soldieramduli.snp.bottom)
            make.left.right.equalTo(soldieramv)
        }
        soldierirv.soldierult = { rult in
            self.soldierult.soldierir = Float(rult)
            self.soldierultblock?(self.soldierult)
        }
        self.soldierirv = soldierirv
        
    }

}
