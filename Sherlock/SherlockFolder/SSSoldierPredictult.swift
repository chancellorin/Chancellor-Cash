//
//  SSSoldierPredictult.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import SnapKit


class SSSoldierPredictult: UIView {
    
    weak var soldieramli: UIView!
    weak var soldiertpli: UIView!
    weak var soldiermeli: UIView!
    
    weak var soldiertpv: SSSoldierPredictultv!
    weak var soldiermev: SSSoldierPredictultv!
    weak var soldiertiv: SSSoldierPredictultv!

    var soldierult: SSSoldierPredictEvidence = SSSoldierPredictEvidence() {
        didSet {
            KKToolUtils.emi_amount(soldierult.soldieram, duration: "\(Int(soldierult.soldierdu))", interest: "\(Int(soldierult.soldierir))") { tp, me, ti in
                soldiertpv.soldvel = tp
                soldiermev.soldvel = me
                soldiertiv.soldvel = ti
            }
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
        ss_cornerRadius = 16
        ss_dashedBorder()
        
        let soldieramti = UILabel()
        soldieramti.textColor = KKToolUtils.color_from_hex("#87AAFF00")
        soldieramti.text = "Calculation results"
        soldieramti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(soldieramti)
        soldieramti.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(17)
        }
        
        let soldieramli = UIView()
        soldieramli.ss_dashedLine()
        addSubview(soldieramli)
        soldieramli.snp.makeConstraints { make in
            make.top.equalTo(soldieramti.snp.bottom).offset(5)
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        self.soldieramli = soldieramli
        
        let soldiertpli = UIView()
        soldiertpli.ss_dashedLine()
        addSubview(soldiertpli)
        soldiertpli.snp.makeConstraints { make in
            make.top.equalTo(soldieramli.snp.bottom).offset(51)
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        self.soldiertpli = soldiertpli

        
        let soldiermeli = UIView()
        soldiermeli.ss_dashedLine()
        addSubview(soldiermeli)
        soldiermeli.snp.makeConstraints { make in
            make.top.equalTo(soldiertpli.snp.bottom).offset(45)
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        self.soldiermeli = soldiermeli

        let soldiertpv = SSSoldierPredictultv()
        soldiertpv.soldti = "Total payment"
        addSubview(soldiertpv)
        soldiertpv.snp.makeConstraints { make in
            make.top.equalTo(soldieramli.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
        }
        self.soldiertpv = soldiertpv
        
        let soldiermev = SSSoldierPredictultv()
        soldiermev.soldti = "Monthly EMI"
        addSubview(soldiermev)
        soldiermev.snp.makeConstraints { make in
            make.top.equalTo(soldiertpli.snp.bottom).offset(9)
            make.left.right.equalToSuperview()
        }
        self.soldiermev = soldiermev
        
        let soldiertiv = SSSoldierPredictultv()
        soldiertiv.soldti = "Total interest"
        addSubview(soldiertiv)
        soldiertiv.snp.makeConstraints { make in
            make.top.equalTo(soldiermeli.snp.bottom).offset(9)
            make.left.right.equalToSuperview()
        }
        self.soldiertiv = soldiertiv
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ss_dashedBorderRefrash()
        soldieramli.ss_dashedLineRefresh()
        soldiertpli.ss_dashedLineRefresh()
        soldiermeli.ss_dashedLineRefresh()
    }

}
