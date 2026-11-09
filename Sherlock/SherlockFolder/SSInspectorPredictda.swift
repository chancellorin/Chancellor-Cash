//
//  SSInspectorPredictda.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift

class SSInspectorPredictda: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        inspector_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        inspector_stepui()
    }
    
    func inspector_stepui() {
        let inspdelintrod = UILabel()
        inspdelintrod.font = KKToolUtils.ubuntu_font(size: 11)
        inspdelintrod.textColor = KKToolUtils.color_from_hex("#333333")
        inspdelintrod.text = "Deleting your account is permanent and cannot be undone."
        inspdelintrod.textAlignment = .center
        addSubview(inspdelintrod)
        inspdelintrod.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 23, right: 0), excludingEdge: .top)
        inspdelintrod.autoSetDimension(.height, toSize: 17)
        
        let inspdel = UIButton(type: .custom, primaryAction: UIAction { _ in
            let sher = SSSherlockImvPredict()
            sher.sherlocktype = .sherlockdelete
            SSSherlockImvPredict.sherlock_alert(sher)
        })
        inspdel.backgroundColor = KKToolUtils.color_from_hex("#14FF3232")
        inspdel.ss_cornerRadius = 25
        inspdel.ss_borderColor = KKToolUtils.color_from_hex("#4DFF3232")
        inspdel.ss_borderWidth = 1
        inspdel.setTitle("Delete Account", for: .normal)
        inspdel.setImage(.inspectorDel, for: .normal)
        inspdel.setTitleColor(KKToolUtils.color_from_hex("#FFFF4444"), for: .normal)
        inspdel.titleLabel?.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        inspdel.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        addSubview(inspdel)
        inspdel.autoSetDimension(.height, toSize: 50)
        inspdel.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        inspdel.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
        inspdel.autoPinEdge(.bottom, to: .top, of: inspdelintrod, withOffset: -18)
        inspdel.autoPinEdge(toSuperviewEdge: .top, withInset: 14)
    }

}
