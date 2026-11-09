//
//  SSWitnessPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSWitnessPredict: UIView {
    
    weak var witnessde: UILabel!
    weak var witnessna: UILabel!
    weak var witnessbn: UILabel!
    weak var witnessed: UIImageView!

    var witnesselect: (() -> Void)?

    var evid: SSSherlockPublicsysedyEvidence = SSSherlockPublicsysedyEvidence() {
        didSet {
            witnessde.text = evid.bankCode
            witnessna.text = evid.accountName
            witnessbn.text = KKToolUtils.format_card(evid.accountNo)
        }
    }
    
    var eviduser: SSSherlockPublicsysedyEvidence = SSSherlockPublicsysedyEvidence() {
        didSet {
            witnessed.isHidden = !(eviduser.payAccountModifySwitch == "on")
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        witness_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        witness_stepui()
    }
    
    func witness_stepui() {
        let witnessbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            if self.witnessed.isHidden == false {
                self.witnesselect?()
            }
        })
        witnessbtt.setBackgroundImage(.witnessBbg, for: .normal)
        addSubview(witnessbtt)
        witnessbtt.autoPinEdgesToSuperviewEdges()
        
        let witnessicon = UIImageView(image: .witnessBic)
        addSubview(witnessicon)
        witnessicon.autoSetDimensions(to: CGSizeMake(36, 36))
        witnessicon.autoPinEdge(toSuperviewEdge: .left, withInset: 23)
        witnessicon.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        
        let witnessed = UIImageView(image: .witnessBed)
        witnessed.isHidden = true
        addSubview(witnessed)
        witnessed.autoSetDimensions(to: CGSizeMake(36, 36))
        witnessed.autoPinEdge(toSuperviewEdge: .right, withInset: 22)
        witnessed.autoPinEdge(toSuperviewEdge: .top, withInset: 22)
        self.witnessed = witnessed
        
        let witnessde = UILabel()
        witnessde.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        witnessde.textColor = KKToolUtils.color_from_hex("#FFAAFF00")
        addSubview(witnessde)
        witnessde.autoPinEdge(.top, to: .top, of: witnessicon)
        witnessde.autoPinEdge(.left, to: .right, of: witnessicon, withOffset: 7)
        witnessde.autoSetDimension(.height, toSize: 20)
        self.witnessde = witnessde
        
        let witnessna = UILabel()
        witnessna.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        witnessna.textColor = .white
        addSubview(witnessna)
        witnessna.autoPinEdge(.top, to: .bottom, of: witnessde)
        witnessna.autoPinEdge(.left, to: .left, of: witnessde)
        witnessna.autoSetDimension(.height, toSize: 20)
        self.witnessna = witnessna
        
        let witnessbn = UILabel()
        witnessbn.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        witnessbn.textColor = .white
        addSubview(witnessbn)
        witnessbn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 17)
        witnessbn.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        witnessbn.autoPinEdge(toSuperviewEdge: .right, withInset: 24)
        witnessbn.autoSetDimension(.height, toSize: 24)
        self.witnessbn = witnessbn
        
        let witnessbt = UILabel()
        witnessbt.font = KKToolUtils.ubuntu_font(size: 10)
        witnessbt.textColor = KKToolUtils.color_from_hex("#4DFFFFFF")
        witnessbt.text = "Bank account number"
        addSubview(witnessbt)
        witnessbt.autoPinEdge(.bottom, to: .top, of: witnessbn)
        witnessbt.autoPinEdge(.left, to: .left, of: witnessbn)
        witnessbt.autoSetDimension(.height, toSize: 15)
        
    }

}
